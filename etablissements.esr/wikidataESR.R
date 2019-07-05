#library(igraph)
library(plotly)
library(ggnetwork)
library(ggplot2)
library(intergraph)

source("wikidata.R")


etablissements <<- data.frame()
instance_ofs <<- data.frame("id"=character(),"label"=character())

## Loadings
wdesr_load_etab <- function(etab_id) {
  
  item <<- get_item(id = etab_id)

  return(
    data.frame(
    id          = etab_id,
    label       = wd_get_item_label(item),
    alias       = wd_get_item_alias(item),
    instance_of = wd_get_item_instance_of(item),
    inception   = wd_get_item_statement_as_year(item,"P571"),
    dissolved   = wd_get_item_statement_as_year(item,"P576"),
    has_part    = wd_get_item_statement_as_list(item,"P527"),
    subsidiary  = wd_get_item_statement_as_list(item,"P355"),
    replaces    = wd_get_item_statement_as_list(item,"P1365"),
    replaces_pit = wd_get_item_statement_qualifier_as_list(item,"P1365","P585"),
    replaced_by = wd_get_item_statement_as_list(item,"P1366"),
    replaced_by_pit = wd_get_item_statement_qualifier_as_list(item,"P1366","P585"),
    separated_from = wd_get_item_statement_as_list(item,"P807")
  )
  )
}

# wdesr_load_etab("Q161718100")
# wdesr_load_etab("Q3551576")
# wdesr_load_etab("Q2013017")
# wdesr_load_etab("Q61716142")

wdesr_load_etabs <- function(ids) {
  for(subids in ids) {
    for(id in subids) {
      print(paste("Loading:",id))
      r <- wdesr_load_etab(id)
      etablissements <<- rbind(etablissements,r)
    }
  }
}

wdesr_get_etab <- function(wdids) {
  wdesr_load_etabs(wdids[! wdids %in% etablissements$id])
  
  return(subset(etablissements, id %in% wdids))
}


## Graphs

wdesr_get_graph <- function(wdid,props,depth=3,labelVertex) {
  edges <- data.frame()
  
  df.from <- wdesr_get_etab(c(wdid))
  vertices <- df.from
  
  for(p in props) {
    if(is.null(unlist(df.from[,p]))) 
      next()
    
    ppit <- paste(p,'_pit',sep='')
    
    df.to <- wdesr_get_etab(unlist(df.from[,p]))
    
    ft <- data.frame(
      from=df.from$id,
      to=df.to$id,
      type=p,
      date=ifelse(ppit %in% colnames(df.from),unlist(df.from[,ppit]),NA)
      )
    edges <- rbind(edges,ft)

    if(depth==0) {
      vertices <- unique(rbind(vertices,df.to))
    } else {
      for(id in df.to$id) {
        if (!id %in% vertices$id) {
          sub <- wdesr_get_graph(id,props,depth-1)
          edges <- rbind(edges,sub$edges)
          vertices <- unique(rbind(vertices,sub$vertices))
        }
      }
    }
  }
  return(list('edges'=unique(edges), 'vertices'=unique(vertices)))
}

# x <- wdesr_get_graph("Q61716142",c('subsidiary','has_part'),1)
# x <- wdesr_get_graph("Q2302586",c('replaces'),1)


wdesr_get_graph_subhistory <-function(wdid) {
  
  df.g <- wdesr_get_graph(wdid,c('subsidiary','has_part','separated_from'),0)
  edges <- df.g$edges
  vertices <- df.g$vertices
  
  for(id in vertices$id) {
    subdfg <- wdesr_get_graph(id,c('replaces','separated_from'),-1)
    edges <- rbind(edges,subdfg$edges)
    vertices <- rbind(vertices,subdfg$vertices)
  }
  
  df.g$vertices <- unique(vertices)
  df.g$edges <- unique(edges)
  
  return(df.g)  
}


## Plots
ggplot_wdesr_graph <- function(df.g) {
  net <<- network(df.g$edges, 
                  vertex.attr=df.g$vertices %>% mutate_all(as.character) %>% arrange(id), 
                  matrix.type="edgelist", ignore.eval=FALSE)
  
  ggnet <<- ggnetwork(net, layout = "fruchtermanreingold",directed=TRUE,arrow.gap=0.05)
  
  ggplot(ggnet, aes(x = x, y = y, xend = xend, yend = yend)) +
    geom_edges(aes(color = type), arrow = arrow(length = unit(10, "pt"), type = "closed")) +
    geom_edgetext(aes(label=date)) +
    geom_nodelabel(aes(
      label = paste(alias,paste('(',inception,'-',dissolved,')',sep=''),sep='\n'), 
      fill = instance_of,
      alpha = (dissolved != "NA"))) +
    scale_alpha_discrete(labels=c("Dissolved","Active"),name='statut') +
    xlim(-0.2,1.2) +
    theme_blank()
}

# ggplot_wdesr("Q2302586",c('replaces'))

ggplotly_wdesr_graph <- function(df.g) {
  net <<- network(df.g$edges, 
                  vertex.attr=df.g$vertices %>% mutate_all(as.character) %>% arrange(id), 
                  matrix.type="edgelist", ignore.eval=FALSE)
  
  ggnet <<- ggnetwork(net, layout = "fruchtermanreingold",directed=TRUE)
  
  ggplot(ggnet, aes(x = x, y = y, xend = xend, yend = yend)) +
    geom_edges(aes(color = type, text=paste('date :',date)), 
               arrow = arrow(length = unit(10, "pt"), type = "closed")) +
    #geom_edgetext(aes(color = type, label=date)) +
    geom_nodetext(aes(
      label = alias,
      text = paste(label,instance_of,paste('(',inception,'-',dissolved,')',sep=''),paste("wikidata id:",id),sep='\n'), 
      color=instance_of)) +
    theme_blank()
  
  ggplotly(tooltip="text")
}

# ggplot_wdesr("Q2302586",graph_type="subhistory",plot_type="plotly")

ggplot_wdesr <- function(wdid,
                         props=c('subsidiary','has_part','replaces'),
                         depth=3,
                         graph_type='normal',
                         plot_type='ggplot') {
  if(graph_type == 'subhistory') {
    df.g <<- wdesr_get_graph_subhistory(wdid)
  } else {
    df.g <<- wdesr_get_graph(wdid,props,depth)
  }
  if(plot_type == 'plotly') {
    ggplotly_wdesr_graph(df.g)
  } else {
    ggplot_wdesr_graph(df.g)
  }
}

# ggplot_wdesr("Q61716142",c('subsidiary','has_part'),3)
# ggplot_wdesr("Q2302586",c('replaces'))
# ggplot_wdesr("Q157575",c('replaces'))
# ggplot_wdesr("Q3551472",c('subsidiary','has_part'),3)
# ggplot_wdesr("Q3128622",c('subsidiary','has_part'),0)

# ggplot_wdesr("Q2302586",graph_type="subhistory")



## Batches

racines <- c(
  "Q61716197",
  "Q61716142",
  "Q61716216",
  "Q61716212",
  "Q61716190",
  "Q64590454",
  "Q61716176",
  "Q16541346",
  "Q3128622",
  "Q3359833",
  "Q3551472",
  "Q3491149",
  "Q13531686",
  "Q3247880",
  "Q3551474",
  "Q1322289",
  "Q3551589",
  "Q1163431",
  "Q19370961",
  "Q3343880",
  "Q10176",
  "Q2944885",
  "Q2476558",
  "Q21994834",
  "Q20669873",
  "Q20735682")

wdesr_plot_racines <- function(racines = racines) {
  for(racine in racines) {
    print(paste("Racine :",racine))
    
    ggplot_wdesr(racine,depth=1)
    ggsave(paste(racine,".png",sep=''),width=14,height=7)
    
    ggplot_wdesr(racine,graph_type = 'subhistory')
    ggsave(paste(racine,".subhistory.png",sep=''),width=14,height=7)
  }
}

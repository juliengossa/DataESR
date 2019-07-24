# This file is part of wikidataESR.
#
# wikidataESR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# wikidataESR is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#' @author Julien Gossa, \email{gossa@unistra.fr}
#' @references \url{https://www.wikidata.org}
#' @keywords wikidata, ESR

#library(igraph)
library(WikidataR)
library(plotly)
library(ggnetwork)
library(ggplot2)
library(intergraph)
library(network)
library(dplyr)
library(scales)

#' Load the data of a university
#'
#' @param wdid the wikidata id of the university
#'
#' @return a dataframe with the data of the university
#'
#' @examples wdesr_load_item("Q3551576")
wdesr_load_item <- function(wdid) {

  item <<- WikidataR::get_item(id = wdid)

  return(
    data.frame(
    id          = wdid,
    label       = wd_get_item_label(item),
    alias       = wd_get_item_alias(item),
    nature      = wd_get_item_instance_of(item),

    fondation   = wd_get_item_statement_as_year(item,"P571"),
    dissolution = wd_get_item_statement_as_year(item,"P576"),

    associé      = wd_get_item_statement_as_list(item,"P527"),
    associé_de   = wd_get_item_statement_as_list(item,"P361"),

    composante    = wd_get_item_statement_as_list(item,"P355"),
    composante_de = wd_get_item_statement_as_list(item,"P749"),

    prédécesseur     = wd_get_item_statement_as_list(item,"P1365"),
    prédécesseur_pit = wd_get_item_statement_qualifier_as_list(item,"P1365","P585"),
    successeur       = wd_get_item_statement_as_list(item,"P1366"),
    successeur_pit   = wd_get_item_statement_qualifier_as_list(item,"P1366","P585"),

    séparé_de        = wd_get_item_statement_as_list(item,"P807"),
    séparé_de_pit    = wd_get_item_statement_qualifier_as_list(item,"P807","P585"),

    membre_de = wd_get_item_statement_as_list(item,"P463")
    )
  )
}

#' Load the data of a set of universities
#'
#' @param wdids a set of wikidata ids
#'
#' @return a dataframe with the data of the universities
#'
#' @examples wdesr_load_items(c("Q3551576","Q2013017"))
wdesr_load_items <- function(wdids) {
  for(subids in wdids) {
    for(wdid in subids) {
      print(paste("Loading:",wdid))
      r <- wdesr_load_item(wdid)
      wdesr.env$items <- rbind(wdesr.env$items,r)
    }
  }
}

#' Loader
#'
#' Get the data of a set of universities.
#' Data are cached: use \code{\link{wdesr_clear_cache}} to refresh data from wikidata.
#'
#' @param wdids a set of wikidata ids
#'
#' @return a dataframe with the data of the universities
#' @export
#'
#' @examples wdesr_get_data(c("Q3551576","Q2013017"))
wdesr_get_data <- function(wdids) {
  wdesr_load_items(wdids[! wdids %in% wdesr.env$items$id])

  return(subset(wdesr.env$items, id %in% wdids))
}


#' Get a graph from a root id, following a given set of properties
#'
#' @param wdid the wikidata id of the root
#' @param props the set of properties to follow
#' @param depth the depth of the graph (more or less) (default to 3)
#' @param active_only TRUE to filter dissolved universities (default to FALSE)
#' @param stop_at a list of type of nodes that must not be visited furthermore (default to "EPST")
#'
#' @return a list of edges and vertices
#' @export
#'
#' @examples wdesr_get_graph("Q61716176",c('composante','associé'), 1)
wdesr_get_graph <- function(wdid, props, depth = 3, active_only = FALSE, stop_at = c("EPST") ) {

  edges <- data.frame()

  df.from <- wdesr_get_data(c(wdid))
  vertices <- df.from
  vertices$depth <- depth

  for(p in props) {
    if(is.null(unlist(df.from[,p])))
      next()

    ppit <- paste(p,'_pit',sep='')

    df.to <- wdesr_get_data(unlist(df.from[,p]))

    if (active_only) df.to <- subset(df.to, is.na(dissolution))
    if (nrow(df.to) == 0) next()


    edge <- data.frame(
      from  = df.from$id,
      to    = df.to$id,
      type  = p,
      date  = ifelse(ppit %in% colnames(df.from),unlist(df.from[,ppit]),NA),
      depth = depth
      )
    edges <- rbind(edges,edge)

    df.to$depth <- depth - 1

    if(depth==1) {
      vertices <- rbind(vertices,subset(df.to, !id %in% vertices$id))

    } else {
      #stops <- subset(df.to, !id %in% vertices$id & nature %in% stop_at)
      #if (nrow(stops) > 0) vertices <- rbind(vertices, stops)
      vertices <- rbind(vertices, subset(df.to, !id %in% vertices$id & nature %in% stop_at))

      for(id in subset(df.to, !id %in% vertices$id & !nature %in% stop_at)$id) {
          sub <- wdesr_get_graph(id,props,depth-1,active_only,stop_at)
          edges <- rbind(edges,sub$edges)
          vertices <- rbind(vertices,subset(sub$vertices, !id %in% vertices$id))
      }
    }
  }
  return(list('edges'=unique(edges), 'vertices'=unique(vertices)))
}



#' Label builder.
#'
#' Build the label of the nodes.
#'
#' @param node_label either "alias", "alias_date", "long", or "long_date" (default to "alias")
#' @param alias the alias of the item
#' @param label the label of the item
#' @param fondation the foundation date of the item
#' @param dissolution the dissolution date of the item
#'
#' @return a label for a node, as a string
#'
#' @examples node_label_aes("alias", alias, label, fondation, dissolution)
wdesr_node_label_aes <- function(node_label = "alias", alias, label, fondation, dissolution) {
  switch(node_label,
         alias = {
           alias},
         alias_date = {
           paste(alias,paste('(',fondation,'-',dissolution,')',sep=''),sep='\n')},
         long = {
           label},
         long_date = {
           paste(label,paste('(',fondation,'-',dissolution,')',sep=''),sep='\n')},
         ""
  )
}

#' Get geom_nodeX function.
#'
#' Get the suitable geom_nodeX function according the node_type
#'
#' @param node_type Either "text", "text_repel", "label", or "label_repel" (default to "text")
#'
#' @return the suitable geom_nodeX function according the node_type
#'
#' @examples wdesr_node_geom("text_repel")
wdesr_node_geom <- function(node_type = "text") {
  switch(node_type,
         text = {geom_nodetext},
         text_repel = {geom_nodetext_repel},
         label = {geom_nodelabel},
         label_repel = {geom_nodelabel_repel},
         geom_blank
  )
}


#' Plot an ESR graph.
#'
#' A wrapper for ggplot2 to plot graph as returned by \code{\link{wdesr_get_graph}}.
#'
#' @param df.g a dataframe representing a graph, as returned by wdesr_get_graph
#' @param layout the layout to use to plot the graph as in \code{\link[sna]{gplot.layout}}
#' @param active_only TRUE to filter the dissolved nodes (default to FALSE)
#' @param node_sizes the size of the nodes, either a single value or a range c(min,max)
#' @param label_sizes the size of the nodes, either a single value or a range c(min,max)
#' @param node_label define the label for the nodess. Either "alias", "alias_date", "long", or "long_date" (default to "alias")
#' @param node_type define the type of drawing for the nodes. Either "text", "text_repel", "label", or "label_repel" (default to "text")
#' @param edge_label TRUE to plot dates on edges (default to "TRUE")
#' @param arrow_gap a parameter that will shorten the network edges in order to avoid overplotting edge arrows and nodes see \code{\link[ggnetwork]{fortify.network}}
#'
#' @return a ggplot2
#' @export
#'
#' @examples
#' df.aslace <- wdesr_get_graph("Q61716176",c('composante','associé'), 1)
#'
#' wdesr_ggplot_graph(df.alsace,
#'   node_size = c(10,30), label_sizes = c(3,5), arrow_gap = 0.0,
#'   node_label = "alias", node_type = "text",
#'   edge_label = FALSE)
wdesr_ggplot_graph <- function( df.g,
                                layout = "kamadakawai",
                                active_only = FALSE,
                                node_sizes = 20,
                                label_sizes = c(4,6),
                                node_label = "alias",
                                node_type = "text",
                                edge_label = TRUE,
                                arrow_gap = 0.05 ) {

  if( nrow(df.g$vertices) == 0 | nrow(df.g$edges) == 0 )
    stop("Empty ESR graph: something went wrong with the graph production parameters")

  df.g$vertices <- df.g$vertices %>% mutate_all(as.character) %>% arrange(id)
  df.g$edges$weight <- scales::rescale(as.numeric(df.g$edges$depth),c(1,2))
  geom_node_fun <- wdesr_node_geom(node_type)

  net <<- network::network(df.g$edges,
                           vertex.attr=df.g$vertices,
                           matrix.type="edgelist", ignore.eval=FALSE,
                           directed = TRUE)

  ggnet <<- ggnetwork(net,
                      layout = layout,
                      weights = "weight",
                      radii  = scales::rescale(-as.numeric(df.g$vertices$depth)),
                      arrow.gap = arrow_gap)

  g <- ggplot(ggnet, aes(x = x, y = y, xend = xend, yend = yend))
  g <- g + geom_edges(aes(linetype = type),#, size = weight),
                      arrow = arrow(length = unit(8, "pt"), type = "closed"),
                      alpha=1,
                      color="darkgrey") +
    if(edge_label) g <- g + geom_edgetext(aes(label=date))
  g <- g + geom_nodes(aes(
    color=nature,
    alpha = (dissolution != "NA")),
    size = scales::rescale(as.numeric(df.g$vertices$depth),node_sizes))
  g <- g + geom_node_fun(aes(
    label = wdesr_node_label_aes(node_label,alias,label,fondation,dissolution),
    fill = nature),
    size = scales::rescale(as.numeric(df.g$vertices$depth),label_sizes))
  g <- g + scale_alpha_manual(labels=c("dissous","actif"), values = (c(0.6,1)), name='statut')
  #g <- g + scale_size_continuous(range=c(1,10), guide=FALSE)
  g <- g + xlim(-0.2,1.2)
  g <- g + theme_blank()

  return(g)
}

# ggplotly_wdesr_graph <- function(df.g) {
#   net <<- network(df.g$edges,
#                   vertex.attr=df.g$vertices %>% mutate_all(as.character) %>% arrange(id),
#                   matrix.type="edgelist", ignore.eval=FALSE)
#
#   ggnet <<- ggnetwork(net, layout = "kamadakawai",directed=TRUE)
#
#   ggplot(ggnet, aes(x = x, y = y, xend = xend, yend = yend)) +
#     geom_edges(aes(color = type, text=paste('date :',date)),
#                arrow = arrow(length = unit(10, "pt"), type = "closed")) +
#     #geom_edgetext(aes(color = type, label=date)) +
#     geom_nodetext(aes(
#       label = alias,
#       text = paste(label,nature,paste('(',fondation,'-',dissolution,')',sep=''),paste("wikidata id:",id),sep='\n'),
#       color=nature)) +
#     theme_blank()
#
#   ggplotly(tooltip="text")
# }


#' Wrapper to load and plot ESR graphs.
#'
#' Conveniently call \code{\link{wdesr_get_graph}} and then \code{\link{wdesr_ggplot_graph}}.
#'
#' @param wdid the wikidata id of the root
#' @param props the properties to follows
#' @param depth the depth of the following
#' @param plot_type either "ggplot" or "plotly" (default to ggplot)
#' @param ... additionnal parameters for the plot; see \code{\link{wdesr_ggplot_graph}} for details
#' @param active_only TRUE to filter dissolved universities (default to FALSE)
#' @return a ggplot or a plotly
#' @export
#'
#' @examples
#' wdesr_load_and_plot("Q61716176",c('composante','associé'), 1,
#'   node_size = c(10,30), label_sizes = c(3,5), arrow_gap = 0.0,
#'   node_label = "alias", node_type = "text",
#'   edge_label = FALSE)

wdesr_load_and_plot <- function( wdid,
                                 props          = c('composante','associé'),
                                 depth          = 3,
                                 active_only    = FALSE,
                                 plot_type      = 'ggplot',
                                 ...) {

  df.g <<- wdesr_get_graph(wdid,props,depth,active_only)

  if(plot_type == 'plotly') {
    wdesr_ggplotly_graph(df.g)
  } else {
    wdesr_ggplot_graph(df.g,...)
  }
}


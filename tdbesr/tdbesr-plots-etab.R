

tdbesr_plot_primaire  <- function(rentrée, uai, var, 
                                  var.labels=NA, palette=NA, 
                                  scale_format = identity,
                                  style = tdbesr_style) {
  esr.pnl %>%
    filter(UAI==uai, Rentrée==rentrée, grepl(var,pki)) %>%
    filter(!is.na(value)) %>% 
    
    ggplot(aes(x=pki,y=value,fill=pki)) + 
    geom_bar(stat = "identity",color="black") +
    geom_text(aes(label=value_label),vjust=-0.4,size = style$text_size, fontface="bold") +
    { if(!is.na(var.labels)) scale_x_discrete(labels=var.labels) } +
    scale_y_continuous(labels = scale_format) +
    scale_fill_manual(values=palette) +
    guides(color=FALSE, fill=FALSE) +
    tdbesr_theme +
    coord_cartesian(clip = 'off') +
    theme(plot.margin = style$primaire_plot.margin)
}  


tdbesr_plot_norm <- function(rentrée, uai, vars, values="norm",
                             var.labels=NA, palette=NA,
                             mean_format = identity, style = tdbesr_style) {
  
  type <- as.character(unique(subset(esr,UAI==uai,Type))[[1]])
  
  df <- esr.pnl %>%
    filter(Type==type, Rentrée==rentrée, pki %in% vars) %>%
    mutate(pki = factor(pki,vars)) %>%
    filter(!is.na(value)) %>%
    group_by(pki) %>%
    mutate(y = norm-mean(norm))
  
  if(values == "value") {
    df$norm_label <- df$value_label
  }
  
  df.etab <- df %>% filter(UAI == uai)
  if (values == "norm")
    df.mean <- df %>% group_by(pki) %>% 
    summarise(norm_label = scales::percent(mean(norm)))
  else 
    df.mean <- df %>% group_by(pki) %>% 
    summarise(norm = mean(value)) %>%
    mutate(norm_label = value_labels(pki,norm))
  
  
  p <- ggplot(df, aes(x=pki,y=y)) + 
    geom_boxplot(aes(fill=pki), color="black", width=style$bp_width) + 
    geom_point(data = df.etab, size=style$point_size, fill=palette[1], color="black", shape=21) +
    geom_line(data = df.etab, aes(group=UAI),     color=palette[1], size=style$line_size) +
    geom_text(data = df.etab, aes(label=norm_label),     color="white",    size=style$text_size, fontface="bold") +
    geom_label(data = df.mean, aes(y=0,label=norm_label), color="black",    size=style$text_size-1, nudge_x=style$bp_text_x, hjust=1) +
    { if(!is.na(var.labels)) scale_x_discrete(labels=var.labels) } +
    scale_y_continuous(labels = percent_format) +
    scale_fill_manual(values=palette[2:6]) +
    guides(color=FALSE, fill=FALSE) +
    tdbesr_theme
  
  return(p)
}

tdbesr_plot_primaire_FIN <- function(rentrée,uai) {
  tdbesr_plot_primaire(rentrée,uai,"pki.FIN",
                       var.labels = tdbesr_labels$FIN, 
                       palette = tdbesr_colors$FIN,
                       scale_format = euro)  
}

tdbesr_plot_primaire_ETU <- function(rentrée,uai) {
  tdbesr_plot_primaire(rentrée,uai,"pki.ETU",
                       var.labels = tdbesr_labels$ETU, 
                       palette = tdbesr_colors$ETU)  
}

tdbesr_plot_primaire_ENS <- function(rentrée,uai) {
  tdbesr_plot_primaire(rentrée,uai,"pki.ENS",
                       var.labels = tdbesr_labels$ENS, 
                       palette = tdbesr_colors$ENS)  
}

tdbesr_plot_norm_ETU <- function(rentrée,uai) {
  tdbesr_plot_norm(rentrée,uai,select_pkis("pki.ETU.S")[1:3],
                   var.labels = tdbesr_labels$ETU[2:4], 
                   palette = tdbesr_colors$ETU)  
}


tdbesr_plot_norm_ENS <- function(rentrée,uai) {
  tdbesr_plot_norm(rentrée,uai,select_pkis("pki.ENS.S"),
                   var.labels = tdbesr_labels$ENS[2:5], 
                   palette = tdbesr_colors$ENS)
}

tdbesr_plot_norm_FIN <- function(rentrée,uai) {
  tdbesr_plot_norm(rentrée,uai,c(select_pkis("pki.FIN.S"),"pki.ETU.S.diplomeEtablissement"),
                   var.labels = c(tdbesr_labels$FIN[2:3], tdbesr_labels$ETU[5]),
                   palette = c(tdbesr_colors$FIN[1:3], tdbesr_colors$ETU[5]))
}

tdbesr_plot_norm_K <- function(rentrée,uai, style=tdbesr_style) {
  tdbesr_plot_norm(rentrée,uai,select_pkis("pki.K"),
                   values = "value",
                   var.labels = tdbesr_labels$K, 
                   palette = tdbesr_colors$K,
                   style=style)
}


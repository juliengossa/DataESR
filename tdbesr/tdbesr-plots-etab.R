

tdbesr_plot_primaire  <- function(rentrée, uai, lfc,
                                  style = tdbesr_style) {
  esr.pnl %>%
    filter(UAI==uai, Rentrée==rentrée, pki %in% lfc$factors) %>%
    ggplot(aes(x=pki,y=value,fill=pki)) + 
    geom_bar(stat = "identity",color="black") +
    geom_text(aes(label=value_label),vjust=-0.4,size = style$text_size, fontface="bold") +
    scale_x_discrete(labels=lfc$labels, limits=lfc$factors) +
    scale_fill_manual(values=lfc$colors, limits=lfc$factors) +
    scale_y_continuous(labels = lfc$y_labels) +
    guides(color=FALSE, fill=FALSE) +
    tdbesr_theme +
    coord_cartesian(clip = 'off') +
    theme(plot.margin = style$primaire_plot.margin)
}  



tdbesr_plot_norm <- function(rentrée, uai, lfc, 
                             type=NA,
                             omit.first = TRUE,
                             norm.values = TRUE,
                             style = tdbesr_style) {
  
  if(omit.first) {
    lfc$factors <- lfc$factors[-1]
    lfc$labels  <- lfc$labels[-1]
  }
  if(is.na(type)) type <- as.character(unique(subset(esr,UAI==uai,Type))[[1]])
  
  df <- esr.pnl %>%
    filter(Type==type, Rentrée==rentrée, pki %in% lfc$factors) %>%
    mutate(pki = factor(pki,lfc$factors)) %>%
    filter(!is.na(value)) %>%
    group_by(pki) %>%
    mutate(y = norm-mean(norm))
  
  if(!norm.values) {
    df$norm_label <- df$value_label
  }
  
  df.etab <- df %>% filter(UAI == uai)
  if (norm.values)
    df.mean <- df %>% group_by(pki) %>% 
    summarise(norm_label = scales::percent(mean(norm)))
  else 
    df.mean <- df %>% group_by(pki) %>% 
    summarise(norm = mean(value)) %>%
    mutate(norm_label = value_labels(pki,norm))
  
  
  p <- ggplot(df, aes(x=pki,y=y)) + 
    geom_violin(aes(fill=pki), color="black", width=style$bp_width) + 
    geom_point(data = df.etab, size=style$point_size, fill=lfc$colors[1], color="black", shape=21, alpha=0.9) +
    geom_line(data = df.etab, aes(group=UAI),     color=lfc$colors[1], size=style$line_size, alpha=0.9) +
    geom_text(data = df.etab, aes(label=norm_label),     color="white",    size=style$text_size, fontface="bold") +
    geom_label(data = df.mean, aes(y=0,label=norm_label), color="black",    size=style$text_size-1, nudge_x=style$bp_text_x, hjust=1) +
    scale_x_discrete(labels=lfc$labels) +
    scale_y_continuous(labels = percent_format) +
    scale_fill_manual(values=lfc$colors[-1]) +
    guides(color=FALSE, fill=FALSE) +
    tdbesr_theme
  
  return(p)
}

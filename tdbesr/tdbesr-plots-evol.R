

tdbesr_plot_evol <- function(type, rentrées, pkis, uais, 
                             plot.type="both", colors=NA, strip_labels=NA, 
                             scale_y_format=identity,
                             style = tdbesr_style) {
  
  df.evol <- esr.pnl %>% 
    filter(Type == type, Rentrée %in% rentrées, pki %in% pkis) %>%
    filter(! (UAI=="0311382J" & Rentrée==2015 & pki == "pki.K.1.proPres"), # Enlever Toulouse
           ! (UAI=="9730429D" & Rentrée==2015 & pki == "pki.K.4.titPens")) %>% # Enlever guyanes
    mutate(
      norm.evol = "valeurs absolues")
      
  
  if (plot.type != "raw") {
    df <- df.evol %>%
      group_by(pki,UAI) %>%
      arrange(Rentrée) %>%
      mutate(
        value = (value/first(value))-1,
        norm.evol = "évolution")
  }
  if (plot.type == "norm") df.evol <- df
  if (plot.type == "both") df.evol <- rbind(df.evol,df)
  
  df.evol <<- df.evol
  
  facet_scales = "free_y"
  
  ggplot(df.evol, aes(x=as.factor(Rentrée), y=value)) + 
    geom_boxplot(aes(fill=pki)) +
    geom_line(data = filter(df.evol,UAI %in% uais),
              aes(group = Libellé, colour = Libellé),
              size=2,
              arrow = arrow(length=unit(0.30,"cm"),type="closed",angle=30)) +
    facet_wrap(norm.evol~pki,drop = TRUE, scales=facet_scales, ncol=4,
               labeller = labeller(pki=function(x) strip_labels) )   +
    scale_y_continuous(labels = scale_y_format) +
    { if(!is.na(colors)) scale_fill_manual(values=colors[2:length(colors)]) } +
    { if(length(uais)==1) scale_color_manual(values=colors[1]) } +
    { if(length(uais)==1) guides(color=FALSE) } +
    guides(fill=FALSE) +
    tdbesr_theme +
    theme(axis.text.x = element_text(angle=90)) +
    { if(is.null(strip_labels)) theme(strip.text = element_blank()) } +
    { if(is.null(scale_y_format)) theme(axis.text.y = element_blank()) }
}  

tdbesr_plot_evol_K <- function(rentrée,uai) {
  type <- as.character(unique(subset(esr,UAI==uai,Type))[[1]])
  tdbesr_plot_evol(type, seq(2012,rentrée), select_pkis("pki.K"),c(uai),
                   plot.type="both",
                   colors = tdbesr_colors$K,
                   strip_labels = NULL, scale_y_format = NULL)
}






tdbesr_plot_evol <- function(rentrées, uais, lfc, type=NA,
                             plot.type="both", 
                             style = tdbesr_style,
                             noscales = TRUE) {
  
  if(is.na(type)) type <- as.character(unique(subset(esr,UAI==uai,Type))[[1]])
  
  df.evol <- esr.pnl %>% 
    filter(Type == type, Rentrée %in% rentrées, pki %in% lfc$factors, !is.na(value)) %>%
    filter(UAI!="9730429D") %>% # Enlever guyanes
    filter(! (UAI=="0640251A" & pki=="pki.K.selPfor" )) %>% # Enlever ADM PAU
    mutate(norm.evol = "absolue")
      
  
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
    facet_wrap(norm.evol~pki, drop = TRUE, scales=facet_scales, ncol=5,
               labeller = labeller(pki=function(x) lfc$labels ) ) +
    scale_y_continuous(labels = lfc$y_labels) +
    scale_fill_manual(values=lfc$colors[-1]) +
    scale_color_manual(values=lfc$colors) +
    { if(length(uais)==1) guides(color=FALSE) } +
    guides(fill=FALSE) +
    tdbesr_theme +
    theme(axis.text.x = element_text(angle=90)) +
    { if(noscales) theme(strip.text = element_blank(), axis.text.y = element_blank()) }
}  

#tdbesr_plot_evol(seq(2012,2017), c(uai.guyanne), tdbesr_lfc[["K"]])

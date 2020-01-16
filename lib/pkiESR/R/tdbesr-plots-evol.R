

pkiesr_plot_evol <- function(rentrées, uais, lfc, ilfc, type=NA,
                             plot.type="abs",
                             yzoom = 1, ydecal = 0,
                             rentrée.base = NA,
                             style = pkiesr_style(),
                             y_labels = lfc$y_labels) {

  if(is.na(type)) type <- as.character(unique(subset(esr,UAI==uais[1],Type))[[1]])
  if(is.na(rentrée.base)) rentrée.base=rentrées[1]

  df.evol <- esr.pnl %>%
    filter(Type == type, Rentrée %in% rentrées, pki == lfc$factors[ilfc]) %>%
    filter(!is.na(value)) %>%
    #filter(! (UAI=="9730429D" && pki=="pki.K.titPens") ) %>% # Enlever Guyanes
    mutate(norm.evol = "absolue")

  if (plot.type == "norm") {
    df.evol <- df.evol %>%
      group_by(pki,UAI) %>%
      arrange(Rentrée) %>%
      mutate(
        value = (value/first(value))-1,
        norm.evol = "évolution") %>%
      filter(is.finite(value))
    y_labels <- percent_format
  }

  df.uai <- filter(df.evol, UAI %in% uais)
  if(nrow(df.uai)==0) return(pkiesr_plot_missingdata)

  value.median <<- median(filter(df.evol,Rentrée == rentrée.base)$value,na.rm=TRUE)
  ecartmax <<- max(
    value.median - min(df.evol$value,na.rm = TRUE),
    max(df.evol$value,na.rm = TRUE) - value.median)
  ylim <- c(
    value.median - ecartmax * yzoom * (1-ydecal),
    value.median + ecartmax * yzoom * (1+ydecal))
  ylim[1] <- min(ylim[1],min(df.uai$value))
  ylim[2] <- max(ylim[2],max(df.uai$value))

  #if(style$plotly) df.evol <- df.uai

  p <- ggplot(df.evol, aes(x=as.factor(Rentrée), y=value)) +
    geom_hline(yintercept = value.median) +
    geom_boxplot(aes(fill=pki), fill=lfc$colors[ilfc+1], alpha=style$bp_alpha)  +
    geom_line(data = df.uai,
              aes(group = Libellé, colour = Libellé),
              size=style$line_size,
              arrow = arrow(length=unit(0.30,"cm"),type="closed",angle=30)) +
    geom_point(data = df.uai,
              aes(group = Libellé, colour = Libellé,
                  text = paste0(lfc$desc[ilfc],"\nValeur : ",value_label," ; ",y_labels(value),
                                "\nClassement : ", rang)),
              size=style$line_size+1 ) +
    scale_x_discrete(limits = as.character(rentrées)) +
    scale_y_continuous(labels = y_labels) +
    scale_color_manual(values = lfc$colors) +
    coord_cartesian(ylim=ylim)  +
    { if(length(uais) == 1) guides(color=FALSE) } +
    { if(style$title == TRUE) ggtitle(lfc$labels[ilfc]) } +
    pkiesr_theme +
    theme(axis.text.x = element_text(angle=90), ) +
    { if(style$y_scale == FALSE) theme(strip.text = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank()) } +
    { if(style$x_scale == FALSE) theme(axis.text.x = element_blank()) }

  return(p)
}




pkiesr_plot_evol_all <- function(rentrée, uai, peg.args, type=NA, yzooms=list(),
                                 style = pkiesr_style(), ...) {

  plots <- list()
  for(i in seq(1,length(peg.args))) {

    args <- append(list(
      rentrées=seq(2012,rentrée),
      type=type,
      uais=c(uai),
      style=style),
      peg.args[[i]])
    if(i < length(yzooms)) args <- append(args, list(yzoom=yzooms[i]))
    args <- c(args, ...)

    plot <- do.call(pkiesr_plot_evol, args)
    plots[[i]] <- plot
  }

  return(plots)
}


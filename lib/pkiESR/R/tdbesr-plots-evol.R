

#' Title
#'
#' @param rentr
#' @param uais
#' @param the_pki
#' @param labels.y
#' @param type
#' @param color.fill
#' @param color.line
#' @param plot.type
#' @param yzoom
#' @param ydecal
#' @param rentr
#' @param style
#' @param noscales
#' @param norentr
#' @param bp.alpha
#'
#' @return
#' @export
#'
#' @examples
pkiesr_plot_evol <- function(rentrées, uais, the_pki, labels.y = identity, type=NA,
                             color.fill = "white", color.line = "brown4",
                             plot.type="abs",
                             yzoom = 1, ydecal = 0,
                             rentrée.base = NA,
                             style = pkiesr_style,
                             noscales = FALSE,
                             norentrées = FALSE,
                             bp.alpha=0.6) {

  if(is.na(type)) type <- as.character(unique(subset(esr,UAI==uais[1],Type))[[1]])
  if(is.na(rentrée.base)) rentrée.base=rentrées[1]

  df.evol <- esr.pnl %>%
    filter(Type == type, Rentrée %in% rentrées, pki == the_pki, !is.na(value)) %>%
    mutate(norm.evol = "absolue")

  if (plot.type == "norm") {
    df.evol <- df.evol %>%
      group_by(pki,UAI) %>%
      arrange(Rentrée) %>%
      mutate(
        value = (value/first(value))-1,
        norm.evol = "évolution") %>%
      filter(is.finite(value))
    labels.y <- percent_format
  }

  df.uai <- filter(df.evol, UAI %in% uais)

  value.median <<- median(filter(df.evol,Rentrée == rentrée.base)$value,na.rm=TRUE)
  ecartmax <<- max(
    value.median - min(df.evol$value,na.rm = TRUE),
    max(df.evol$value,na.rm = TRUE) - value.median)
  ylim <- c(
    value.median - ecartmax * yzoom * (1-ydecal),
    value.median + ecartmax * yzoom * (1+ydecal))
  ylim[1] <- min(ylim[1],min(df.uai$value))
  ylim[2] <- max(ylim[2],max(df.uai$value))

  theylim <<- ylim

  p <- ggplot(df.evol, aes(x=as.factor(Rentrée), y=value)) +
    geom_hline(yintercept = value.median ) +
    geom_boxplot(aes(fill=pki), fill=color.fill, alpha=bp.alpha) +
    geom_line(data = df.uai,
              aes(group = Libellé, colour = Libellé),
              size=2,
              arrow = arrow(length=unit(0.30,"cm"),type="closed",angle=30)) +
    scale_x_discrete(limits=as.character(rentrées)) +
    scale_y_continuous(labels = labels.y) +
    scale_color_manual(values=c(color.line)) +
    { if(!is.na(ylim)) coord_cartesian(ylim=ylim) } +
    { if(length(uais)==1) guides(color=FALSE) } +
    pkiesr_theme +
    theme(axis.text.x = element_text(angle=90)) +
    { if(noscales) theme(strip.text = element_blank(), axis.text.y = element_blank(), panel.grid = element_blank()) } +
    { if(norentrées) theme(axis.text.x = element_blank()) }

  return(p)
}


#' Title
#'
#' @param rentr
#' @param uai
#' @param peg.args
#' @param type
#' @param yzooms
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
pkiesr_plot_evol_all <- function(rentrée, uai, peg.args, type=NA, yzooms=NA, ...) {

  plots <- list()
  for(i in seq(1,length(peg.args))) {

    args <- append(list(
      rentrées=seq(2012,rentrée),
      type=type,
      uais=c(uai)),
      peg.args[[i]])
    if(!is.na(yzooms)) args <- append(args, list(yzoom=yzooms[i]))
    args <- c(args, ...)

    plot <- do.call(pkiesr_plot_evol, args)
    plots[[args$the_pki]] <- plot
  }

  return(plots)
}


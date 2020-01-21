

#' Title
#'
#' @param rentr
#' @param uai
#' @param lfc
#' @param style
#'
#' @return
#' @export
#'
#' @examples
kpiesr_plot_primaire  <- function(rentrée, uai, lfc,
                                  style = kpiesr_style()) {
  df <- esr.pnl %>%
    filter(UAI==uai, Rentrée==rentrée, kpi %in% lfc$factors)

    if(nrow(filter(df,!is.na(value))) == 0)
      return(kpiesr_plot_missingdata)

    ggplot(df, aes(x=kpi,y=value,fill=kpi,text=paste0(lfc$desc,"\n",value_label))) +
      geom_bar(stat = "identity",color="black") +
      { if(!style$plotly) geom_text(aes(label=value_label), vjust=-0.4, size = style$text_size, fontface="bold") } +
      scale_x_discrete(labels=lfc$labels, limits=lfc$factors) +
      scale_fill_manual(values=lfc$colors, limits=lfc$factors) +
      scale_y_continuous(labels = lfc$y_labels) +
      guides(color=FALSE, fill=FALSE) +
      kpiesr_theme +
      coord_cartesian(clip = 'off') +
      theme(plot.margin = style$primaire_plot.margin)
}


kpiesr_kpi_stats <- function(df.stats,thekpi) {
  lapply(thekpi,function(p) {
    d <- filter(df.stats, kpi==p)
    paste0("Max. : ",first(d$max),"\nMoy. : ",first(d$mean),"\nMin. : ",first(d$min))
  })
}


#' Title
#'
#' @param rentr
#' @param uai
#' @param lfc
#' @param type
#' @param omit.first
#' @param norm.values
#' @param style
#'
#' @return
#' @export
#'
#' @examples
kpiesr_plot_norm <- function(rentrée, uai, lfc,
                             type=NA,
                             omit.first = TRUE,
                             norm.values = TRUE,
                             style = kpiesr_style()) {


  if(is.na(type)) type <- as.character(unique(subset(esr,UAI==uai,Type))[[1]])

  if(type == "Grand établissement" && lfc$factor[1] == "kpi.ADM.P.formations")
    return(kpiesr_plot_missingdata)


  if(omit.first) {
    lfc$factors <- lfc$factors[-1]
    lfc$labels  <- lfc$labels[-1]
    lfc$desc    <- lfc$desc[-1]
  }

  df <- esr.pnl %>%
    filter(Type==type, Rentrée==rentrée, kpi %in% lfc$factors) %>%
    mutate(kpi = factor(kpi,lfc$factors)) %>%
    #filter(!is.na(value)) %>%
    group_by(kpi) %>%
    mutate(y = norm-mean(norm, na.rm = TRUE)
           #rang = rank(desc(y))
           )

  if(!norm.values) {
    df$norm_label <- df$value_label
  }

  df.etab <- df %>% filter(UAI == uai)

  if (norm.values)
    df.stats <- df %>%
      filter(!is.na(norm)) %>%
      group_by(kpi) %>%
      summarise(
        mean = mean(norm),
        max = max(norm),
        min = min(norm),
        count = n()) %>%
    mutate_at(c("mean","max","min"),list(scales::percent))
  else
    df.stats <- df %>%
      filter(!is.na(value)) %>%
      group_by(kpi) %>%
      summarise(
        mean = mean(value),
        max = max(value),
        min = min(value),
        count = n()) %>%
      mutate_at(c("mean","max","min"),list(~ value_labels(kpi,.)))


  p <- ggplot(df, aes(x=kpi,y=y)) +
    geom_violin(aes(fill=kpi, text = kpiesr_kpi_stats(df.stats,kpi)),
                color="black", width=style$bp_width) +
    geom_point(data = df.etab,
               aes(text = paste0(ifelse(omit.first, "Pourcentage de : ",""),
                                 lfc$desc,
                                 "\nEcart à la moyenne : ",percent_format(y),
                                 "\nClassement : ",rang,"/", df.stats[df.stats$kpi==kpi,]$count)),
               size=style$point_size, fill=lfc$colors[1], color="black", shape=21, alpha=0.9) +
    geom_line(data = df.etab, aes(group=UAI),
              color=lfc$colors[1], size=style$line_size, alpha=0.9) +
    geom_text(data = df.etab, aes(label=norm_label, text=""),
              color="white",       size=style$text_size, fontface="bold") +
    { if(!style$plotly)
        geom_label(data = df.stats, aes(y=0,label=mean),
                   color="black", size=style$text_size-1, nudge_x=style$bp_text_x, hjust=1)
      else
        geom_text(data = df.stats, aes(y=0, label=mean, text=paste0(lfc$desc,"\nMoyenne : ", mean)),
                  color="black", size=style$text_size-1, nudge_x=style$bp_text_x, hjust=1) } +
    scale_x_discrete(labels=lfc$labels, position = style$x_scale_pos) +
    scale_y_continuous(labels = percent_format) +
    scale_fill_manual(values=lfc$colors[-1]) +
    guides(color=FALSE, fill=FALSE) +
    kpiesr_theme +
    { if(style$x_scale == FALSE) theme(axis.text.x = element_blank()) }

  return(p)
}


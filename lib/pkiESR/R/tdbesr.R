

# source("tdbesr-style.R",local = TRUE)
# source("tdbesr-plots-etab.R",local = TRUE)
# source("tdbesr-plots-evol.R",local = TRUE)

select_pkis <- function(pattern){
  grep(pattern, levels(esr.pnl$pki),value=TRUE)
}

pkiesr_pivot_norm_label <- function() {

  esr %>%
    group_by(Type,Rentrée) %>%
    select(Type,Rentrée,UAI,Libellé,starts_with("pki.")) %>%
    #rename_at(vars(starts_with("pki")), list( ~ paste(.,"value",sep="_"))) %>%

    mutate_at(vars(starts_with("pki.FIN.S")), list(norm = ~ ./pki.FIN.P.ressources)) %>%
    mutate_at(vars(starts_with("pki.ENS.S")), list(norm = ~ ./pki.ENS.P.effectif)) %>%
    mutate_at(vars(starts_with("pki.ETU.S")), list(norm = ~ ./pki.ETU.P.effectif)) %>%
    mutate_at(vars(starts_with("pki.ADM.S")), list(norm = ~ ./pki.ADM.P.formations)) %>%
    #mutate_at(vars(matches("pki.*_norm")), list( ~ (./mean(.,na.rm=TRUE))-1)) %>%
    mutate_at(vars(matches("pki.(FIN|ENS|ETU|ADM).P")), list(norm = ~ (./mean(.,na.rm=TRUE))-1)) %>%
    mutate_at(vars(starts_with("pki.K")), list(norm = ~ (./mean(.,na.rm=TRUE))-1)) %>%
    rename_at(vars(matches("pki.[^_]*$")), list( ~paste(.,"value",sep="_"))) %>%
    pivot_longer(
      cols = -c(Type,Rentrée,UAI,Libellé),
      names_to = c("pki", ".value"),
      names_sep = "_"
    ) %>%
    #filter(!is.na(value)) %>%
    mutate(
      pki = as.factor(pki),
      value_label = value_labels(pki,value),
      norm_label = norm_labels(pki,norm)
    ) %>%
    group_by(Rentrée, Type, pki) %>%
    mutate(rang = dense_rank(desc(value))) %>%
    ungroup()
}


pkiesr_add_pkis <- function (df) {
  mutate(df,
    pki.K.proPres = pki.FIN.S.ressourcesPropres / pki.FIN.P.ressources ,
    pki.K.resPetu = pki.FIN.P.ressources / (pki.ETU.S.cycle.1.L+pki.ETU.S.cycle.2.M),
    pki.K.selPfor = pki.ADM.S.sélective / pki.ADM.P.formations,
    pki.K.titPetu = pki.ENS.S.titulaires / pki.ETU.P.effectif * 100,
    pki.K.titPens = pki.ENS.S.ECtitulaires / pki.ENS.P.effectif,

    #pki.K.2.resPens = pki.FIN.P.ressources / pki.ENS.P.effectif,
    #pki.K.4.docPec  = pki.ETU.S.cycle.3.D / pki.ENS.S.2.ECtitulaires,
  )
}

pkiesr_get_uaisnamedlist <- function(esr) {
  uais <- list()
  for(type in levels(esr$Type)) {
    df <- subset(esr, Type == type, c(UAI,Libellé)) %>% unique
    uais[[type]] <- as.list(setNames(as.character(df$UAI),as.character(df$Libellé)))
  }

  return(uais)
}

pkiesr_ETL_and_save <- function() {
  # source("fr-esr-principaux-etablissements-enseignement-superieur.R",local = TRUE)
  # source("fr-esr-operateurs-indicateurs-financiers.R",local = TRUE)
  # source("fr-esr-enseignants-X-esr-public.R",local = TRUE)
  # source("fr-esr-statistiques-sur-les-effectifs-d-etudiants-inscrits-par-etablissement.R",local = TRUE)
  # source("fr-esr-parcoursup.R",local = TRUE)

  etab <- pkiesr_read.etab()
  fin <- pkiesr_read.fin()
  message("Période des données FIN : ",min(levels(fin$Rentrée)),"-",max(levels(fin$Rentrée)))
  ens <- pkiesr_read.ens()
  message("Période des données ENS : ",min(levels(ens$Rentrée)),"-",max(levels(ens$Rentrée)))
  etu <- pkiesr_read.etu()
  message("Période des données ETU : ",min(levels(etu$Rentrée)),"-",max(levels(etu$Rentrée)))
  adm <- pkiesr_read.adm()
  message("Période des données ADM : ",min(levels(adm$Rentrée)),"-",max(levels(adm$Rentrée)))

  esr <- fin %>%
    full_join(ens) %>%
    full_join(etu) %>%
    full_join(adm) %>%
    full_join(etab) %>%
    filter(!is.na(Rentrée)) %>%
    pkiesr_add_pkis()

  write.csv2(esr,"tdbesr.csv",row.names = FALSE)

  esr.pnl <- pkiesr_pivot_norm_label()

  uais <- pkiesr_get_uaisnamedlist(esr)

  #save(esr, esr.pnl, file = "tdbesr.RData")
  usethis::use_data(esr, esr.pnl, uais, overwrite = TRUE)
}

pkiesr_load <- function(...) {
  load("tdbesr.RData",...)
  esr <<- esr
  esr.pnl <<- esr.pnl
}

pkiesr_fusion <- function(uais) {
  df <- esr %>% filter(UAI %in% uais)

  info <- df %>%
    group_by(Rentrée) %>%
    summarise(
      UAI = paste(uais,collapse=('_')),
      Libellé = paste(unique(df$Libellé),collapse=('_')),
      Sigle = paste(unique(df$Sigle),collapse=('_')),
      Type = first(df$Type),
      Type.détaillé = first(df$Type.détaillé),
      Académie = first(df$Académie),
      Rattachement = NA,
      url.sitewe = NA,
      url.wikidata = NA,
      url.legifrance = NA
    )

  pkis <- df %>%
    group_by(Rentrée) %>%
    summarise_at(vars(starts_with("pki")), ~sum(.))

  merge(info,pkis) %>% pkiesr_add_pkis
}



#' Title
#'
#' @param rentr
#' @param uai
#' @param style.pki.k
#' @param style.pki
#'
#' @return
#' @export
#'
#' @examples
pkiesr_plot_all <- function(rentrée, uai,
                            style.pki.k=pkiesr_style, style.pki=pkiesr_style, ...) {

  plots <- list(
    k.norm = pkiesr_plot_norm(rentrée, uai, pkiesr_lfc[["K"]],
                              norm.values=FALSE, omit.first = FALSE,
                              style=style.pki.k, ...),
    k.evol.abs = pkiesr_plot_evol_all(rentrée, uai, peg.args,
                                      yzooms = c(0.5, 0.5, 1, 1, 0.5),
                                      plot.type="abs",
                                      noscales = TRUE),
    k.evol.norm = pkiesr_plot_evol_all(rentrée, uai, peg.args,
                                      yzooms = c(0.6, 0.6, 0.5, 0.25, 0.25),
                                      plot.type="norm",
                                      noscales = TRUE, norentrées = TRUE),

    etu.abs = pkiesr_plot_primaire(rentrée,uai,pkiesr_lfc[["ETU"]], style=style.pki, ...),
    ens.abs = pkiesr_plot_primaire(rentrée,uai,pkiesr_lfc[["ENS"]], style=style.pki,...),
    fin.abs = pkiesr_plot_primaire(rentrée,uai,pkiesr_lfc[["FIN"]], style=style.pki,...),
    adm.abs = pkiesr_plot_primaire(rentrée,uai,pkiesr_lfc[["ADM"]], style=style.pki,...),

    etu.norm = pkiesr_plot_norm(rentrée,uai,pkiesr_lfc[["ETU"]], style=style.pki,...),
    ens.norm = pkiesr_plot_norm(rentrée,uai,pkiesr_lfc[["ENS"]], style=style.pki,...),
    fin.norm = pkiesr_plot_norm(rentrée,uai,pkiesr_lfc[["FIN_N"]], style=style.pki, omit.first = FALSE, ...),
    adm.norm = pkiesr_plot_norm(rentrée,uai,pkiesr_lfc[["ADM"]], style=style.pki,...)
  )

  return(plots)
}


#' Title
#'
#' @param rentr
#' @param uai
#' @param big_style
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
pkiesr_plot_tdb <- function(rentrée, uai,
                            style.pki.k=pkiesr_style, style.pki=pkiesr_style, ...) {

  plots <- pkiesr_plot_all(rentrée, uai, style.pki.k, style.pki,...)

  pg <-
    plot_grid(ncol = 1, rel_heights = c(1,1),
              plot_grid(ncol=1, rel_heights = c(2,1,1), align = "v",
                plots$k.norm,
                plot_grid(plotlist = plots$k.evol.abs, nrow=1, align = "hv"),
                plot_grid(plotlist = plots$k.evol.norm, nrow=1, align = "hv")),
              plot_grid (ncol = 2, align = "v",
               plots$fin.abs, plots$fin.norm,
               plots$etu.abs, plots$etu.norm,
               plots$adm.abs, plots$adm.norm,
               plots$ens.abs, plots$ens.norm)
    )

  return(pg)

}

#pkiesr_plot_tdb(2017,uai)



#' Title
#'
#' @param rentr
#' @param type
#' @param pkis
#' @param labels
#'
#' @return
#' @export
#'
#' @examples
pkiesr_classement <- function(rentrée, type, pkis, labels) {

  esr.pnl %>%
    ungroup() %>%
    filter(Rentrée == rentrée, Type == type, pki %in% pkis) %>%
    select(Libellé, pki, value_label, norm_label, rang) %>%
    mutate(pki = factor(pki,levels=pkis)) %>% arrange(pki,rang) %>%
    pivot_wider(names_from = pki, values_from = c(value_label,norm_label,rang)) %>%
    select(2*length(pkis)+2, length(pkis)+2, 0:length(pkis)+1) %>%
    setNames(c("Rang","Ecart", "Libellé", labels))

}

# pkiesr_classement(rentrée, "Université",
#                  c("pki.K.resPetu", "pki.FIN.P.ressources", "pki.ETU.S.cycle.1.L", "pki.ETU.S.cycle.2.M"),
#                  c("Ressources par   \nétudiant","Ressources","Effectif L","Effectif M"))


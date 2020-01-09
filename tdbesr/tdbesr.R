library(tidyverse)
library(ggrepel)
library(plotly)
library(data.table)
library(knitr)
library(kableExtra)
library(ggthemes)
library(ggalluvial)
library(psych)
library(gridExtra)

source("tdbesr-style.R")
source("tdbesr-plots-etab.R")
source("tdbesr-plots-evol.R")

value_labels <- function(pki, value) {
  case_when(
    grepl("pki.FIN", pki)     ~ euro(value,"M"),
    pki == "pki.K.1.proPres"  ~ scales::percent(value),
    pki == "pki.K.2.resPetu"  ~ euro(value,"k"),
    pki == "pki.K.3.selPfor"  ~ scales::percent(value),
    pki == "pki.K.4.titPetu"  ~ format(round(value,1), trim=TRUE),
    pki == "pki.K.5.titPens"  ~ scales::percent(value),
    grepl("pki.", pki)   ~ format(round(value), big.mark=" ", trim=TRUE))
}

norm_labels <- function(pki, norm) {
  case_when(
    grepl("pki.....P", pki)   ~ percent_format(norm),
    TRUE                      ~ scales::percent(norm) )
}


select_pkis <- function(pattern){
  grep(pattern, levels(esr.pnl$pki),value=TRUE)
}

tdbesr_pivot_norm_label <- function(rentrée, type) {
  
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
    )
}


tdbesr_add_pkis <- function (df) {
  mutate(df,
    pki.K.1.proPres = pki.FIN.S.2.ressourcesPropres / pki.FIN.P.ressources ,
    pki.K.2.resPetu = pki.FIN.P.ressources / (pki.ETU.S.cycle.1.L+pki.ETU.S.cycle.2.M),
    pki.K.3.selPfor = pki.ADM.S.1.sélective / pki.ADM.P.formations,
    pki.K.4.titPetu = pki.ENS.S.1.titulaires / pki.ETU.P.effectif * 100,
    pki.K.5.titPens = pki.ENS.S.2.ECtitulaires / pki.ENS.P.effectif,
    
    #pki.K.2.resPens = pki.FIN.P.ressources / pki.ENS.P.effectif,
    #pki.K.4.docPec  = pki.ETU.S.cycle.3.D / pki.ENS.S.2.ECtitulaires,
  ) 
}

tdbesr_ETL_and_save <- function() {
  source("fr-esr-principaux-etablissements-enseignement-superieur.R")
  source("fr-esr-operateurs-indicateurs-financiers.R")
  source("fr-esr-enseignants-X-esr-public.R")
  source("fr-esr-statistiques-sur-les-effectifs-d-etudiants-inscrits-par-etablissement.R")
  source("fr-esr-parcoursup.R")
  
  etab <- tdesr_read.etab()
  fin <- tdesr_read.fin()
  message("Période des données FIN : ",min(levels(fin$Rentrée)),"-",max(levels(fin$Rentrée)))
  ens <- tdesr_read.ens()
  message("Période des données ENS : ",min(levels(ens$Rentrée)),"-",max(levels(ens$Rentrée)))
  etu <- tdesr_read.etu()
  message("Période des données ETU : ",min(levels(etu$Rentrée)),"-",max(levels(etu$Rentrée)))
  adm <- tdesr_read.adm()
  message("Période des données ADM : ",min(levels(adm$Rentrée)),"-",max(levels(adm$Rentrée)))
  
  esr <<- fin %>%
    full_join(ens) %>%
    full_join(etu) %>%
    full_join(adm) %>%
    full_join(etab) %>%
    filter(!is.na(Rentrée)) %>%
    tdbesr_add_pkis()
  
  write.csv2(esr,"tdbesr.csv",row.names = FALSE)
  
  esr.pnl <<- tdbesr_pivot_norm_label()  
  
  save(esr, esr.pnl, file = "tdbesr.RData")
}

tdbesr_load <- function() {
  load("tdbesr.RData")
  esr <<- esr
  esr.pnl <<- esr.pnl
}

tdbesr_fusion <- function(uais) {
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
  
  merge(info,pkis) %>% tdbesr_add_pkis
}



tdbesr_plot_tdb <- function(rentrée,uai, big_style=tdbesr_style,...) {
  
  pp.k.n <- tdbesr_plot_norm_K(rentrée,uai,style=big_style,...)
  pp.k.e <- tdbesr_plot_evol_K(rentrée,uai,...)
  
  pp.etu <- tdbesr_plot_primaire_ETU(rentrée,uai,...)
  pp.ens <- tdbesr_plot_primaire_ENS(rentrée,uai,...)  
  pp.fin <- tdbesr_plot_primaire_FIN(rentrée,uai,...)  
  pp.adm <- tdbesr_plot_primaire_ADM(rentrée,uai,...)
  
  pn.etu <- tdbesr_plot_norm_ETU(rentrée,uai,...)
  pn.ens <- tdbesr_plot_norm_ENS(rentrée,uai,...)
  pn.fin <- tdbesr_plot_norm_FIN(rentrée,uai,...)
  pn.adm <- tdbesr_plot_norm_ADM(rentrée,uai,...)
  
  grid.arrange(pp.k.n,
               pp.k.e,
               pp.etu, pn.etu,
               pp.adm, pn.adm,
               pp.ens, pn.ens,
               pp.fin, pn.fin,
               #nrow = 3, ncol=2,
               heights = c(2,2,1,1,1,1),
               layout_matrix = rbind(c(1),c(2),c(3,4),c(5,6),c(7,8),c(9,10)))
}



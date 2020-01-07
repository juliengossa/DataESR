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
    grepl("pki.E", pki)       ~ format(round(value), big.mark=" ", trim=TRUE),
    pki == "pki.K.1.proPres"  ~ scales::percent(value),
    pki == "pki.K.2.resPetu"  ~ euro(value,"k"),
    pki == "pki.K.3.titPetu"  ~ format(round(value,1), trim=TRUE),
    pki == "pki.K.4.titPens"  ~ scales::percent(value) )
}

norm_labels <- function(pki, norm) {
  case_when(
    grepl("pki.....P", pki)   ~ percent_format(norm),
    grepl("pki.FIN", pki)     ~ scales::percent(norm),
    grepl("pki.E", pki)       ~ scales::percent(norm),
    grepl("pki.K", pki)       ~ scales::percent(norm) )
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
    #mutate_at(vars(matches("pki.*_norm")), list( ~ (./mean(.,na.rm=TRUE))-1)) %>%
    mutate_at(vars(matches("pki.(FIN|ENS|ETU).P")), list(norm = ~ (./mean(.,na.rm=TRUE))-1)) %>%
    mutate_at(vars(starts_with("pki.K")), list(norm = ~ (./mean(.,na.rm=TRUE))-1)) %>%
    rename_at(vars(matches("pki.[^_]*$")), list( ~paste(.,"value",sep="_"))) %>%
    pivot_longer(
      cols = -c(Type,Rentrée,UAI,Libellé),
      names_to = c("pki", ".value"), 
      names_sep = "_"
    ) %>%
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
    pki.K.3.titPetu = pki.ENS.S.1.titulaires / pki.ETU.P.effectif * 100,
    pki.K.4.titPens = pki.ENS.S.2.ECtitulaires / pki.ENS.P.effectif
    #pki.K.2.resPens = pki.FIN.P.ressources / pki.ENS.P.effectif,
    #pki.K.4.docPec  = pki.ETU.S.cycle.3.D / pki.ENS.S.2.ECtitulaires,
  ) 
}

tdbesr_ETL_and_save <- function() {
  source("fr-esr-principaux-etablissements-enseignement-superieur.R")
  source("fr-esr-operateurs-indicateurs-financiers.R")
  source("fr-esr-enseignants-X-esr-public.R")
  source("fr-esr-statistiques-sur-les-effectifs-d-etudiants-inscrits-par-etablissement.R")
  
  
  esr <<- merge(tdesr_read.etab(),
                merge(tdesr_read.fin(),
                      merge(tdesr_read.ens(),
                            tdesr_read.etu(),all=TRUE),all=TRUE),all.x=TRUE) %>%
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
  
  pn.etu <- tdbesr_plot_norm_ETU(rentrée,uai,...)
  pn.ens <- tdbesr_plot_norm_ENS(rentrée,uai,...)
  pn.fin <- tdbesr_plot_norm_FIN(rentrée,uai,...)
  
  grid.arrange(pp.k.n,
               pp.k.e,
               pp.etu, pn.etu,
               pp.ens, pn.ens,
               pp.fin, pn.fin,
               #nrow = 3, ncol=2,
               heights = c(2,2,1,1,1),
               layout_matrix = rbind(c(1),c(2),c(3,4),c(5,6),c(7,8)))
}



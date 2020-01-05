library(tidyverse)
library(ggrepel)
library(plotly)
library(data.table)
library(knitr)
library(kableExtra)
library(ggthemes)
library(ggalluvial)
library(psych)

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


tdbesr_ETL_and_save <- function() {
  source("fr-esr-principaux-etablissements-enseignement-superieur.R")
  source("fr-esr-operateurs-indicateurs-financiers.R")
  source("fr-esr-enseignants-X-esr-public.R")
  source("fr-esr-statistiques-sur-les-effectifs-d-etudiants-inscrits-par-etablissement.R")
  
  
  esr <<- merge(read.etab(),
                merge(read.fin(),
                      merge(read.ens(),
                            read.etu(),all=TRUE),all=TRUE),all.x=TRUE) %>%
    filter(!is.na(Rentrée)) %>%
    mutate(
      pki.K.1.proPres = pki.FIN.S.2.ressourcesPropres / pki.FIN.P.ressources ,
      pki.K.2.resPetu = pki.FIN.P.ressources / (pki.ETU.S.cycle.1.L+pki.ETU.S.cycle.2.M),
      pki.K.3.titPetu = pki.ENS.S.1.titulaires / pki.ETU.P.effectif * 100,
      pki.K.4.titPens = pki.ENS.S.2.ECtitulaires / pki.ENS.P.effectif
      #pki.K.2.resPens = pki.FIN.P.ressources / pki.ENS.P.effectif,
      #pki.K.4.docPec  = pki.ETU.S.cycle.3.D / pki.ENS.S.2.ECtitulaires,
    ) 
  
  write.csv2(esr,"tdbesr.csv",row.names = FALSE)
  
  esr.pnl <<- tdbesr_pivot_norm_label()  
  
  save(esr, esr.pnl, file = "tdbesr.RData")
}

tdbesr_load <- function() {
  load("tdbesr.RData")
  esr <<- esr
  esr.pnl <<- esr.pnl
}


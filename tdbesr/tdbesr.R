library(tidyverse)
library(ggrepel)
library(plotly)
library(data.table)
library(knitr)
library(kableExtra)
library(ggthemes)
library(ggalluvial)
library(psych)
library(cowplot)

source("tdbesr-style.R")
source("tdbesr-plots-etab.R")
source("tdbesr-plots-evol.R")

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
    ) %>%
    group_by(Rentrée, Type, pki) %>%
    mutate(rang = dense_rank(desc(value))) %>%
    ungroup()
}


tdbesr_add_pkis <- function (df) {
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



tdbesr_plot_tdb <- function(rentrée, uai, big_style=tdbesr_style,...) {
  
  pp.k.n <- tdbesr_plot_norm(rentrée,uai,tdbesr_lfc[["K"]], norm.values=FALSE, omit.first = FALSE, style=big_style,...)
  pp.k.e.a <- tdbesr_plot_evol_grid(rentrée, uai, peg.args,
                                    yzooms = c(0.5, 0.5, 1, 1, 0.5),
                                    plot.type="abs",
                                    noscales = TRUE)
  pp.k.e.e <- tdbesr_plot_evol_grid(rentrée, uai, peg.args, 
                                    yzooms = c(0.6, 0.6, 0.5, 0.25, 0.25),
                                    plot.type="evol",
                                    noscales = TRUE, norentrées = TRUE)
  
  
  pp.etu <- tdbesr_plot_primaire(rentrée,uai,tdbesr_lfc[["ETU"]],...)
  pp.ens <- tdbesr_plot_primaire(rentrée,uai,tdbesr_lfc[["ENS"]],...)  
  pp.fin <- tdbesr_plot_primaire(rentrée,uai,tdbesr_lfc[["FIN"]],...)  
  pp.adm <- tdbesr_plot_primaire(rentrée,uai,tdbesr_lfc[["ADM"]],...)
  
  pn.etu <- tdbesr_plot_norm(rentrée,uai,tdbesr_lfc[["ETU"]],...)
  pn.ens <- tdbesr_plot_norm(rentrée,uai,tdbesr_lfc[["ENS"]],...)
  pn.fin <- tdbesr_plot_norm(rentrée,uai,tdbesr_lfc[["FIN_N"]], omit.first = FALSE, ...)
  pn.adm <- tdbesr_plot_norm(rentrée,uai,tdbesr_lfc[["ADM"]],...)
  
  pg <- 
    plot_grid(ncol = 1, rel_heights = c(1,1),
              plot_grid(ncol=1, rel_heights = c(2,1,1), align = "v",
                pp.k.n,
                pp.k.e.a,
                pp.k.e.e),
              plot_grid (ncol = 2, align = "v",
               pp.etu, pn.etu,
               pp.adm, pn.adm,
               pp.ens, pn.ens,
               pp.fin, pn.fin)
    ) 
  
  return(pg)
    
}

#tdbesr_plot_tdb(2017,uai)



tdbesr_classement <- function(rentrée, type, pkis, labels) {
  
  esr.pnl %>%
    ungroup() %>%
    filter(Rentrée == rentrée, Type == type, pki %in% pkis) %>%
    select(Libellé, pki, value_label, norm_label, rang) %>%
    mutate(pki = factor(pki,levels=pkis)) %>% arrange(pki,rang) %>%
    pivot_wider(names_from = pki, values_from = c(value_label,norm_label,rang)) %>%
    select(2*length(pkis)+2, length(pkis)+2, 0:length(pkis)+1) %>%
    setNames(c("Rang","Ecart", "Libellé", labels))
  
}

# tdbesr_classement(rentrée, "Université", 
#                  c("pki.K.resPetu", "pki.FIN.P.ressources", "pki.ETU.S.cycle.1.L", "pki.ETU.S.cycle.2.M"),
#                  c("Ressources par   \nétudiant","Ressources","Effectif L","Effectif M")) 


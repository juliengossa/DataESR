#!/bin/R
# DataSets :
# galaxie https://www.galaxie.enseignementsup-recherche.gouv.fr/ensup/ListesPostesPublies/Emplois_publies_TrieParCorps.html
# (updateEmploi.sh télécharge et formate ces données)
# DataESR https://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-enseignants-titulaires-esr-public/


library(ggplot2)
library(plyr)
library(tidyverse)
library(ggrepel)
library(plotly)
library(ggthemes)

rentrée <- 2020


# Approximation des sections CNU correspondant aux flilières en tension
#section.cnu.en.tension = c("74","70","18","16","01","02","03","71")
section.cnu.en.tension = c()

# Chargement des données Galaxie
emplois.2018 <- read.table("emplois-ec.2018.csv",header=TRUE, sep=",", quote='"')
emplois.2018$Rentrée <- 2018
emplois.2019 <- read.table("emplois-ec.2019.csv",header=TRUE, sep=",", quote='"')
emplois.2019$Rentrée <- 2019
emplois.2020 <- read.table("emplois-ec.2020.csv",header=TRUE, sep=",", quote='"')
emplois.2020$Rentrée <- 2020

emplois <- emplois.2018 %>% 
  bind_rows(emplois.2019) %>% 
  bind_rows(emplois.2020) %>%
  mutate(
    Rentrée = as.factor(Rentrée),
    Code.section = as.factor(Section),
    Corps = factor(Corps, levels=c("PR","MCF"))
  )

write.csv2(emplois,file="emplois-ec.csv",row.names=FALSE)


effectifs <- read.table("fr-esr-enseignants-titulaires-esr-public.csv",
                      header=TRUE, sep=';', quote='"') %>%
  filter(Rentrée == 2017, Code.categorie.personnels %in% c("MCF","PR")) %>%
  mutate(
    Rentrée = as.factor(Rentrée),
    UAI = Identifiant.établissement,
    Type = Type.établissement,
    Corps = Code.categorie.personnels,
    Code.section = code_section_cnu,
    Section = as.factor(paste0(as.numeric(code_section_cnu),"-",Sections.CNU)),
    Groupe = Groupes.CNU,
    Discipline = Grandes.disciplines
  ) %>% 
  group_by(UAI, Type, Corps, Code.section, Section, Groupe, Discipline) %>%
  summarise(Effectif = sum(effectif))

write.csv2(effectifs,file="effectifs-ec.csv",row.names=FALSE)


# Global

emplois.global <-
  merge(
    emplois %>%
      group_by(Rentrée, Corps) %>%
      summarise(Emplois = n()) %>%
      pivot_wider(
        names_from = Corps, 
        names_prefix = "Emplois_",
        values_from = Emplois, 
        values_fill = list(Emplois = 0)),
    effectifs %>%
      group_by(Corps) %>%
      summarise(Effectif = sum(Effectif)) %>%
      pivot_wider(
        names_from = Corps, 
        names_prefix = "Effectif_",
        values_from = Effectif, 
        values_fill = list(Effectif = 0))
  ) %>%
  group_by(Rentrée) %>%
  summarise(
    Emplois_MCF  = sum(Emplois_MCF),
    Emplois_PR   = sum(Emplois_PR),
    Effectif_MCF = sum(Effectif_MCF),
    Effectif_PR  = sum(Effectif_PR)
  ) %>%
  mutate(
    Renouvellement = Emplois_MCF / (Effectif_MCF + Effectif_PR),
    Promotion = Emplois_PR / Effectif_MCF,
  )  %>% ungroup()

write.csv2(emplois.global,file="emplois-ec.global.csv",row.names=FALSE)


# CNU

emplois.cnu <-
 merge(
    emplois %>%
      group_by(Rentrée, Corps, Code.section) %>%
      summarise(Emplois = n()) %>%
      pivot_wider(
        names_from = Corps, 
        names_prefix = "Emplois_",
        values_from = Emplois, 
        values_fill = list(Emplois = 0)),
    effectifs %>%
      group_by(Corps, Code.section, Section, Groupe, Discipline) %>%
      summarise(Effectif = sum(Effectif)) %>%
      pivot_wider(
        names_from = Corps, 
        names_prefix = "Effectif_",
        values_from = Effectif, 
        values_fill = list(Effectif = 0))
  ) %>%
  group_by(Rentrée, Code.section, Section, Groupe, Discipline) %>%
  summarise(
    Emplois_MCF  = sum(Emplois_MCF),
    Emplois_PR   = sum(Emplois_PR),
    Effectif_MCF = sum(Effectif_MCF),
    Effectif_PR  = sum(Effectif_PR)
  ) %>%
  mutate(
    Renouvellement = Emplois_MCF / (Effectif_MCF + Effectif_PR),
    Promotion = Emplois_PR / Effectif_MCF,
  ) %>% ungroup()

write.csv2(emplois.cnu,file="emplois-ec.cnu.csv",row.names=FALSE)

# Etablissement

emplois.etab <- 
  merge(
    emplois %>%
      mutate(
        Etablissement = as.factor(Etablissement)
      ) %>%
      group_by(Rentrée, Corps, UAI, Etablissement) %>%
      summarise(Emplois = n()) %>%
      pivot_wider(
        names_from = Corps, 
        names_prefix = "Emplois_",
        values_from = Emplois, 
        values_fill = list(Emplois = 0)),
    effectifs %>%
      group_by(Corps, UAI, Type) %>%
      summarise(Effectif = sum(Effectif)) %>%
      pivot_wider(
        names_from = Corps, 
        names_prefix = "Effectif_",
        values_from = Effectif, 
        values_fill = list(Effectif = 0))
  ) %>%
  group_by(Rentrée,Type, UAI,Etablissement) %>%
  summarise(
    Emplois_MCF  = sum(Emplois_MCF),
    Emplois_PR   = sum(Emplois_PR),
    Effectif_MCF = sum(Effectif_MCF),
    Effectif_PR  = sum(Effectif_PR)
  ) %>%
  mutate(
    Renouvellement = Emplois_MCF / (Effectif_MCF + Effectif_PR),
    Promotion = Emplois_PR / Effectif_MCF
  )  %>% ungroup()

write.csv2(emplois.etab,file="emplois-ec.etab.csv",row.names=FALSE)



save(emplois,effectifs,emplois.global,emplois.cnu,emplois.etab,
     file = "emplois-ec.RData" )



# https://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-enseignants-titulaires-esr-public/information/?disjunctive.annee
# [1] "Rentrée"                   "Année.universitaire"       "Établissement"
# [4] "Type.établissement"        "Région"                    "Académie"
# [7] "Sexe"                      "Categorie.de.personnels"   "Grandes.disciplines"
# [10] "Groupes.CNU"               "Sections.CNU"              "ID.académie"
# [13] "ID.région"                 "Identifiant.établissement" "Code.categorie.personnels"
# [16] "Code.groupe.CNU"           "Code.grande.discipline"    "effectif"
# [19] "code_section_cnu"          "geolocalisation"           "classe_age3"
# [22] "quotite"

# https://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-enseignants-nonpermanents-esr-public/information/
# [1] "Rentrée"                         "Année.universitaire"
# [3] "Établissement"                   "Type.établissement"
# [5] "Région"                          "Académie"
# [7] "Sexe"                            "Categorie.de.personnels"
# [9] "Grande.discipline"               "Groupes.CNU"
# [11] "Identifiant.établissement"       "ID.région"
# [13] "ID.académie"                     "Code.groupe.CNU"
# [15] "Code.grande.discipline"          "EFFECTIF"
# [17] "geolocalisation"                 "code.categorie.personnels"
# [19] "categorie.personnels.regroupées" "quotite"

kpiesr_read.ens <- function() {

  ens.tit <- read.table("dataESR/fr-esr-enseignants-titulaires-esr-public.csv",
                        header=TRUE, sep=';', quote='"') %>%
    filter(Rentrée > 2011) %>% # Les données 2010 et 2011 ne sont pas disponibles pour les non titulaires
    transmute(
      Identifiant.établissement,
      Rentrée,
      Catégorie = case_when(
        Code.categorie.personnels == "AM2D" ~ "AM2D",
        TRUE ~ "EC"),
      Discipline = Code.grande.discipline,
      Effectif = effectif)

  ens.np <- read.table("dataESR/fr-esr-enseignants-nonpermanents-esr-public.csv",
                   header=TRUE, sep=';', quote='"')  %>%
    transmute(
      Identifiant.établissement,
      Rentrée,
      Catégorie = case_when(
        code.categorie.personnels == "LRU" ~ "LRU",
        code.categorie.personnels %in% c("ATER", "DOCT AVEC ENS", "DOCT SANS ENS") ~ "Doc_ATER",
        TRUE ~ "Autres"),
      Discipline = Code.grande.discipline,
      Effectif = EFFECTIF)

  ens <- rbind(ens.tit,ens.np) %>%
    group_by(Identifiant.établissement, Rentrée, Catégorie) %>%
    summarise(Effectif = sum(Effectif)) %>%
    ungroup() %>%
    pivot_wider(names_from = Catégorie, values_from = Effectif, values_fill = list(Effectif=0)) %>%
    transmute(
      UAI = Identifiant.établissement,
      Rentrée = as.factor(Rentrée),
      kpi.ENS.P.effectif      = EC+AM2D+Doc_ATER+LRU+Autres,
      kpi.ENS.S.titulaires    = EC+AM2D,
      kpi.ENS.S.ECtitulaires  = EC,
      kpi.ENS.S.DocATER       = Doc_ATER,
      kpi.ENS.S.LRU           = LRU,
    ) %>%
    arrange(UAI,Rentrée)

  return(ens)
}


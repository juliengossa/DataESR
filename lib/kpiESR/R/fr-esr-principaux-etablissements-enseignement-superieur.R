
# https://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-principaux-etablissements-enseignement-superieur/information/?disjunctive.type_d_etablissement
# Version de décembre 2019
# [1] "uai"                        "uo_lib"                     "sigle"
# [4] "type_d_etablissement"       "url"                        "coordonnees"
# [7] "element_wikidata"           "rattachement_identifiants"  "rattachement"
# [10] "dernier_decret_legifrance"  "com_code"                   "com_nom"
# [13] "uucr_id"                    "uucr_nom"                   "dep_id"
# [16] "dep_nom"                    "aca_id"                     "aca_nom"
# [19] "reg_id"                     "reg_nom"                    "mention_distribution"
# [22] "adresse_uai"                "lieu_dit_uai"               "boite_postale_uai"
# [25] "code_postal_uai"            "localite_acheminement_uai"  "pays_etranger_acheminement"
# [28] "numero_telephone_uai"

# Commentaires :
# - établissement.expérimental seulement pour Université de Paris (avec une type unique aussi)
# - donner l'année plutôt que "oui" dans "universités.fusionnées"

# types.établissement <- read.table("types-établissement.csv",
#                                header=TRUE, sep=';', quote='"')
# types.établissement <- setNames(as.character(types.établissement$Type),types.établissement$Type.détaillé)



kpiesr_read.etab <- function() {
  etab <- read.table("dataESR/fr-esr-principaux-etablissements-enseignement-superieur.csv",
                     header=TRUE, sep=';', quote='"', comment.char = "")  %>%
    transmute(
      UAI = recode(uai,
                   '0912408Y' = "0912330N"), #Paris-Sud/Paris Saclay),
      Libellé = uo_lib,
      Sigle = sigle,
      #Type = types.établissement[type.d.établissement],
      Type = case_when(
        type_d_etablissement %in% c("Association d'établissements",
                                    "Communauté d'universités et établissements",
                                    "Pôle de recherche et d'enseignement supérieur",
                                    "Convention de coordination territoriale" ) ~
          "Regroupement",
        type_d_etablissement %in% c("Université",
                                    "Établissement public expérimental",
                                    "Établissement public expérimental;Université") ~
          "Université",
        Libellé %in% c(
          # "École des hautes études en sciences sociales",
          # "Université Paris-Dauphine",
          "Université de Lorraine") ~
          "Université",
        type_d_etablissement %in% c("Grand établissement") ~
          "Grand établissement",
        TRUE ~ "Autre"),
      Type = as.factor(Type),
      Type.détaillé = type_d_etablissement,
      Académie = aca_nom,
      Rattachement = rattachement,
      url.siteweb = url,
      url.wikidata = element_wikidata,
      url.legifrance = dernier_decret_legifrance
    ) %>%
    filter(!is.na(UAI),!UAI=="")
}



# https://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-principaux-etablissements-enseignement-superieur/information/?disjunctive.type_d_etablissement
# [1] "uai...identifiant"         "Libellé"                   "sigle"                    
# [4] "type.d.établissement"      "Site.internet"             "Géolocalisation"          
# [7] "Elément.wikidata"          "rattachement_identifiants" "rattachement"             
# [10] "dernier_decret_legifrance" "Code.commune"              "Commune"                  
# [13] "Code.unité.urbaine"        "Unité.urbaine"             "Code.département"         
# [16] "Département"               "Code.académie"             "Académie"                 
# [19] "Code.région"               "Région"                    "Mention.distribution"     
# [22] "Adresse"                   "Lieu.dit"                  "Boite.postale"            
# [25] "Code.postal"               "Localité"                  "Pays"                     
# [28] "Numéro.de.téléphone" 

# Commentaires : 
# - établissement.expérimental seulement pour Université de Paris (avec une type unique aussi)
# - donner l'année plutôt que "oui" dans "universités.fusionnées" 

# types.établissement <- read.table("types-établissement.csv",
#                                header=TRUE, sep=';', quote='"')
# types.établissement <- setNames(as.character(types.établissement$Type),types.établissement$Type.détaillé)

read.etab <- function() {
  etab <- read.table("fr-esr-principaux-etablissements-enseignement-superieur.csv",
                     header=TRUE, sep=';', quote='"', comment.char = "") %>%
    transmute(
      UAI = uai...identifiant,
      Libellé = Libellé,
      Sigle = sigle,
      #Type = types.établissement[type.d.établissement],
      Type = case_when(
        type.d.établissement %in% c("Association d'établissements",
                                    "Communauté d'universités et établissements",
                                    "Pôle de recherche et d'enseignement supérieur",
                                    "Convention de coordination territoriale" ) ~
          "Regroupement",
        type.d.établissement %in% c("Université",
                                    "Établissement public expérimental",
                                    "Établissement public expérimental;Université") ~
          "Université",
        Libellé %in% c(#"Université Paris-Dauphine",
          "Université de Lorraine") ~
          "Université",
        TRUE ~ "Autre"),
      Type = as.factor(Type),
      Type.détaillé = type.d.établissement,
      Académie = Académie,
      Rattachement = rattachement,
      url.siteweb = Site.internet,
      url.wikidata = Elément.wikidata,
      url.legifrance = dernier_decret_legifrance
    ) %>%
    filter(!is.na(UAI),!UAI=="")
}


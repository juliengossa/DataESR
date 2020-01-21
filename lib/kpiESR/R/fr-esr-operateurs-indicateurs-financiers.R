
# https://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-operateurs-indicateurs-financiers/information/
# [1] "uai...identifiant"                                   "exercice"
# [3] "Acquisitions.d.immobilisations"                      "Besoin.en.fonds.de.roulement"
# [5] "CAF...Acquisitions.d.immobilisations"                "CAF...Produits.encaissables"
# [7] "Capacité.d.autofinancement.CAF"                      "Charges.décaissables"
# [9] "Charges.décaissables...Produits.encaissables"        "Charges.externes"
# [11] "Charges.externes...Produits.encaissables"            "Dépenses.de.personnel"
# [13] "Dépenses.de.personnel...Produits.encaissables"       "Excédent.Brut.d.Exploitation..EBE."
# [15] "Fonds.de.roulement.en.jours.de.charges.décaissables" "Fonds.de.roulement.net.global"
# [17] "Produits.encaissables"                               "Ressources.propres...Produits.encaissables"
# [19] "Ressources.propres.encaissables"                     "Résultat.net.comptable"
# [21] "Solde.budgétaire"                                    "Trésorerie"
# [23] "Trésorerie.en.jours.de.charges.décaissables"         "source"
# [25] "rce"                                                 "vague"
# [27] "typologie"                                           "code.du.groupe"
# [29] "groupe"                                              "uai.actuel"
# [31] "etablissement"                                       "code.de.la.commune"
# [33] "commune"                                             "code.de.l.academie"
# [35] "academie"                                            "code.de.la.region"
# [37] "region"



kpiesr_read.fin <- function() {
  fin <- read.table("dataESR/fr-esr-operateurs-indicateurs-financiers.csv",
                        header=TRUE, sep=';', quote='"') %>%
    transmute(
      #UAI = uai.actuel,
      UAI = uai...identifiant,
      Rentrée = as.factor(exercice-1), # l'exercice comptable est sur l'année civile
      #RCE = rce,
      kpi.FIN.P.ressources = Produits.encaissables,
      kpi.FIN.S.masseSalariale = Dépenses.de.personnel,
      kpi.FIN.S.ressourcesPropres = Ressources.propres...Produits.encaissables * Produits.encaissables / 100
    ) %>%
    #filter_at(starts_with("fin"),all_vars(!is.na(.))) %>%
    filter(!is.na(kpi.FIN.P.ressources),
           !is.na(kpi.FIN.S.masseSalariale),
           !is.na(kpi.FIN.S.ressourcesPropres)) %>%
    arrange(UAI,Rentrée) %>%
    # Enlever les données suspectes
    filter(
      !(UAI == "0781944P" & Rentrée == 2012)
    )

  return(fin)
}

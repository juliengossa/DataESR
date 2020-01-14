

euro_M <- function(x) {
  #return(scales::dollar(x, prefix="",suffix=" M€", scale = 1/1000000, largest_with_cents = 1, big.mark = " "))
  return(paste0(round(x/1000000,0)," M€"))
}

euro_k <- function(x) {
  return(paste0(round(x/1000,1)," k€"))
}

euro <- function(x) {
  return(paste0(round(x,0)," €"))
}

percent_format <- function(x) {
  sprintf("%+0.1f%%", round(x*100,1))
}

number_format <- function(x) {
  format(round(x), big.mark=" ", trim=TRUE)
}



value_labels <- function(pki, value) {
  case_when(
    grepl("pki.FIN", pki)   ~ euro_M(value),
    pki == "pki.K.proPres"  ~ scales::percent(value),
    pki == "pki.K.resPetu"  ~ euro_k(value),
    pki == "pki.K.selPfor"  ~ scales::percent(value),
    pki == "pki.K.titPetu"  ~ format(round(value,1), trim=TRUE),
    pki == "pki.K.titPens"  ~ scales::percent(value),
    grepl("pki.", pki)      ~ number_format(value)
  )
}

norm_labels <- function(pki, norm) {
  case_when(
    grepl("pki.....P", pki)   ~ percent_format(norm),
    grepl("pki.K", pki)       ~ percent_format(norm),
    TRUE                      ~ scales::percent(norm) )
}


#' Title
#'
#' @param point_size
#' @param line_size
#' @param text_size
#' @param primaire_plot.margin
#' @param bp_width
#' @param bp_text_x
#' @param palette
#'
#' @return
#' @export
#'
#' @examples
pkiesr_style <- function(
              point_size = 20,
              line_size = 3,
              text_size = 4,
              primaire_plot.margin = ggplot2::unit(c(0.5,0,0,0), "cm"),
              bp_width = 0.9,
              bp_text_x = -0.25,
              bp_alpha = 1,
              palette = "Set2",
              x_scale = TRUE,
              y_scale = TRUE,
              title = FALSE,
              plotly = FALSE) {
  return(
    as.list(environment())
    )
}


colblues   <- rev(RColorBrewer::brewer.pal(6, "Blues"))
colgreens  <- rev(RColorBrewer::brewer.pal(6, "Greens"))
coloranges <- rev(RColorBrewer::brewer.pal(6, "Oranges"))
colpurples <- rev(RColorBrewer::brewer.pal(6, "Purples"))

pkiesr_lfc <- list(
  ETU = list(
    labels   = c("Etudiants", "Cycle 1 (L)", "Cycle 2 (M)", "Cycle 3 (D)", "DU"),
    factors  = c("pki.ETU.P.effectif", "pki.ETU.S.cycle.1.L", "pki.ETU.S.cycle.2.M", "pki.ETU.S.cycle.3.D", "pki.ETU.S.diplomeEtablissement"),
    colors   = colgreens,
    y_labels = number_format,
    desc     = c("Effectif total étudiant (Hors double inscription CPGE)",
                 "Effectif étudiant inscrit en premier cycle (L, DUT, etc.)",
                 "Effectif étudiant inscrit en deuxième cycle (M)",
                 "Effectif étudiant inscrit en troisième cycle (Doctorat, HDR)",
                 "Effectif étudiant inscrit en diplôme d'établissement (DU, non-national)")
  ),
  ENS = list(
    labels   = c("Enseignants", "Titulaires","EC","Doc et ATER","LRU"),
    factors  = c("pki.ENS.P.effectif", "pki.ENS.S.titulaires", "pki.ENS.S.ECtitulaires", "pki.ENS.S.DocATER", "pki.ENS.S.LRU"),
    colors   = colblues,
    y_labels = identity,
    desc     = c("Effectif total enseignant",
                 "Effectif enseignant titulaire",
                 "Effectif enseignant-chercheur titulaire",
                 "Effectif doctorant et ATER",
                 "Effectif contrat LRU")
  ),
  FIN = list(
    labels   = c("Ressources","Masse salariale","Ressources propres"),
    factors  = c("pki.FIN.P.ressources", "pki.FIN.S.masseSalariale", "pki.FIN.S.ressourcesPropres"),
    colors   = coloranges,
    y_labels = euro_M,
    desc     = c("Ressources totales (produits encaissables)",
                 "Masse salariale (dépenses de personnels)",
                 "Ressources propres")
  ),
  FIN_N = list(
    labels   = c("Masse salariale","Ressources propres", "DU"),
    factors  = c("pki.FIN.S.masseSalariale", "pki.FIN.S.ressourcesPropres", "pki.ETU.S.diplomeEtablissement"),
    colors   = c(coloranges[1:3], colgreens[5]),
    y_labels = euro,
    desc     = c("Part de la masse salariale dans les ressources",
                 "Part des ressources propres dans les ressources",
                 "Part de l'effectif étudiant inscrit en diplôme d'établissement (DU, non-national)")
  ),
  ADM = list(
    labels    = c("Formations\nPost-Bac","Sélectives","Hyper-\nsélectives","Sur-\nchargées","Sous-\nchargées"),
    factors  = c("pki.ADM.P.formations", "pki.ADM.S.sélective", "pki.ADM.S.hypersélective", "pki.ADM.S.surchargées", "pki.ADM.S.souschargée"),
    colors   = colpurples,
    y_labels = identity,
    desc     = c("Nombre de formations post-bac proposées sur APB ou Parcoursup",
                 "Nombre de formations post-bac sélectives",
                 "Nombre de formations post-bac hyper-sélectives",
                 "Nombre de formations post-bac sur-chargées",
                 "Nombre de formations post-bac sous-chargées")
  ),
  K = list(
    labels   = c("Taux de\nressources\npropres", "Taux de\nressources\npar étudiant", "Taux de\nformations\nsélectives", "Taux\nd'encadrement", "Taux de\ntitularité"),
    factors  = c("pki.K.proPres", "pki.K.resPetu", "pki.K.selPfor", "pki.K.titPetu", "pki.K.titPens"),
    colors   = c("brown4",coloranges[5],coloranges[4],colpurples[5],colgreens[5],colblues[5]),
    y_labels = identity,
    desc     = c("Part des ressources propres dans les ressources",
                 "Ressources divisées par le nombre d'étudiants",
                 "Part des formations post-bac sélectives",
                 "Nombre d'enseignants titulaires pour 100 étudiants",
                 "Part des titulaires dans les enseignants")
  )
)

peg.args <- list(
  list(pkiesr_lfc$K, 1, y_labels = scales::percent),
  list(pkiesr_lfc$K, 2, y_labels = euro_k         ),
  list(pkiesr_lfc$K, 3, y_labels = scales::percent, rentrée.base=2015),
  list(pkiesr_lfc$K, 4, y_labels = identity       ),
  list(pkiesr_lfc$K, 5, y_labels = scales::percent))



pkiesr_theme <-
  ggthemes::theme_excel_new() + ggplot2::theme(
    axis.title = ggplot2::element_blank(),
    panel.grid.major.x = ggplot2::element_blank()
  )

pkiesr_plot_missingdata <-
  ggplot(data.frame(c(x=1))) +
    geom_text(x=0.5,y=0.5, label="Données\nmanquantes") + pkiesr_theme

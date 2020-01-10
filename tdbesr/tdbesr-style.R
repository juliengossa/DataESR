

euro <- function(x,format="M") {
  if (format=="M") {
    sca <- 1/1000000
    suf <-" M€ "
    lwc <- 1
  } else if (format=="k") {
    sca <- 1/1000
    suf=" k€"
    lwc <- 1
  } else {
    suf <- " €"
  }
  scales::dollar(x,prefix="",suffix=suf, big.mark = " ", scale = sca, largest_with_cents = lwc)
}

percent_format <- function(x) {
  sprintf("%+0.1f%%", round(x*100,1))
}

number_format <- function(x) {
  format(round(x), big.mark=" ", trim=TRUE)
}



value_labels <- function(pki, value) {
  case_when(
    grepl("pki.FIN", pki)   ~ euro(value,"M"),
    pki == "pki.K.proPres"  ~ scales::percent(value),
    pki == "pki.K.resPetu"  ~ euro(value,"k"),
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




tdbesr_style <- list(
  point_size = 20,
  line_size = 3,
  text_size = 4,
  primaire_plot.margin = unit(c(0.5,0,0,0), "cm"),
  bp_width = 0.9,
  bp_text_x = -0.25,
  palette = "Set2")

colblues   <- rev(RColorBrewer::brewer.pal(6, "Blues"))
colgreens  <- rev(RColorBrewer::brewer.pal(6, "Greens"))
coloranges <- rev(RColorBrewer::brewer.pal(6, "Oranges"))
colpurples <- rev(RColorBrewer::brewer.pal(6, "Purples"))

tdbesr_lfc <- list(
  ETU = list(
    labels   = c("Etudiants", "Cycle 1 (L)", "Cycle 2 (M)", "Cycle 3 (D)", "DU"),
    factors  = c("pki.ETU.P.effectif", "pki.ETU.S.cycle.1.L", "pki.ETU.S.cycle.2.M", "pki.ETU.S.cycle.3.D", "pki.ETU.S.diplomeEtablissement"),
    colors   = colgreens,
    y_labels = number_format
  ),
  ENS = list(
    labels   = c("Enseignants", "Titulaires","EC","Doc et ATER","LRU"),
    factors  = c("pki.ENS.P.effectif", "pki.ENS.S.titulaires", "pki.ENS.S.ECtitulaires", "pki.ENS.S.DocATER", "pki.ENS.S.LRU"),
    colors   = colblues,
    y_labels = identity
  ),
  FIN = list(
    labels   = c("Ressources","Masse salariale","Ressources propres"),
    factors  = c("pki.FIN.P.ressources", "pki.FIN.S.masseSalariale", "pki.FIN.S.ressourcesPropres"),
    colors   = coloranges,
    y_labels = euro
  ),
  FIN_N = list(
    labels   = c("Masse salariale","Ressources propres", "Diplômes\npropres"),
    factors  = c("pki.FIN.S.masseSalariale", "pki.FIN.S.ressourcesPropres", "pki.ETU.S.diplomeEtablissement"),
    colors   = c(coloranges[1:3], colgreens[5]),
    y_labels = euro
  ),
  ADM = list(
    labels    = c("Formations\nPost-Bac","Sélectives","Hyper-\nsélectives","Sur-\nchargées","Sous-\nchargées"),
    factors  = c("pki.ADM.P.formations", "pki.ADM.S.sélective", "pki.ADM.S.hypersélective", "pki.ADM.S.surchargées", "pki.ADM.S.souschargée"),
    colors   =  colpurples,
    y_labels = identity
  ),
  K = list(
    labels   = c("Taux de\nressources propres", "Taux de ressources\npar étudiant", "Taux de\nformations sélectives", "Taux\nd'encadrement", "Taux de\ntitularité"),
    factors  = c("pki.K.proPres", "pki.K.resPetu", "pki.K.selPfor", "pki.K.titPetu", "pki.K.titPens"),
    colors   = c("brown4",coloranges[5],coloranges[4],colpurples[5],colgreens[5],colblues[5]),
    y_labels = identity
  )
)

tdbesr_theme <- 
  theme_excel_new() + theme(
    axis.title = element_blank(),
    panel.grid.major.x = element_blank()
  ) 




euro <- function(x,format="M") {
  if (format=="M") {
    sca<-1/1000000
    suf<-" M€ "
  } else if (format=="k") {
    sca <- 1/1000
    suf=" k€"
  } else {
    suf <- " €"
    sca <- 1
  }
  scales::dollar(x,prefix="",suffix=suf, big.mark = " ", scale=sca)
}

percent_format <- function(x) {
  sprintf("%+0.1f%%", round(x*100,1))
}

percent_format(-0.17)

tdbesr_style <- list(
  point_size = 20,
  line_size = 3,
  text_size = 4,
  primaire_plot.margin = unit(c(0.5,0,0,0), "cm"),
  bp_width = 0.9,
  bp_text_x = -0.25 )

colblues   <- rev(RColorBrewer::brewer.pal(6, "Blues"))
colgreens  <- rev(RColorBrewer::brewer.pal(6, "Greens"))
coloranges <- rev(RColorBrewer::brewer.pal(6, "Oranges"))
colpurples <- rev(RColorBrewer::brewer.pal(6, "Purples"))

tdbesr_colors <- list(
  ENS = colblues,
  ETU = colgreens,
  FIN = coloranges,
  ADM = colpurples,
  K = c("brown4",coloranges[5],coloranges[4],colpurples[5],colgreens[5],colblues[5]) )

tdbesr_labels <- list(
  FIN = c("Ressources","Masse salariale","Ressources propres"),
  ENS = c("Enseignants", "Titulaires","EC","Doc et ATER","LRU"),
  ETU = c("Etudiants","Cycle 1 (L)","Cycle 2 (M)","Cycle 3 (D)","Diplômes propres"),
  ADM = c("Formations Post-Bac","Sélectives","Hyper-sélectives","Surchargées","Souschargées"),
  K = c("Taux de\nressources propres", 
        "Taux de ressources\npar étudiant",
        "Taux de\nformations sélectives",
        "Taux\nd'encadrement",
        "Taux de\ntitularité")
)

tdbesr_theme <- 
  theme_excel_new() + theme(
    axis.title = element_blank(),
    panel.grid.major.x = element_blank()
  ) 


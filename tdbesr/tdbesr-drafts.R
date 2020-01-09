
source("tdbesr.R")

tdbesr_load()

rentrée <- 2017
type <- "Université"
uai.unistra <- "0673021V"
uai.uha <- "0681166Y"
uai.ubm <- "0331766R"
uai.nimes <- "0301687W"
uai.lorraine <- "0542493S"
uai.guyanne <- "9730429D"
uai.diderot <- "0751723R"
uai.descartes <- "0751721N"
uai.bordeaux <- "0333298F"
uai.usmb <- "0730858L"

uais <- c(uai.unistra, uai.uha)
uai.horsnormes <- c(uai.guyanne)

rentrée <- 2017
type <- "Université"
uai <- uai.unistra
uai <- uai.uha
uai <- uai.lorraine


uai.ehess <- "0753742K"
uai.dauphine <- "0750736T"
uai.psl <- "0755700N"
type <- "Regroupement"

tdbesr_plot_primaire(2017,uai,tdbesr_lfc[["ETU"]])
tdbesr_plot_primaire(2017,uai,tdbesr_lfc[["ENS"]])
tdbesr_plot_primaire(2017,uai,tdbesr_lfc[["FIN"]])
tdbesr_plot_primaire(2017,uai,tdbesr_lfc[["ADM"]])


tdbesr_plot_norm(2017,uai,tdbesr_lfc[["ETU"]])
tdbesr_plot_norm(2017,uai,tdbesr_lfc[["ENS"]])
tdbesr_plot_norm(2017,uai,tdbesr_lfc[["FIN_N"]],omit.first = FALSE)
tdbesr_plot_norm(2017,uai,tdbesr_lfc[["ADM"]])
tdbesr_plot_norm(2017,uai,tdbesr_lfc[["K"]],norm.values=FALSE, omit.first = FALSE)

tdbesr_plot_evol(seq(2012,2017), c(uai), tdbesr_lfc[["K"]])
tdbesr_plot_evol(seq(2012,2017), c(uai), tdbesr_lfc[["K"]], plot.type = "norm", noscales = FALSE)

tdbesr_plot_tdb(2017,uai)

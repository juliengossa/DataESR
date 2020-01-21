
library(kpiESR)
library(tidyverse)
library(cowplot)
library(plotly)

kpiesr_plot_tdb(2017,"0673021V", style.kpi = kpiesr_style())

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
uai.ufc <- "0251215K"

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


uai <- "0597065J"
kpiesr_plot_primaire(2017,uai,kpiesr_lfc[["ETU"]],style=kpiesr_style())
kpiesr_plot_primaire(2017,uai,kpiesr_lfc[["ENS"]])
kpiesr_plot_primaire(2017,uai,kpiesr_lfc[["FIN"]])
kpiesr_plot_primaire(2017,uai,kpiesr_lfc[["ADM"]])


kpiesr_plot_norm(2017,uai,kpiesr_lfc[["ETU"]])
kpiesr_plot_norm(2017,uai,kpiesr_lfc[["ENS"]])
kpiesr_plot_norm(2017,uai,kpiesr_lfc[["FIN_N"]],omit.first = FALSE)
kpiesr_plot_norm(2017,uai,kpiesr_lfc[["ADM"]])
kpiesr_plot_norm(2017,uai,kpiesr_lfc[["K"]],norm.values=FALSE, omit.first = FALSE)


kpiesr_plot_evol(seq(2012,2017), c(uai), kpiesr_lfc$K,1,
                 plot.type="abs", yzoom=0.5,
                 style = kpiesr_style(bp_alpha = 1),
                 y_labels=euro,
                 rentrée.base = 2015)



uai <- "0673021V"
plots <- kpiesr_plot_evol_all(2017, uai, peg.args,
                              yzooms = c(0.5, 0.5, 1, 1, 0.5),
                              plot.type="abs")
plots[[3]]
plot_grid(plotlist = plots,nrow=1)

uai <- "0597065J"
kpiesr_plot_tdb(2017,uai.unistra)


kpiesr_classement(2017, "Université",
                  c("kpi.K.proPres", "kpi.FIN.P.ressources","kpi.FIN.S.ressourcesPropres"),
                  c("RP/R","R","RP"))



uai <- "0673021V"
ggplotly(kpiesr_plot_primaire(2017,uai,kpiesr_lfc[["FIN_N"]],style=kpiesr_style()), tooltip = "text")

subplot(
  kpiesr_plot_evol_all(rentrée, uai, peg.args,
                       yzooms = c(0.1, 1, 1, 0.11, 0.1, 10),
                       plot.type="norm")
)


ps <- kpiesr_plot_evol_all(rentrée, uai, peg.args,
                     yzooms = c(0.6, 0.6, 0.5, 0.2, 0.2, 1),
                     plot.type="norm")

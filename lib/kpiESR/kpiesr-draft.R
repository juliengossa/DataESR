
library(kpiESR)
library(tidyverse)
library(cowplot)
library(plotly)
library(ggthemes)

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


esr %>% filter(Type == "Université", Rentrée > 2012) %>%
  group_by(Rentrée) %>%
  summarise(
    Ressources = sum(kpi.FIN.P.ressources, na.rm = TRUE),
    MasseSalariale = sum(kpi.FIN.S.masseSalariale, na.rm = TRUE) ,
    Ratio = MasseSalariale/Ressources)  %>%
  pivot_longer(-Rentrée) %>%
  group_by(name) %>% arrange(Rentrée) %>%
  mutate(Evolution = (value / first(value))) %>%
  filter(name == "Ratio") %>%
  ggplot(aes(x=Rentrée, y=Evolution, color=name, group=name)) +
    geom_line(size=2) +
    theme_hc() + guides(color=FALSE) + ggtitle("Evolution du ratio masse salariale sur produits encaissables \n des universités, en base 1.0 pour 2013")


nat <- esr %>% filter(Type=="Université", Rentrée >= 2012, Rentrée < 2018) %>%
  group_by(Rentrée) %>%
  summarise(
    enseignants = sum(kpi.ENS.P.effectif, na.rm=TRUE),
    titulaires = sum(kpi.ENS.S.titulaires, na.rm=TRUE),
    etudiants = sum(kpi.ETU.S.cycle.1.L+kpi.ETU.S.cycle.2.M),
    Taux.d.encadrement = titulaires/etudiants*100) %>%
  pivot_longer(-Rentrée, names_to = "effectif") %>%
  group_by(effectif) %>%
  mutate(
    evolution = value / first(value) * 100
  )

nat %>% filter(effectif %in% c("enseignants","titulaires")) %>%
  ggplot(aes(x=Rentrée, y=value, group=effectif, color=effectif)) +
    geom_line(size=2)  + theme_hc()

nat %>% filter(effectif %in% c("etudiants")) %>%
  ggplot(aes(x=Rentrée, y=value, group=effectif, color=effectif)) +
  geom_line(size=2) +  theme_hc()

nat %>%
  ggplot(aes(x=Rentrée, y=evolution, group=effectif, color=effectif)) +
  geom_line(size=2) + ylim(90,110) + theme_hc()

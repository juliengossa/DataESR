
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

tdbesr_plot_primaire(rentrée,uai,"pki.FIN",
                     var.labels = tdbesr_labels$FIN, 
                     palette = tdbesr_colors$FIN,
                     scale_format = euro)  

tdbesr_plot_primaire(rentrée,uai,"pki.ETU",
                     var.labels = tdbesr_labels$ETU, 
                     palette = tdbesr_colors$ETU)  

tdbesr_plot_primaire(rentrée,uai,"pki.ENS",
                     var.labels = tdbesr_labels$ENS, 
                     palette = tdbesr_colors$ENS)  

tdbesr_plot_primaire(rentrée,uai,"pki.ADM",
                     var.labels = tdbesr_labels$ADM, 
                     palette = tdbesr_colors$ADM)  


tdbesr_plot_norm(rentrée,uai,select_pkis("pki.ETU.S")[1:3],
                 var.labels = tdbesr_labels$ETU[2:4], 
                 palette = tdbesr_colors$ETU)  

tdbesr_plot_norm(rentrée,uai,select_pkis("pki.ENS.S"),
                 var.labels = tdbesr_labels$ENS[2:5], 
                 palette = tdbesr_colors$ENS)

tdbesr_plot_norm(rentrée,uai,c(select_pkis("pki.FIN.S"),"pki.ETU.S.diplomeEtablissement"),
                 var.labels = c(tdbesr_labels$FIN[2:3], tdbesr_labels$ETU[5]),
                 palette = c(tdbesr_colors$FIN[1:3], tdbesr_colors$ETU[5]))


tdbesr_plot_norm(rentrée,uai,select_pkis("pki.ADM.S"),
                 var.labels = tdbesr_labels$ADM[2:5], 
                 palette = tdbesr_colors$ADM)


tdbesr_plot_norm(rentrée,uai,select_pkis("pki.K"),
                 var.labels = tdbesr_labels$K, 
                 palette = tdbesr_colors$K,
                 values = "value")  


tdbesr_plot_evol(seq(2012,2017), c(uai.unistra), select_pkis("pki.K"),
                 plot.type="norm",
                 colors = tdbesr_colors$K,
                 strip_labels = NULL, scale_y_format = NULL)


tdbesr_plot_tdb(2017,uai.unistra)

###
tdbesr_plot_tdb(2017,"0751719L")

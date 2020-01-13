
library(pkiESR)
library(plotly)

pkis.k <- c("pki.K.proPres","pki.K.resPetu","pki.K.selPfor","pki.K.titPetu","pki.K.titPens")
pkis.set <- c("etu","ens","adm","fin")

height.k <- "250"
height.evol <- "300"
height.set <- "550"

shiny_lfc <- pkiesr_lfc
shiny_lfc$ETU$labels   <- c("Etu", "L", "M", "D", "DU")
shiny_lfc$ENS$labels   <- c("Ens.", "Tit.","EC","Doc.","LRU")
shiny_lfc$FIN$labels   <- c("Res.","MS","RP")
shiny_lfc$FIN_N$labels <- c("MS","RP", "DU")
shiny_lfc$ADM$labels   <- c("APB","Sél.","Hyp-sél","Sur-ch.","Sous-ch")


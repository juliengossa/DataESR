
library(pkiESR)
library(plotly)

height.k <- "auto"
height.evol <- "auto"
height.set <- "auto"

shiny_lfc <- pkiesr_lfc
shiny_lfc$ETU$labels   <- c("Etu", "L", "M", "D", "DU")
shiny_lfc$ENS$labels   <- c("Ens.", "Tit.","EC","Doc.","LRU")
shiny_lfc$FIN$labels   <- c("Res.","MS","RP")
shiny_lfc$FIN_N$labels <- c("MS","RP", "DU")
shiny_lfc$ADM$labels   <- c("APB","Sél.","Hyp-sél","Sur-ch.","Sous-ch")

createSimpleCache <- function() {
  e <- new.env(parent = emptyenv())
  
  list(
    get = function(key) {
      if (exists(key, envir = e, inherits = FALSE)) {
        return(e[[key]])
      } else {
        return(key_missing())
      }
    },
    set = function(key, value) {
      e[[key]] <- value
    }
  )
}

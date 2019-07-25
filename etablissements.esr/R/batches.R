
library(wikidataESR)

library(ggplot2)
library(network)
library(ggnetwork)
library(scales)
library(dplyr)


# Batches

wdesr_load_cache()

## Regroupements

plot_regroupements <- function(racines) {
  wdesr.env <- wdesr_get_cache()
  ggs.width <- 13
  ggs.heigth <- 8
  ggs.dpi <- 150
  ggs.path <- "../plots/regroupements/"
  
  for(racine in racines) {
    print(paste("Racine :",racine))

    ## court
    try( {
      wdesr_load_and_plot(racine,c('composante','associé'),depth=1, 
                          node_size = c(20,30), label_sizes = c(4,5), arrow_gap = 0.0,
                          node_label = "alias", node_type = "text",
                          edge_label = FALSE)
      alias <- subset(wdesr.env$items, id == racine)$alias
      ggsave(paste(ggs.path,alias,'-',racine,"-court.png",sep=''), width = ggs.width, height = ggs.heigth, dpi = ggs.dpi) 
    } )
        
    ## étendu
    try( {
      wdesr_load_and_plot(racine,c('composante','associé'),depth=2, active_only = TRUE,
                          node_size = c(10,30), label_sizes = c(3,5), arrow_gap = 0.0,
                          node_label = "alias", node_type = "text",
                          edge_label = FALSE)
      ggsave(paste(ggs.path,alias,'-',racine,"-etendu.png",sep=''), width = ggs.width, height = ggs.heigth, dpi = ggs.dpi) 
      } )

    ## superétendu
    try( {
      wdesr_load_and_plot(racine,c('composante','associé','prédécesseur'),depth=3,
                          node_size = c(10,30), label_sizes = c(3,5), arrow_gap = 0.0,
                          node_label = "alias", node_type = "text",
                          edge_label = FALSE)
      ggsave(paste(ggs.path,alias,'-',racine,"-superetendu.png",sep=''), width = ggs.width, height = ggs.heigth, dpi = ggs.dpi)  
    } )
    
  }
}

regroupements <- read.table("regroupements.csv", sep = ";", header = TRUE, quote="")
plot_regroupements(regroupements$id)


## Histoire

plot_histoire <- function(racines) {
  wdesr.env <- wdesr_get_cache()
  ggs.width <- 8
  ggs.heigth <- 6
  ggs.dpi <- 100
  ggs.path <- "../plots/histoire/"
  
  for(racine in racines) {
    alias <- subset(wdesr.env$items, id == racine)$alias
    print(paste("Racine :",racine,alias))
    
    ## histoire
    try( {
      wdesr_load_and_plot(racine,c('successeur', 'séparé_de', 'composante_de', 'associé_de'), depth=10,
                          node_size = 30, label_sizes = 4, arrow_gap = 0.11,
                          node_label = "alias_date", node_type = "text",
                          edge_label = TRUE)
      alias <- subset(wdesr.env$items, id == racine)$alias
      ggsave(paste(ggs.path,alias,'-',racine,"-superetendu.png",sep=''), width = ggs.width, height = ggs.heigth, dpi = ggs.dpi)  
    } )
  }
}

anciennes_univ <- read.table("anciennes-univ.csv", sep = ";", header = TRUE, quote="")
plot_histoire(anciennes_univ$id)

# Cache

wdesr_save_cache()

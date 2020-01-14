#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("R/common.R", local=TRUE)



# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    rentrée <- 2017
    
    observe(updateSelectInput(session, "uai", choices =  pkiESR::uais[input$type]))
        
    plots <- reactiveVal()
    observeEvent(input$uai, {
        plots(pkiesr_plot_all(rentrée,input$uai, 
                              style.pki.k = pkiesr_style(
                                  point_size=14, 
                                  text_size=4,
                                  bp_text_x = -0.4,
                                  plotly=TRUE), 
                              style.pki = pkiesr_style(
                                  point_size = 8,
                                  text_size = 3,
                                  line_size = 1,
                                  plotly=TRUE),
                              lfc = shiny_lfc))
    })
    
    
    pkiesr_ggly <- function(plotname) { 
        renderPlotly(print(hide_legend(config(ggplotly(
            plots()[[plotname]], tooltip = "text"
        ), displayModeBar = F)
        )))
    }
    
    pkiesr_ggly_etab <- function() { 
        renderPlotly(print(hide_legend(config(displayModeBar = F,
            subplot(nrows = 4, margin = c(0.05,.05,.05,.05),
              lapply(c("etu.abs","etu.norm","ens.abs","ens.norm","adm.abs",
                       "adm.norm","fin.abs","fin.norm"), function(p) { 
                  ggplotly(plots()[[p]], tooltip = "text")
              })
            )
        ))))
    }
    
    pkiesr_ggly_evol <- function() {
        renderPlotly(print(hide_legend(config(displayModeBar = F,
              subplot(nrows = 2, margin=c(0.02,0.02,.1,.1),  c(
                  lapply(seq(1,5), function(p) {
                      ggplotly(plots()[["k.evol.abs"]][[p]], tooltip = "text")
                  }),
                  lapply(seq(1,5), function(p) {
                      ggplotly(plots()[["k.evol.norm"]][[p]], tooltip = "text")
                  })
              ))
        ))))
    }
    
    
    
    output[["k.norm"]] <- pkiesr_ggly("k.norm")
    output[["k.evols"]] <- pkiesr_ggly_evol()
    output[["etab"]] <- pkiesr_ggly_etab()
    
})



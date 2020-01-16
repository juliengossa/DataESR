#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)



# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    cache <- createSimpleCache()
    
    rentrée <- 2017
    
    observe(updateSelectInput(session, "uai", choices =  pkiESR::uais[input$type]))
        
    
    
    pkiesr_ggly_k.norm <- function(plots_all) { 
        renderPlotly(print(hide_legend(config(
            layout(
                ggplotly(plots_all$k.norm, tooltip = "text"),
                xaxis =  list(side = "top")
                ),
            displayModeBar = F)
        )))
    }
    
    pkiesr_ggly_etab <- function(plots_all) { 
        renderPlotly(print(hide_legend(config(displayModeBar = F,
            subplot(nrows = length(plots_all$absnorm)/2, margin = c(0.05,.05,.05,.05),
              lapply(plots_all$absnorm, function(p) {
                    ggplotly(p, tooltip = "text")
              })
            )
        ))))
    }
    
    pkiesr_ggly_k.evols <- function(plots_all) {
        renderPlotly(print(hide_legend(config(displayModeBar = F,
              subplot(nrows = 2, margin=c(0.02,0.02,.1,.1),  c(
                  lapply(seq(1,4), function(p) {
                      add_annotations(
                        ggplotly(plots_all[["k.evol.abs"]][[p]], tooltip = "text"),
                        text = gsub("\n"," ",pkiesr_lfc$K$labels[[p]]),
                        yanchor = "top",
                        yref = "paper",
                        showarrow = FALSE,
                        y=1.15)
                  }),
                  lapply(seq(1,4), function(p) {
                      ggplotly(plots_all[["k.evol.norm"]][[p]], tooltip = "text")
                  })
              ))
        ))))
    }

    observeEvent(input$uai, {
        if(is.key_missing(
            plots <- cache$get(input$uai)
        )) {
            plots_all <- pkiesr_plot_all(rentrée,input$uai, 
                                  style.pki.k = pkiesr_style(
                                      point_size=14, 
                                      text_size=4,
                                      bp_text_x = -0.3,
                                      plotly=TRUE), 
                                  style.pki = pkiesr_style(
                                      point_size = 8,
                                      text_size = 3,
                                      line_size = 2,
                                      plotly=TRUE),
                                  lfc = shiny_lfc)
            
            plots <- list(
                k.norm = pkiesr_ggly_k.norm(plots_all),
                k.evols = pkiesr_ggly_k.evols(plots_all),
                etab = pkiesr_ggly_etab(plots_all)
            )
            
            cache$set(input$uai,plots)
        }
        
        output[["k.norm"]] <- plots$k.norm
        output[["k.evols"]] <- plots$k.evols
        output[["etab"]] <- plots$etab
    })
    
    
    
})



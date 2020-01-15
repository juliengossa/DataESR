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
        
    plots <- reactiveVal()
    observeEvent(input$uai, {
        if(is.key_missing(
            ps <- cache$get(input$uai)
            )) {
                ps <- pkiesr_plot_all(rentrée,input$uai, 
                              style.pki.k = pkiesr_style(
                                  point_size=14, 
                                  text_size=4,
                                  bp_text_x = -0.3,
                                  plotly=TRUE), 
                              style.pki = pkiesr_style(
                                  point_size = 8,
                                  text_size = 3,
                                  line_size = 1,
                                  plotly=TRUE),
                              lfc = shiny_lfc)
                cache$set(input$uai,ps)
        }
        plots(ps)
    })
    
    
    pkiesr_ggly <- function(plotname) { 
        renderPlotly(print(hide_legend(config(
            layout(
                ggplotly(plots()[[plotname]], tooltip = "text"),
                xaxis =  list(side = "top")
                ),
            displayModeBar = F)
        )))
    }
    
    pkiesr_ggly_etab <- function() { 
        renderPlotly(print(hide_legend(config(displayModeBar = F,
            subplot(nrows = length(plots()$absnorm)/2, margin = c(0.05,.05,.05,.05),
              lapply(plots()$absnorm, function(p) {
                    ggplotly(p, tooltip = "text")
              })
            )
        ))))
    }
    
    pkiesr_ggly_evol <- function() {
        renderPlotly(print(hide_legend(config(displayModeBar = F,
              subplot(nrows = 2, margin=c(0.02,0.02,.1,.1),  c(
                  lapply(seq(1,4), function(p) {
                      add_annotations(
                        ggplotly(plots()[["k.evol.abs"]][[p]], tooltip = "text"),
                        text = gsub("\n"," ",pkiesr_lfc$K$labels[[p]]),
                        yanchor = "top",
                        yref = "paper",
                        showarrow = FALSE,
                        y=1.1)
                  }),
                  lapply(seq(1,4), function(p) {
                      ggplotly(plots()[["k.evol.norm"]][[p]], tooltip = "text")
                  })
              ))
        ))))
    }
    
    
    
    output[["k.norm"]] <- pkiesr_ggly("k.norm")
    output[["k.evols"]] <- pkiesr_ggly_evol()
    output[["etab"]] <- pkiesr_ggly_etab()
    
})



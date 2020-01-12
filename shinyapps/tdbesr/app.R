#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(pkiESR)

pkis.k <- c("pki.K.proPres","pki.K.resPetu","pki.K.selPfor","pki.K.titPetu","pki.K.titPens")
pkis.set <- c("etu","ens","adm","fin")

height.k <- "300"
height.evol <- "100"
height.set <- "120"

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Tableaux de bord de l'ESR"),

    # Sidebar with a slider input for number of bins 
    fluidRow(
        column(3,
               selectInput("type", "Type", selected = "Université", choices = list(
                   "Université" = "Université",
                   "Grand établissement" = "Grand établissement",
                   "Regroupement" = "Regroupement",
                   "Autre" = "Autre"
                    ))
        ),
        column(6,
            selectInput("uai", "Etablissement", selected = "", 
                        choices = pkiESR::uais["Université"])
        ),
        column(3,
               selectInput("plot.type", "Evolutions", selected = "norm", 
                           choices = list(norm = "normalisées", abs = "absolues"))
        ),
        
        column(6, 
               plotlyOutput("k.norm", height = height.k),
               column(2),
               lapply(pkis.k, function(p) { 
                column(2, 
                       plotOutput(paste0(p,".abs"), height = height.evol),
                       plotOutput(paste0(p,".norm"), height = height.evol))
               }
               )
               
        ),
        
        lapply(pkis.set, function(p) { 
        column(6, 
                   column(6,plotOutput(paste0(p,".abs"), height = height.set)),
                   column(6,plotOutput(paste0(p,".norm"), height = height.set))
               ) }
               
        )
    )
)



# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    rentrée <- 2017
    
    observe(updateSelectInput(session, "uai", choices =  pkiESR::uais[input$type]))
       
    plots <- reactiveVal()
    observeEvent(input$uai, {
        plots(pkiesr_plot_all(rentrée,input$uai))
    })
    
    pkiesr_ggly <- function(plotname, plotname2 = NULL) { 
        if(is.null(plotname2))
            renderPlotly(print(hide_legend(ggplotly(
                plots()[[plotname]]
                ))))
        else
            renderPlotly(print(hide_legend(ggplotly(
                plots()[[plotname]][[plotname2]]
            ))))
    }
    
    pkiesr_gg <- function(plotname, plotname2 = NULL) { 
        if(is.null(plotname2))
            renderPlot(print(
                plots()[[plotname]]
            ))
        else
            renderPlot(print(
                plots()[[plotname]][[plotname2]]
            ))
    }
    

    output[["k.norm"]] <- pkiesr_ggly("k.norm")
    
    lapply(pkis.set, function(p) { 
        output[[paste0(p,".abs")]] <- pkiesr_gg(paste0(p,".abs"))
        output[[paste0(p,".norm")]] <- pkiesr_gg(paste0(p,".norm"))
        } )

    lapply(pkis.k, function(p) { 
        output[[paste0(p,".abs")]] <- pkiesr_gg("k.evol.abs",p)
        output[[paste0(p,".norm")]] <- pkiesr_gg("k.evol.norm",p)
    } )
    
    
    # output$plot.k.norm.evol.abs <- pkiesr_ggly("k.evol.abs","pki.K.proPres")

        
}

# Run the application 
shinyApp(ui = ui, server = server)

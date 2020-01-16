#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
shinyUI(function(request) {fluidPage(
    tags$head(tags$style(HTML(mycss))),
    
    
    # Sidebar with a slider input for number of bins 
    fluidRow( 
        column(2,
               titlePanel("TDB ESR", windowTitle="Tableaux de bord de l'ESR")
               
        ),
        column(2,
               uiOutput("SI.type")
        ),
        column(3,
               uiOutput("SI.uai")
        ),
        column(2,
               helpText("Année : 2017-2018"),
               bookmarkButton()),
        column(3, 
            
            helpText("Interface expérimentale : utiliser avec précaution."),
            helpText("Liens :",
                a("Manuel", href="https://github.com/juliengossa/DataESR/tree/master/tdbesr"),
                " et ",a("contact@cpesr.fr", href="mailto:contact@cpesr.fr"))
        )
    ),
    fluidRow(
        column(6, 
               div(id = "plot-container",
                   tags$img(src = "spinner.gif",
                            id = "loading-spinner"),
               plotlyOutput("k.norm", height = height.k)
               )
        ),
        column(6, 
            plotlyOutput("etab", height = height.set)
        )
    ),
    plotlyOutput("k.evols", height = height.evol)
)
    })

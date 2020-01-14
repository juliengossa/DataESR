#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("R/common.R", local=TRUE)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    
    # Sidebar with a slider input for number of bins 
    fluidRow( 
        column(2,
        titlePanel("TDB ESR", windowTitle="Tableaux de bord de l'ESR")
        ),
        column(3,
               selectInput("type", "Type", selected = "Université", choices = list(
                   "Université" = "Université",
                   "Grand établissement" = "Grand établissement",
                   #"Regroupement" = "Regroupement",
                   "Autre" = "Autre"
               ))
        ),
        column(3,
               selectInput("uai", "Etablissement", selected = "", 
                           choices = uais["Université"])
        ),
        column(4, 
            helpText("Interface expérimentale : utiliser avec précaution"),
            helpText("Liens :",
                a("Manuel", href="https://github.com/juliengossa/DataESR/tree/master/tdbesr"),
                " et Contact :", a("contact@cpesr.fr", href="mailto:contact@cpesr.fr"))
        )
    ),
    fluidRow(
        column(6, 
               plotlyOutput("k.norm", height = height.k)
               # fluidRow(plotlyOutput("k.norm", height = height.k)),
               # fluidRow(
               #     column(1),
               #     column(11,plotlyOutput("k.evols", height = height.evol)))

        ),
        column(6, 
            plotlyOutput("etab", height = height.set)
        )
    ),
    plotlyOutput("k.evols", height = height.evol)
))

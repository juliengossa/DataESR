
fluidPage(
  titlePanel("Campagne d'emploi enseignants-chercheurs synchronisée 2019"),

  fluidRow(
    column(2,
      wellPanel(
        radioButtons("dataset", "Objet :",
           c("CNU" = "CNU",
             "Établissements" = "Etablissements")),
        radioButtons("metrics", "Indicateurs :",
           c("Bruts" = "Bruts",
             "Corrélés" = "Corrélés",
             "Taux" = "Taux",
             "Durée des cycles" = "Cycles")),
        textOutput("metricsExp")#, placeholder = TRUE)
      )
    ),
    column(10,
      tabsetPanel(
        tabPanel("Colonnes", plotly::plotlyOutput("plotCols")),
        tabPanel("Points", plotly::plotlyOutput("plotPoints"))
      )
    )
  ),
  "Table", DT::dataTableOutput("table")
)

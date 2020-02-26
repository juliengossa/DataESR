library(shiny)
library(ggplot2)
library(plotly)

etab <- read.table("emplois-ec.etab.csv",header=TRUE, sep=";", quote='"')
CNU <- read.table("emplois-ec.CNU.csv",header=TRUE, sep=";", quote='"')

formatDT <- function(dt) {
  dt <- DT::formatPercentage(dt, c(7,9),2)
  dt
}


tooltipsCallback <-
  "var tips = ['', '',
    'Effectifs Maîtres de conférences en 2017',
    'Effectifs Professeurs des universités en 2017',
    'Emplois Maîtres de conférences à la session sychronisée 2019',
    'Emplois Professeurs des universités à la session sychronisée 2019',
    'Nombre d emplois de Professeurs des universités par Maîtres de conférences',
    'Temps nécessaire pour qu il y ait un emploi de Professeur des universités par Maître de conférences',
    'Nombre d emplois de Maîtres de conférences rapporté aux effectifs totaux',
    'Temps nécessaire pour que tous les enseignants-chercheurs soient renouvelés'
    ],
    firstRow = $('#table thead tr th');
    for (var i = 0; i < tips.length; i++) {
      $(firstRow[i]).attr('title', tips[i]);
    }"

function(input, output, session) {

  output$metricsExp <- renderText({
    switch(input$metrics,
      "Bruts" = "Emplois EC à la session sychronisée 2019",
      "Corrélés" = "Emplois et effectifs EC",
      "Taux" = "Renouvellement = emplois MCF / effectifs EC\nPromotion = emplois PR / effectifs MCF",
      "Cycles" = "Temps nécessaire pour renouveller et promouvoir entièrement les effectifs"
      )
    })


  datasetInput <- reactive({
    switch(input$dataset,
           "Etablissements" = etab,
           "CNU" = CNU)
  })

  colnamesInput <- reactive({
    c(
      switch(input$dataset,
         "Etablissements" = c('Etablissement', 'Type'),
         "CNU" = c('Section CNU','Grande discipline')),
      'Effectifs MCF', 'Effectifs PR',
      'Emplois MCF','Emplois PR',
      'Taux de promotion', 'Durée du cyle de promotion (ans)',
      'Taux de renouvellement', 'Durée du cyle de renouvellement (ans)'
    )
  })

  hoverTextAes <- reactive({
    aes(
      text=paste(
        switch(input$dataset,
           "Etablissements" = Etablissement,
           "CNU" = Section.CNU),
        "\nEmplois :", emplois.MCF, "MCF et",emplois.PR,"PR",
        "\nEffectifs :", effectifs.MCF, "MCF et",effectifs.PR,"PR",
        "\nTaux :", scales::percent(taux.renouvellement), "de renouvellement et",
          scales::percent(taux.promotion), "de promotion",
        "\nCycles :", durée.cycle.renouvellement, "ans pour renouvellement et",
          durée.cycle.promotion, "ans pour promotion"
      )
    )
  })

  # Points Plots
  output$plotPoints <- plotly::renderPlotly({

    if (length(input$table_rows_all)) {
      data <- datasetInput()[input$table_rows_all,]
    } else {
      data <- datasetInput()
    }

    p <- ggplot(data)

    if( input$metrics == "Bruts" ) {
      p <- p +
          aes(x=emplois.MCF,y=emplois.PR) +
          xlab("Emplois de Maître de conférences (2019)") +
          ylab("Emplois de Professeur des universités (2019)")
    } else if( input$metrics == "Corrélés" ) {
      p <- p +
          aes(x=effectifs.MCF+emplois.PR,y=emplois.MCF+emplois.PR) +
          xlab("Effectifs enseignants-chercheurs (2017)") +
          ylab("Emplois enseignants-chercheurs (2019)")
    } else if( input$metrics == "Taux" ) {
      p <- p +
          aes(x=taux.renouvellement,y=taux.promotion) +
          xlab("Taux de renouvellement") +
          ylab("Taux de promotion") +
          scale_x_continuous(labels = scales::percent) +
          scale_y_continuous(labels = scales::percent)
    } else {
      p <- p +
          aes(x=durée.cycle.renouvellement,y=durée.cycle.promotion) +
          xlab("Durée du cycle de renouvellement (ans)") +
          ylab("Durée du cycle de promotion (ans)")
    }

    p <- p + aes(colour=Groupe) + hoverTextAes() + geom_point()

    if(length(input$table_rows_selected)){
      p <- p + geom_point(data=datasetInput()[input$table_rows_selected,],
        size=4, shape=1, colour='black')

      if (input$dataset == "CNU" ) {
        p <- p + geom_text(data=datasetInput()[input$table_rows_selected,],
          colour='black', aes(label=paste(" ",Section.CNU)))
      } else {
      p <- p + geom_text(data=datasetInput()[input$table_rows_selected,],
        colour='black', aes(label=paste(" ",Etablissement)))
      }
    }

    style(ggplotly(p, tooltip="text"), textposition = "top right")
  })


  # Cols Plots
  output$plotCols <- plotly::renderPlotly({

    if (length(input$table_rows_all)) {
      data <- datasetInput()[input$table_rows_all,]
    } else {
      data <- datasetInput()
    }

    p <- ggplot(data)

    if( input$dataset == "CNU" ) {
      p <- p + aes(x=reorder(Section.CNU,emplois.MCF+emplois.PR)) +
        xlab("Sections CNU (triées par nombre d'emplois)")
    } else {
      p <- p + aes(x=reorder(Etablissement,emplois.MCF+emplois.PR)) +
        xlab("Établissements (triés par nombre d'emplois)")
    }

    if( input$metrics == "Bruts" ) {
      p <- p +
        geom_col(aes(y=emplois.PR, fill="Professeur des universités")) +
        geom_col(aes(y=-emplois.MCF, fill="Maîtres de conférences")) +
        ylab("MCF <- Nombre d'emplois (2019) -> PR")
    } else if( input$metrics == "Corrélés" ) {
      p <- p +
        geom_col(aes(y=emplois.PR+effectifs.PR, fill="Emplois PR")) +
        geom_col(aes(y=-emplois.MCF-effectifs.MCF, fill="Emplois MCF")) +
        geom_col(aes(y=effectifs.PR, fill="Effectifs PR")) +
        geom_col(aes(y=-effectifs.MCF, fill="Effectifs MCF")) +
        ylab("MCF <- Effectifs (2017) et emplois (2019) -> PR")
    } else if( input$metrics == "Taux" ) {
      p <- p +
        geom_col(aes(y=taux.promotion, fill="Taux de promotion")) +
        geom_col(aes(y=-taux.renouvellement, fill="Taux de nouvellement")) +
        ylab("renouvellement <- Taux -> promotion")
    } else {
      p <- p +
        geom_col(aes(y=durée.cycle.promotion, fill="Durée du cycle de promotion")) +
        geom_col(aes(y=-durée.cycle.renouvellement, fill="Durée du cycle de nouvellement")) +
        ylab("renouvellement <- Durée des cycles (ans) -> promotion")
    }

    if (length(input$table_rows_selected)) {
      if (input$dataset == "CNU") {
        p <- p + aes(alpha = Section.CNU %in% datasetInput()[input$table_rows_selected,1])
      } else {
        p <- p + aes(alpha = Etablissement %in% datasetInput()[input$table_rows_selected,1])
      }
      p <- p + scale_alpha_discrete(range=c(0.5,1))
    }


    p <- p + hoverTextAes() +
      scale_y_continuous(labels = abs) +
      theme(
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

      #scale_fill_manual(name = 'the fill', values =c('black'='black','red'='red'), labels = c('c2','c1')) +
      #

    hide_legend(ggplotly(p, tooltip="text"))
  })


  # Filter data based on selections
  output$table <- DT::renderDataTable(
    formatDT(DT::datatable(datasetInput(),
      filter = 'top',
      rownames = FALSE,
      colnames = colnamesInput(),
      callback = DT::JS(tooltipsCallback),
      options = list(
        autoWidth = TRUE,
        columnDefs = list(list(width = '600px', targets = c(0,1)))
      )
    ))
  )
}

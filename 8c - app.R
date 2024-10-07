library(shiny)
library(shinyFeedback)
library(tidyverse)
library(vroom)

ui <- fluidPage(
  textInput("tsv", "File", value = "neiss/injuries.tsv.gz"),
  actionButton("read", "Read tsv"),
  actionButton("goodnight", "Good night"),
  tableOutput("frame")
)

server <- function(input, output, session) {

  dat <- eventReactive(input$read, {
      id <- showNotification("Reading data...", duration = NULL, closeButton = FALSE)
      on.exit(removeNotification(id), add = TRUE)
      Sys.sleep(2)
      vroom(input$tsv, n_max = 10, col_select = c(2:9))
  })
  
  output$frame <- renderTable({
    if (is.null(dat())) return()  # Handle case where dat() is NULL
    as.data.frame(dat())          # Convert to data frame and display
  })

  observeEvent(input$goodnight, {
    showNotification("So long")
    Sys.sleep(1)
    showNotification("Farewell", type = "message")
    Sys.sleep(1)
    showNotification("Auf Wiedersehen", type = "warning")
    Sys.sleep(1)
    showNotification("Adieu", type = "error")
  })
}

shinyApp(ui, server)
library(shiny)
library(shinyFeedback)
library(waiter)

ui <- fluidPage(
  waiter::use_waitress(),
  numericInput("steps", "How many steps?", 10),
  actionButton("go", "go"),
  textOutput("result")
)

server <- function(input, output, session) {
  data <- eventReactive(input$go, {
    #waitress <- waiter::Waitress$new(max = input$steps)
    #waitress <- Waitress$new(selector = "#steps", theme = "overlay")
    waitress <- Waitress$new(selector = "#steps", theme = "overlay-opacity")
    on.exit(waitress$close())
    
    for (i in seq_len(input$steps)) {
      Sys.sleep(0.5)
      waitress$inc(100/input$steps)
    }
    
    runif(1)
  })
  
  output$result <- renderText(round(data(), 2))
}

shinyApp(ui, server)
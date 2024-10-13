library(shiny)
library(shinycssloaders)

ui <- fluidPage(
  actionButton("go", "go"),
  # withSpinner(plotOutput("plot")),
  withSpinner(plotOutput("plot"), type = 5, color.background = "white"),
)
server <- function(input, output, session) {
  data <- eventReactive(input$go, {
    Sys.sleep(1)
    data.frame(x = runif(50), y = runif(50))
  })
  
  output$plot <- renderPlot(plot(data()), res = 96)
}

shinyApp(ui, server)
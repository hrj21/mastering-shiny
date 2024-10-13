library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput("plot", click = "plot_click", brush = "plot_brush"),
  verbatimTextOutput("info"),
  tableOutput("near"),
  tableOutput("brushed")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point()
  }, res = 96)

  output$info <- renderPrint({
    req(input$plot_click) # so the app waits for the first click
    x <- round(input$plot_click$x, 2)
    y <- round(input$plot_click$y, 2)
    cat("[", x, ", ", y, "]", sep = "")
  })

  output$near <- renderTable({
    nearPoints(
      mtcars, 
      input$plot_click, 
      allRows = FALSE, 
      addDist = TRUE
    )
  })

  output$brushed <- renderTable({
    brushedPoints(
      mtcars, 
      input$plot_brush
    )
  })

}

shinyApp(ui, server)
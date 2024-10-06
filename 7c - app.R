library(shiny)
library(ggplot2)

ui <- fluidPage(
  sliderInput("height", "height", min = 100, max = 500, value = 250),
  sliderInput("width", "width", min = 100, max = 500, value = 250),
  plotOutput("plot", brush = "plot_brush", dblclick = "plot_reset")
)
server <- function(input, output, session) {
  selected <- reactiveVal(rep(FALSE, nrow(mtcars)))

  observeEvent(input$plot_brush, {
    brushed <- brushedPoints(mtcars, input$plot_brush, allRows = TRUE)$selected_
    selected(brushed | selected())
  })
  observeEvent(input$plot_reset, {
    selected(rep(FALSE, nrow(mtcars)))
  })

  output$plot <- renderPlot(
    width = function() input$width,
    height = function() input$height,
    res = 96, 
    {
      mtcars$sel <- selected()
      ggplot(mtcars, aes(wt, mpg)) + 
        geom_point(aes(colour = sel)) +
        scale_colour_discrete(limits = c("TRUE", "FALSE"))
    })
}

shinyApp(ui, server)
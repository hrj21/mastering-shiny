library(shiny)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")

ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("code"),
  tableOutput("static"),
  dataTableOutput("dynamic"),
  plotOutput("plot", width = "400px"),

  textInput("name", "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3),
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100),
  dateInput("dob", "When were you born?"),
  dateRangeInput("holiday", "When do you want to go on vacation next?"),
  selectInput(
    "state", 
    "What's your favourite state?", 
    state.name, 
    multiple = TRUE
  ),
  radioButtons("animal1", "What's your favourite animal?", animals),
  checkboxGroupInput("animal2", "What animals do you like?", animals),
  radioButtons("rb", "Choose one:",
    choiceNames = list(
      icon("angry"),
      icon("smile"),
      icon("sad-tear")
    ),
    choiceValues = list("angry", "happy", "sad")
  ),
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?"),
  fileInput("upload", NULL),
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail"), class = "btn-success btn-block")
)

server <- function(input, output, session) {
  output$text <- renderText({
    "Hello, friend!"
  })

  output$code <- renderPrint({
    summary(1:10)
  })

  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
  output$plot <- renderPlot(plot(1:5), res = 96)
}

shinyApp(ui, server)

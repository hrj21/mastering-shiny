library(shiny)

theme <- bslib::bs_theme(
  bg = "#0b3d91", 
  fg = "white", 
  base_font = "Source Sans Pro"
)

# bslib::bs_theme_preview()

ui <- navbarPage(
  # theme = bslib::bs_theme(bootswatch = "darkly"),
  theme = theme,
  "Page title",   
  tabPanel("panel 1", "one"),
  tabPanel("panel 2", "two"),
  tabPanel("panel 3", "three"),
  navbarMenu("subpanels", 
    tabPanel("panel 4a", "four-a"),
    tabPanel("panel 4b", "four-b"),
    tabPanel("panel 4c", "four-c")
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
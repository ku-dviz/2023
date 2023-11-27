library(ggplot2)
library(palmerpenguins)
library(shiny)

# Define UI for app that draws a histogram
ui <- fluidPage(
  # App title
  titlePanel("Hello Shiny!"),
  # Sidebar layout with input and output definitions 
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Slider for the number of bins
      # sliderInput(
      #    inputId = "bins",
      #    label = "Number of bins:",
      #    min = 1, max = 50, value = 30
      # )
      selectInput(
        inputId = "species",
        label = "Species",
        choices = unique(penguins$species)
      )
    ),
    # Main panel for displaying outputs
    mainPanel(
       # Output: Histogram
       plotOutput(outputId = "distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Process our data here
  penguins <- na.omit(penguins)
  
  s <- reactive({input$species})
  
  s_body_mass <- reactive({penguins %>% filter(species == s()) %>% select(body_mass_g)})
  
  # Plot our data here
  # output$distPlot <- renderPlot({
  #   ggplot(penguins, aes(x=body_mass_g)) + 
  #     geom_histogram(bins = input$bins) +
  #     labs(
  #       x = "Body mass(g)",
  #       main = "Body mass of Palmer Penguins"
  
  #     )
  # })
  
  output$distPlot <- renderPlot({
    ggplot(s_body_mass(), aes(x = body_mass_g)) + 
    geom_histogram() +
    labs(
      x = "Body mass(g)",
      main = "Body mass of Palmer Penguins"
    )
  })
}

shinyApp(ui = ui, server = server)



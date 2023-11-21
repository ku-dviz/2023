library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)

# European Quality of Life Dataset
qol <- read.csv("../data/eqls_2007and2011_with_labels.csv")

# Find institution trust and quality scores and get the average
institution_scores <- qol %>%
  mutate(
    trust = rowMeans(select(., matches("trust")), na.rm = TRUE),
    quality = rowMeans(select(., matches("quality")), na.rm = TRUE)
  ) %>%
  select(country_name, trust, quality)

# All unique countries
unique_countries <- unique(qol$country_name)

# Global averages for trust and quality
global_avgs <- colMeans(institution_scores[, -1], na.rm = TRUE)

server <- function(input, output) {
  # Your code here!
}

ui <- fluidPage(
  # Give the page a title
  titlePanel("Trust vs. perceived quality of institutions"),

  # Generate a row with a sidebar
  sidebarLayout(
    # Define the sidebar with one input
    sidebarPanel(
      selectInput(
        "country",
        "Country:",
        choices = unique_countries
      ),
      hr(),
      helpText("Data from the European Quality of Life Survey.")
    ),
    mainPanel(
      plotlyOutput("institPlot")
    )
  )
)

shinyApp(ui, server)

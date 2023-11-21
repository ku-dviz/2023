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
  country <- reactive({
    input$country
  })
  country_subset <- reactive({
    subset(institution_scores, country_name == country())
  })

  country_subset_avgs <- reactive({
    colMeans(country_subset()[, -1], na.rm = TRUE)
  })

  output$institPlot <- renderPlotly({
    fig <- ggplot(
      country_subset(),
      aes(x = trust, y = quality)
    ) +
      geom_point() +
      theme_classic() +
      theme(
        axis.text.x = element_text(size = 11L),
        axis.text.y = element_text(size = 11L),
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_line(color = "gray", linetype = "dashed")
      ) +
      labs(
        x = "Trust in institutions [1-10]",
        y = "Perceived quality of institutions [1-10]",
        title = paste(
          country(), ": ", "Trust = ", sprintf(country_subset_avgs()[[1L]], fmt = "%.2f"),
          ", Quality = ", sprintf(country_subset_avgs()[[2L]], fmt = "%.2f"),
          "\n Europe (blue): ", "Trust = ", sprintf(global_avgs[[1L]], fmt = "%.2f"),
          ", Quality = ", sprintf(global_avgs[[2L]], fmt = "%.2f"),
          sep = ""
        )
      ) +
      xlim(1L, 10L) +
      ylim(1L, 10L) +
      geom_vline(
        xintercept = country_subset_avgs()[[1L]],
        linetype = "dashed",
        color = "red",
        linewidth = 1.0
      ) +
      geom_hline(
        yintercept = country_subset_avgs()[[2L]],
        linetype = "dashed",
        color = "red",
        linewidth = 1.0
      ) +
      geom_vline(
        xintercept = global_avgs[[1L]],
        linetype = "dotted",
        color = "blue",
        linewidth = 1.0
      ) +
      geom_hline(
        yintercept = global_avgs[[2L]],
        linetype = "dotted",
        color = "blue",
        linewidth = 1.0
      )

    m <- list(
      l = 50L,
      r = 50L,
      b = 100L,
      t = 100L,
      pad = 4L
    )

    plotly_fig <- ggplotly(fig) %>% layout(autosize = FALSE, width = 800L, height = 800L, margin = m)

    plotly_fig
  })
}

ui <- fluidPage(

  # Give the page a title
  titlePanel("Trust vs. perceived quality of institutions"),

  # Generate a row with a sidebar
  sidebarLayout(

    # Define the sidebar with one input
    sidebarPanel(
      # Selection input
      selectInput("country", "Country:",
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

shinyApp(ui = ui, server = server)

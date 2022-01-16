#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(sf)
library(tmap)

last_updated <- file.info("data/Zoning_Districts.shp")$ctime
zoning <- read_sf("data/Zoning_Districts.shp")



# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Where in Madison can I build/open a..."),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("use", "what", choices = list(
            "Bike shop" = "bike",
            "Coffee shop" = "coffee"
          ), 
          selected = "bike"),
            p("Zoning data last updated: ", last_updated)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("mapPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$mapPlot <- renderPlot({
        tm_shape(zoning) +
        tm_polygons("ZONING_COD")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

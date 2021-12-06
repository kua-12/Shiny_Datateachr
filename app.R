library(shiny)
library(tidyverse)
library(shinythemes)
library(datateachr)
library(shinydashboard)




ui <- dashboardPage( skin = "black",
  dashboardHeader(title = "Flow Samples Data App"),
  dashboardSidebar(width = 200,
                   sidebarMenu(
                     menuItem("Dashboard", tabName = "dashboard"),
                     menuItem("Photos", tabName = "photos")
                   )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              h2("Flow Sample Data"),
      fluidRow(
      column(width = 12,
             box(sliderInput("id_slider", "Select a day", min = 1, max = 31,
                  value = c(2,10))),
      box(radioButtons(
        "my_radio", "select extreme type.",
        choices = unique(flow_sample$extreme_type))
             )
    ),
      column(width = 12,
        box(plotOutput("id_histogram")),
        DT::dataTableOutput("id_table")
             )
    )
              ),
      
      tabItem(tabName = "photos",
              h2("Photos of Flow Sampling"),
              img(src = "river1.jpg", height="50%", width="50%"),
              img(src = "river2.jpg", height="50%", width="50%"))
    )

  )
)

server <- function(input, output) {

  observe(print(input$id_slider))
  
  flow_sample_filtered <- reactive({
    flow_sample %>%
    filter(day < input$id_slider[2],
           day > input$id_slider[1],
           extreme_type == input$my_radio)
  })
  
  # Create histogram for each extreme type in each season
  output$id_histogram <- renderPlot({
    flow_sample_filtered() %>%
    ggplot(aes(month)) + 
    geom_histogram()
  })
  
  output$id_table <- DT::renderDataTable({
    flow_sample_filtered()
  })
  
 
}

shinyApp(ui = ui, server = server)

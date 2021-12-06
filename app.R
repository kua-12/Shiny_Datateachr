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
             box(sliderInput("id_slider3", "Select a year", min = 1909, max = 2018,
                             value = c(1919,2017))),
             box(sliderInput("id_slider", "Select a day of month", min = 1, max = 31,
                  value = c(2,30))),
             box(sliderInput("id_slider2", "Select a flow", min = 1, max = 467,
                             value = c(2,400))),
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
    filter(
      year < input$id_slider3[2],
      year > input$id_slider3[1],
      day < input$id_slider[2],
           day > input$id_slider[1],
           flow < input$id_slider2[2],
           flow > input$id_slider2[1],
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

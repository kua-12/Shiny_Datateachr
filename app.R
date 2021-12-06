library(shiny)
library(tidyverse)
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
              tags$br(),
              h4("Purpose: Modify and Explore Flow Sample Data"),
              tags$br(),
              h4("This is an app that helps you explore the Flow Sample data set from Datateachr. 
                 This app includes a histogram that filters the count over each season by day, year, and by extreme type. "),
              tags$br(),
              h4("For Assignment B4, I included several features that will be useful for the user.
                 First, I created slider to specify the day of the month that the user is interested in.
                 Second, I input radio buttons for the user to choose by extreme type. 
                 Third, I input a histogram that is reactive to the radio button and slider filters, 
                 which shows the number of data points over specific months. 
                 Fourth, I added a interactive table for the user to view the data. 
                 Fifth, I incorporated the shiny dashboard to make the app visually appealing.
                 Sixth, I added a slider to specify years of interest. 
                 Finally, I added an extra tab for pictures of flow sampling. "),
              tags$br(),
              h4("Keep in mind Seasonal Flow! When exploring the data, no data means that the parameters are not
                 appropriate for the season or the extreme type"),
              tags$br(),
              tags$br(),
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

---
Title: "STAT 545B - Assignment B4"
Date: "05 December 2021"
Author: "Andrea Ku"
output: github_document
---

# Shiny_Datateachr
Shiny App using Datateachr package

# This Shiny app was created for Stat545B Assignment B4
Option 4, Starting a new app from scratch!

# Running Instance of my Shiny App:
https://akustat545b.shinyapps.io/shiny_datateachr/


# Description:

This is an app that helps you explore the Flow Sample data set from Datateachr. This app includes a histogram that filters the count over each season by day and by extreme type. 

For Assignment B4, I included several features that will be useful for the user. First, I created slider to specify the day of the month that the user is interested in. Second, I input radio buttons for the user to choose by extreme type. Third, I input a histogram that is reactive to the radio button and slider filters, which shows the number of data points over specific months. Fourth, I added a interactive table for the user to view the data. Fifth, I incorporated the shiny dashboard to make the app visually appealing. Finally, I added an extra tab for pictures of flow sampling. 


# Data Source:
This data is from datateachr package, and the Shiny framework is from the STAT545B website and built upon the lecture given by Dr. Vincenzo Coia at UBC.
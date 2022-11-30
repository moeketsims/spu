library(shiny)
library(ggplot2)
library(tidyverse)
library(shinyWidgets)
library(graphics)
library(purrr)
library(DT)
library(readxl)
library(wordcloud2)
library(stringr)
library(shinydashboard)
library(shinydashboardPlus)
library("fdrtool")
library(quanteda)
library(stm)

library(tm)
library(tmap)
require(quanteda.corpora)
require(seededlda)
library(quanteda.textplots)

fluidPage(
  includeCSS("www/styles.css"),
  
  titlePanel(tags$i(
    h1(strong("An Intelligent Early Warning System for Unrest: Using Social-Media Data"), 
       style = "font-family: 'times'; font-size: 25px; text-align: center")
      )
    ),
  
  
  navbarPage(
    theme = "https://stackpath.bootstrapcdn.com/bootswatch/3.4.1/flatly/bootstrap.min.css",
    title = 'Service deliverly',
   tabPanel("Wordloud",
            sidebarLayout(
              sidebarPanel(width = 2,
                sliderInput("size", "Cloud Size", min = 0, max = 7, value = 0.7, step = 0.5)
              ),
              mainPanel(width = 10,
                fluidRow(
                  column(width = 8,
                         wordcloud2Output('wordcloud2', height = 600, width = '90%'),
                  ),
                  column(width = 4,
                         plotOutput('plot1',height = 600)
                  )
                )
              )
            )
   ),
   
   
   tabPanel("Topic Modelling",
            sidebarLayout(
              sidebarPanel(width = 2,
                           sliderInput("size", "Cloud Size", min = 0, max = 7, value = 0.7, step = 0.5)
              ),
              mainPanel(width = 10,
                        fluidRow(
                          column(width = 12,
                                 plotOutput('plot3')
                          )
                        )
              )
            )
   )
   
   )
)

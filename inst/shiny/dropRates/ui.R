#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

source("rewards.R")
possible_rewards <- sort(unique(rewards$reward))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Star Wars Galaxy of Heroes: Reward Drop Rates"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectizeInput(
         inputId  = "reward",
         label    = "Reward:",
         choices  = possible_rewards,
         selected = "Hera Syndulla")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot",plotOutput("plot")),
                  tabPanel("Data", tableOutput("table"))
                  
      )
    )
  )
))

#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library("shiny")
library("tidyverse")
source("rewards.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  d <- reactive( { 
    rewards %>%
      filter(reward == input$reward)
  })
  
  output$plot <- renderPlot({
    ggplot(d(), aes(x = n_sims, y = p, ymin = lb, ymax = ub)) + 
      geom_pointrange() + 
      facet_wrap(~battle) + 
      labs(x = "Number of simulations (0 indicates battle was fought manually)", 
           y = "Drop rate") +
      theme_bw(base_size = 18)
    
  })
  
  output$table <- renderTable({
    d() %>%
      arrange(battle, n_sims) %>%
      rename(attempts = n,
             successes = y) %>%
      select(battle, n_sims, attempts, successes, p)
  })
  
})

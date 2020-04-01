source("rewards.R")

default <- list(type = "Character", 
                subtype = "Light Side", 
                reward = "Hera Syndulla")

possible_types    <- sort(unique(rewards$type))
possible_subtypes <- sort(unique(rewards$subtype[rewards$type == default$type]))
possible_rewards  <- sort(unique(rewards$reward[rewards$subtype == default$subtype]))

shinyUI(fluidPage(
  
  titlePanel("Star Wars Galaxy of Heroes: Reward Drop Rates"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "type",
        label = "Type:",
        choices = possible_types,
        selected = default$type),
      
      selectInput(
        inputId = "subtype",
        label = "Subtype:",
        choices = possible_subtypes,
        selected = default$subtype),
      
       selectInput(
         inputId  = "reward",
         label    = "Reward:",
         choices  = possible_rewards,
         selected = default$reward)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot",plotOutput("plot")),
                  tabPanel("Data", tableOutput("table"))
                  
      )
    )
  )
))

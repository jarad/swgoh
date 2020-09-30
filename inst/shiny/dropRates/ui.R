source("rewards.R")

# default <- list(type = "Character", 
#                 subtype = "Light Side", 
#                 reward = "Hera Syndulla")
# 
# possible_types    <- sort(unique(rewards$type))
# possible_subtypes <- sort(unique(rewards$subtype[rewards$type == default$type]))
# possible_rewards  <- sort(unique(rewards$reward[rewards$subtype == default$subtype]))


possible_rewards = list(
  `Choose reward` = "",
  `Characters` = swgoh::reward_details$reward[swgoh::reward_details$type == "Character"],
  `Component` = swgoh::reward_details$reward[swgoh::reward_details$type == "Component"],
  `Ability Material` = swgoh::reward_details$reward[swgoh::reward_details$type == "Ability Material"],
  `Signal Data` = swgoh::reward_details$reward[swgoh::reward_details$type == "Signal Data"],
  `Ship` = swgoh::reward_details$reward[swgoh::reward_details$type == "Ship"],
  `Ship Component` = swgoh::reward_details$reward[swgoh::reward_details$type == "Ship Component"],
  `Ship Ability Material` = swgoh::reward_details$reward[swgoh::reward_details$type == "Ship Ability Material"]
)

shinyUI(fluidPage(
  
  titlePanel("Star Wars Galaxy of Heroes: Reward Drop Rates"),
  
  sidebarLayout(
    sidebarPanel(
      # selectInput(
      #   inputId = "type",
      #   label = "Type:",
      #   choices = possible_types,
      #   selected = default$type),
      # 
      # selectInput(
      #   inputId = "subtype",
      #   label = "Subtype:",
      #   choices = possible_subtypes,
      #   selected = default$subtype),
      
       selectizeInput(
         inputId  = "reward",
         label    = "Reward:",
         choices  = possible_rewards)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot",plotOutput("plot")),
                  tabPanel("Data", tableOutput("table"))
                  
      )
    )
  )
))

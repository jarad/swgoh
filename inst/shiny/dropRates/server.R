source("rewards.R")

shinyServer(function(input, output, session) {
  
  observe({
    updateSelectInput(
      session, 
      inputId = "subtype",
      choices = sort(unique(rewards$subtype[rewards$type == input$type]))
    )
  })
  
  observe({
    updateSelectInput(
      session, 
      inputId = "reward",
      choices = sort(unique(rewards$reward[rewards$subtype == input$subtype]))
    )
  })
  
  d <- reactive( { 
    rewards %>%
      filter(reward == input$reward)
  })
  
  p <- reactive({
    sum(d()$y)/sum(d()$n)
  })
  
  output$plot <- renderPlot({
    ggplot2::ggplot(d(), aes(x = n_sims, y = p, ymin = lb, ymax = ub)) + 
      geom_pointrange() + 
      facet_wrap(~battle) + 
      labs(x = "Number of simulations (0 indicates battle was fought manually)", 
           y = "Drop rate") +
      geom_hline(yintercept = p(), col="red") +
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

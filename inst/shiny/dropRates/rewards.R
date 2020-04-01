library("shiny")
library("tidyverse")

rewards <- swgoh::rewards %>%
  
  dplyr::mutate(n_sims = ifelse(simulated, attempts, 0)) %>%
  dplyr::group_by(battle, reward, n_sims) %>%
  dplyr::summarize(
    n = sum(attempts) + sum(!simulated),
    y = sum(count)) %>%
  dplyr::ungroup() %>%
  
  left_join(swgoh::reward_details, by = "reward") %>%
  
  # Binomial model with Jeffreys prior
  dplyr::mutate(
    a = 0.5 + y,
    b = 0.5 + n - y,
    p  = y / n,
    
    lb = qbeta(.025, a, b),
    ub = qbeta(.975, a, b),
    
    lb = ifelse(p==0, 0, lb),
    ub = ifelse(p==0, qbeta(.95, a, b), ub),
    
    lb = ifelse(p==1, qbeta(.05, a, b), lb),
    ub = ifelse(p==1, 1, ub),
    
    n_sims = as.integer(n_sims)) 

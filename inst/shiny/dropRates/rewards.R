library("tidyverse")

rewards <- swgoh::rewards_complete %>%
  
  mutate(n_sims = ifelse(simulated, attempts, 0)) %>%
  group_by(battle, reward, n_sims) %>%
  summarize(n = sum(attempts) + sum(!simulated),
            y = sum(count)) %>%
  ungroup() %>%
  
  # Binomial model with Beta(1,1) prior
  mutate(a = 1 + y,
         b = 1 + n - y,
         p  = y / n,
         
         lb = qbeta(.025, a, b),
         ub = qbeta(.975, a, b),
         
         lb = ifelse(p==0, 0, lb),
         ub = ifelse(p==0, qbeta(.95, a, b), ub),
         
         lb = ifelse(p==1, qbeta(.05, a, b), lb),
         ub = ifelse(p==1, 1, ub),
         
         n_sims = as.integer(n_sims)) 
  
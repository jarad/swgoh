# 
if (!exists("battles"))
  source("battles.R")

if (!exists("battle_rewards"))
  source("battle_rewards.R")

if (!exists("rewards"))
  source("rewards.R")

# Complete the rewards data by including 0 counts

rewards_complete <- battles %>%
  dplyr::left_join(battle_rewards, by = "battle") %>%
  dplyr::left_join(rewards, by = c("battleID", "reward")) %>%
  
  mutate(count = ifelse(is.na(count), 0, count),
         count = as.integer(count))

usethis::use_data(rewards_complete, overwrite = TRUE)

library("dplyr")
library("tidyr")
library("readr")

if (!exists("battles"))        source("battles.R")
if (!exists("battle_rewards")) source("battle_rewards.R")

################################################################################
# Rewards

read_reward_csv = function(f, into) {
  readr::read_csv(f, 
                  col_types = readr::cols(
                    battleID = readr::col_integer(),
                    reward   = readr::col_character(),
                    count    = readr::col_integer()
  )) %>%
    dplyr::mutate(file=f) %>%
    tidyr::separate(file, into) 
}


read_reward_dir = function(path, pattern, into) {
  files = list.files(path = path,
                     pattern = pattern,
                     recursive = TRUE,
                     full.names = TRUE)
  plyr::ldply(files, read_reward_csv, into = into)
}

################################################################################

rewards_raw <- read_reward_dir(path    = "rewards",
                           pattern = "*.csv",
                           into    = c("rewards","date","extension")) %>%
  
  dplyr::mutate(
    date = gsub("r", "", date),
    battleID = paste0(date, "-", formatC(battleID, width = 3, flag = "0"))) %>% 
  
  dplyr::select(battleID, reward, count) 
  

rewards <- battles %>%
  dplyr::left_join(battle_rewards, by = "battle") %>%
  dplyr::left_join(rewards_raw,    by = c("battleID", "reward")) %>%
  
  mutate(count = ifelse(is.na(count), 0, count),
         count = as.integer(count))



usethis::use_data(rewards_raw, overwrite = TRUE)
usethis::use_data(rewards,     overwrite = TRUE)
  
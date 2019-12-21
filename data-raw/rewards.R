library("dplyr")
library("tidyr")
library("readr")

# Create reward data set by joining battle and reward files and converting 
# dataset to a wide data set with lots of zeros

################################################################################
# Battles

read_battle_csv = function(f, into) {
  readr::read_csv(f, 
                  col_types = readr::cols(
                    battleID = readr::col_integer(),
                    userID   = readr::col_integer(),
                    battle   = readr::col_character(),
                    n_sims   = readr::col_integer()
  )) %>%
    dplyr::mutate(file=f) %>%
    tidyr::separate(file, into) 
}

read_battle_dir = function(path, pattern, into) {
  files = list.files(path = path,
                     pattern = pattern,
                     recursive = TRUE,
                     full.names = TRUE)
  plyr::ldply(files, read_battle_csv, into = into)
}

battles <- read_battle_dir(path    = "battles",
                           pattern = "*.csv",
                           into    = c("rewards","date","extension")) %>%
  
  dplyr::mutate(
    date      = gsub("b", "", date), 
    battleID  = paste0(date, "-", formatC(battleID, width = 3, flag = "0")),
    date      = as.Date(date, format = "%Y%m%d"),
    simulated = ifelse(n_sims == 0, FALSE, TRUE),
    n         = n_sims + (n_sims == 0)) %>%
  
  select(date, battleID, userID, battle, simulated, n)



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

rewards <- read_reward_dir(path    = "rewards",
                           pattern = "*.csv",
                           into    = c("rewards","date","extension")) %>%
  
  dplyr::mutate(
    date = gsub("r", "", date),
    battleID = paste0(date, "-", formatC(battleID, width = 3, flag = "0"))) %>% 
  
  select(battleID, reward, count) %>%
  
  dplyr::full_join(battles, by="battleID") %>%
  
  dplyr::mutate(count = as.integer(count)) %>%
  tidyr::spread(reward, count, fill=0)
  

usethis::use_data(rewards, overwrite = TRUE)
  
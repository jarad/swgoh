library(dplyr)
library(tidyr)

my_read_csv = function(f, into) {
  readr::read_csv(f) %>%
    dplyr::mutate(file=f) %>%
    tidyr::separate(file, into) 
}

read_dir = function(path, pattern, into) {
  files = list.files(path = path,
                     pattern = pattern,
                     recursive = TRUE,
                     full.names = TRUE)
  plyr::ldply(files, my_read_csv, into = into)
}

static <- c("Player XP", "Credits","Ally Point","Cantina Battle Tokens",
            "Ship Building Materials","Sim Tickets",
            "T1 Training Droid","T2 Training Droid","T3 Training Droid",
            "T1 Enhancement Droid")


########################################################################
  
rewards <- read_dir(path    = "rewards",
                    pattern = "*.csv",
                    into    = c("rewards","date","extension")) %>%
  
  dplyr::mutate(
    battleID = paste0(gsub("r", "b", date), "-",
                      formatC(battleID, width = 3, flag = "0"))) %>% 
  
  dplyr::select(battleID, reward, count)

rewards_static <- rewards %>% filter(   reward %in% static  )
rewards        <- rewards %>% filter( !(reward %in% static) )
  

usethis::use_data(rewards,        overwrite = TRUE)
usethis::use_data(rewards_static, overwrite = TRUE)
  
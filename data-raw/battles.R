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

########################################################################
  
battles <- read_dir(path    = "battles",
                    pattern = "*.csv",
                    into    = c("battles","date","extension")) %>%
  
  dplyr::mutate(
    battleID = paste0(date, "-",
                      formatC(battleID, width = 3, flag = "0")),
    date     = as.Date(date, format = "b%Y%m%d")) %>% 
  
  dplyr::select(date, battleID, userID, battle_name, n_sims)

usethis::use_data(battles, overwrite = TRUE)
  
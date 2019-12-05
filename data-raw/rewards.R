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
  
reward <- read_dir(path    = "rewards",
                    pattern = "*.csv",
                    into    = c("rewards","date","extension")) %>%
  
  dplyr::mutate(
    battleID = paste0(gsub("r", "b", date), "-",
                      formatC(battleID, width = 3, flag = "0"))) %>% 
  
  dplyr::select(battleID, reward, count)

usethis::use_data(reward, overwrite = TRUE)
  
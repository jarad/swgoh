library("dplyr")
library("tidyr")
library("readr")

################################################################################
# bronzium

read_bronzium_csv = function(f, into) {
  readr::read_csv(f, 
                  col_types = readr::cols(
                    userID = readr::col_character(),
                    type   = readr::col_character(),
                    reward = readr::col_character(),
                    amount = readr::col_integer()
  )) %>%
    dplyr::mutate(file=f) %>%
    tidyr::separate(file, into) 
}

read_bronzium_dir = function(path, pattern, into) {
  files = list.files(path = path,
                     pattern = pattern,
                     recursive = TRUE,
                     full.names = TRUE)
  plyr::ldply(files, read_bronzium_csv, into = into)
}

################################################################################

bronzium <- read_bronzium_dir(path    = "store",
                           pattern = "*.csv",
                           into    = c("store","date","extension")) %>%
  
  dplyr::mutate(
    date = gsub("bronzium", "", date),
    date = as.Date(date, format = "%Y%m%d")) %>% 
  
  dplyr::select(userID, type, reward, amount) 
  

usethis::use_data(bronzium, overwrite = TRUE)
  
library("testthat")
library("tidyverse")

source("files.R")

files <- paste0("../users/", unique(format(dates, "%Y-%m")), ".csv")

for (i in seq_along(files)) {
  file <- files[i]
  
  d <- readr::read_csv(file, 
                       col_types = readr::cols(
                         date    = readr::col_date(format = "%Y-%m-%d"),
                         userID  = readr::col_character(),
                         level   = readr::col_integer(),
                         power   = readr::col_integer()
                       ))
  
  test_that(paste0("userIDs are correct in ", file),
            expect_true(all(d$userID %in% as.integer(1:4)))
            )
  
  test_that(paste0("levels are in proper range", file),
            {
            expect_true(all(d$level > 0))
            expect_true(all(d$level < 86))
            }
            )
  
  for (user in 1:4) {
    dd <- d %>% 
      filter(userID == user) 
    
    test_that(
      paste0("level is non-decreasing in ", file, ", user=", user),
      expect_true(all(diff(na.omit(dd$level)) >= 0))
    )
    
    test_that(
      paste0("power is non-decreasing in ", file, ", user=", user),
      expect_true(all(diff(na.omit(dd$power)) >= 0))
    )
  }
  
  
  
}
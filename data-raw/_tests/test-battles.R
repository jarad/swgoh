library("testthat")
library("tidyverse")

source("files.R")

for (i in seq_along(files$battle)) {
  file <- files$battle[i]
  
  d <- readr::read_csv(file, 
                       col_types = cols(
                         battleID = col_integer(),
                         userID   = col_character(),
                         battle   = col_character(),
                         n_sims   = col_integer()
                       ))
  
  test_that(
    paste(file,"has the correct columns"),
    expect_equal(names(d), c("battleID","userID","battle","n_sims"))
  )
  
  test_that(
    paste(file, "battleIDs are sequential"),
    expect_true(all(diff(d$battleID) == 1))
  )

  for (r in 1:nrow(d)) {
    test_that(
      paste(file, r, d$userID[r], "userIDs in 1:4"),
      expect_true(d$userID[r] %in% as.integer(1:4))
    )
    
    test_that(
      paste(file, r, d$battle[r], "battles are known"),
      expect_true(d$battle[r] %in% battle_rewards$battle)
    )
    
    test_that(
      paste(file, r, d$n_sims[r], "0 <= n_sims <= 20"),
      expect_true(0 <= d$n_sims[r] & d$n_sims[r] <= 20)
    )
    
    if (grepl("hard", d$battle[r])) {
      test_that(
        paste(file, r, d$n_sims[r], "n_sims (hard) <= 5"),
        expect_true(d$n_sims[r] <= 5)
      )
    }
  }
}
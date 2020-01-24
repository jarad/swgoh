library("testthat")
library("readr")
library("dplyr")

# source("check_md5ums.R")
load("../../data/battle_rewards.rda")

col_types <- cols(
  battleID = col_integer(),
  userID   = col_integer(),
  battle   = col_character(),
  n_sims   = col_integer()
)

battle_files <- list.files(path = "../battles/",
                           pattern = "*.csv",
                           recursive = TRUE,
                           full.names = TRUE)

changed_battle_files <- battle_files

# md5sums <- check_md5sums(files = battle_files,
#               md5sum_file = "battle_files.md5sum")
# 
# changed_battle_files = md5sums %>%
#   filter(changed)
# 
# check_battle_file = function(file) {
#   any_error = FALSE
# 
#   if (!isTRUE())
# }

for (i in seq_along(changed_battle_files)) {
  file <- changed_battle_files[i]
  d <- readr::read_csv(file, col_types = col_types)
  
  test_that(
    paste(file,"has the correct columns"),
    expect_equal(names(d), c("battleID","userID","battle","n_sims"))
  )
  
  test_that(
    paste(file, "battleIDs are sequential"),
    expect_true(all(diff(d$battleID) == 1))
  )
  
  # test_that(
  #   paste(file, "userIDs in 1,2,3"),
  #   last_test = expect_true(all(d$userID %in% as.integer(1:4)))
  # )
  
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
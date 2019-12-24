library("testthat")
library("readr")
library("dplyr")

col_types <- cols(
  battleID = col_integer(),
  userID   = col_integer(),
  battle   = col_character(),
  n_sims   = col_integer()
)

load("../../data/battle_rewards.rda")

battle_files <- list.files(path = "../battles/",
                           pattern = "*.csv",
                           recursive = TRUE,
                           full.names = TRUE)

# # Figure out how to check md5sums for changes
# md5sums <- vapply(battle_files, 
#                   FUN = function(x) tools::md5sum(x),
#                   FUN.VALUE = character(1)) 
# 
# if (file.exists("battle_files.md5sums")) {
#   old <- readr::read_csv("battle_files.md5sums")
#   
#   keep = numeric()
#   m <- match(battle_files, old$files)
#   
#   for (i in seq_along(m)) {
#     
#     
#     if (old$md5sums[old$file == "foo"]
#   }
# }
# 
# for (i in seq_along(battle_files)) {
#   file <- battle_files[i]
#   
# }


for (i in seq_along(battle_files)) {
  file <- battle_files[i]
  d <- readr::read_csv(file, col_types = col_types)
  
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
      paste(file, r, d$userID[r], "userIDs in 1,2,3"),
      expect_true(d$userID[r] %in% as.integer(1:3))
    )
    
    test_that(
      paste(file, r, d$battle[r], "battles are known"),
      expect_true(d$battle[r] %in% battle_rewards$battle)
    )
    
    test_that(
      paste(file, r, d$n_sims[r], "n_sims have reasonable numbers"),
      expect_true(0 <= d$n_sims[r] & d$n_sims[r] <= 20)
    )
  }
}
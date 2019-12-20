library("testthat")
library("readr")
library("dplyr")

col_types <- cols(
  battleID = col_integer(),
  reward   = col_character(),
  count    = col_integer()
)

load("../../data/level_rewards.rda")

reward_files <- list.files(path = "../rewards/",
                           pattern = "*.csv",
                           recursive = TRUE,
                           full.names = TRUE)

# # Figure out how to check md5sums for changes
# md5sums <- vapply(reward_files, 
#                   FUN = function(x) tools::md5sum(x),
#                   FUN.VALUE = character(1)) 
# 
# if (file.exists("reward_files.md5sums")) {
#   old <- readr::read_csv("reward_files.md5sums")
#   
#   keep = numeric()
#   m <- match(reward_files, old$files)
#   
#   for (i in seq_along(m)) {
#     
#     
#     if (old$md5sums[old$file == "foo"]
#   }
# }
# 
# for (i in seq_along(reward_files)) {
#   file <- reward_files[i]
#   
# }


for (i in seq_along(reward_files)) {
  file <- reward_files[i]
  d <- readr::read_csv(file, col_types = col_types)
  
  test_that(
    paste(file,"has the correct columns"),
    
    expect_equal(names(d), c("battleID","reward","count"))
  )
  
  test_that(
    paste(file, "battleIDs are increasing"),
    expect_true(all(diff(d$battleID) >= 0))
  )
  
  test_that(
    paste(file, "rewards are known"),
    expect_true(all(d$reward %in% level_rewards$reward))
  )
  
  test_that(
    paste(file, "count has reasonable numbers"),
    expect_true(all(0 <= d$count & d$count <= 20))
  )
}
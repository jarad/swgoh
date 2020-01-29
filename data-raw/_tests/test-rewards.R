library("testthat")
library("tidyverse")

load("../../data/battle_rewards.rda")
source("update_md5sums.R")

changed <- md5sums %>%
  filter(!is.na(reward_filename), !passed)


for (i in nrow(changed):1) {
  file <- changed$reward_filename[i] 
  
  d <- readr::read_csv(file, 
                       col_types = cols(
                         battleID = col_integer(),
                         reward   = col_character(),
                         count    = col_integer()
                       )) 
  
  # Check just reward file
  test_that(
    paste(file,"has the correct columns"),
    
    expect_equal(names(d), c("battleID","reward","count"))
  )
  
  test_that(
    paste(file, "battleIDs are increasing"),
    expect_true(all(diff(d$battleID) >= 0))
  )
  
  # Compare to battle data
  d <- d %>%
    left_join(readr::read_csv(changed$battle_filename[i], 
                              col_types = cols(
                                battleID = col_integer(),
                                userID   = col_integer(),
                                battle   = col_character(),
                                n_sims   = col_integer()
                              )) %>%
                mutate(n_sims = ifelse(n_sims == 0, 1, n_sims)),
              by = "battleID")
  
  
  for (j in nrow(d):1) {
    br <- battle_rewards %>% filter(battle == d$battle[j])
    
    test_that(
      paste0("reward doesn't match battle in:\n",
             "file: ", file, "\n",
             "line: ", j+1, "\n",
             "battleID: ", d$battleID[j], "\n",
             "reward: ", d$reward[j], "\n",
             "battle: ", d$battle[j]),
      expect_true(d$reward[j] %in% br$reward)
    )
    
    test_that(
      paste0("count isn't consistent with number of attempts in:\n",
             "file: ", file, "\n",
             "line: ", j+1, "\n",
             "battleID: ", d$battleID[j], "\n",
             "count: ", d$count[j], "\n",
             "n_sims: ", d$n_sims[j]),
      # paste(file, j, "0 <=", d$count[j], "<= n_sims"),
      expect_true(0 < d$count[j] & d$count[j] <= d$n_sims[j])
    )
  }
}
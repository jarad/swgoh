library("testthat")
library("tidyverse")

source("files.R")

for (i in seq_along(files$reward)) {
  file <- files$reward[i]
  
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
    paste(file, "battleIDs are non-decreasing"),
    expect_true(all(diff(d$battleID) >= 0))
  )
  
  # Compare to battle data
  d <- d %>%
    left_join(readr::read_csv(files$battle[i], 
                              col_types = cols(
                                battleID = col_integer(),
                                userID   = col_integer(),
                                battle   = col_character(),
                                n_sims   = col_integer()
                              )) %>%
                mutate(n_sims = ifelse(n_sims == 0, 1, n_sims)),
              by = "battleID")
  
  #
  # IG-11 and Kuiil were bonus awards in all Cantina battles from 2020/12/16 to ?
  #
  d_tmp <- d %>% filter(reward %in% c("IG-11","Kuiil"))
  
  if (nrow(d_tmp) > 0) {
    test_that(
      paste0("IG-11 and Kuiil are only in Cantina battles",
             "file: ", file, "\n"),
      expect_true(all(grepl("Cantina", d_tmp$battle)))
    )
    
    date = as.Date(substr(file, 13, 20), format = "%Y%m%d")
    test_that(
      paste0("IG-11 and Kuiil bonus award dates are between 2020/12/16 and 2021/?/?",
             "file: ", file, "\n"),
      expect_true(date >= as.Date("2020/12/16"))
    )
  }
  d <- d %>%
    filter(!(reward %in% c("IG-11","Kuiil")))
  # 
  # end of IG-11 and Kuiil special treatment
  #
  
  
  for (j in nrow(d):1) {
    br <- battle_rewards %>% 
      filter(battle == d$battle[j]) 
    
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
      expect_true(0 < d$count[j] & 
                    d$count[j] <= 2*d$n_sims[j] + 
                      # double rewards for the following rewards
                      d$n_sims[j] * 
                        (d$reward[j] %in% c("Fragmented Signal Data",
                                        "Incomplete Signal Data",
                                        "Flawed Signal Data")) 
      )
    )
  }
}
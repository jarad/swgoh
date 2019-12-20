level_rewards <- readr::read_csv("level_rewards.csv",
                                 col_types = cols(
                                   battle = col_character(),
                                   reward = col_character()
                                 ))

usethis::use_data(level_rewards, overwrite = TRUE)

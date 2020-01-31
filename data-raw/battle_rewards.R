battle_rewards <- readr::read_csv("battle_rewards/battle_rewards.csv",
                                  col_types = readr::cols(
                                    battle = readr::col_character(),
                                    reward = readr::col_character()
                                  ))

usethis::use_data(battle_rewards, overwrite = TRUE)

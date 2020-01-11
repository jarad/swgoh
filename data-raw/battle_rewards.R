battle_rewards <- readr::read_csv("battle_rewards/battle_rewards.csv",
                                  col_types = cols(
                                    battle = col_character(),
                                    reward = col_character()
                                  ))

usethis::use_data(battle_rewards, overwrite = TRUE)

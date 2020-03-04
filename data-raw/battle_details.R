battle_details <- readr::read_csv("battle_details/battle_details.csv",
                                  col_types = readr::cols(
                                    battle = readr::col_character(),
                                    energy = readr::col_integer()
                                  ))

usethis::use_data(battle_details, overwrite = TRUE)



battle_rewards <- readr::read_csv("battle_details/battle_rewards.csv",
                                  col_types = readr::cols(
                                    battle = readr::col_character(),
                                    reward = readr::col_character()
                                  ))

usethis::use_data(battle_rewards, overwrite = TRUE)

reward_details <- readr::read_csv("reward_details/reward_details.csv",
                                  col_types = readr::cols(
                                    reward  = readr::col_character(),
                                    type    = readr::col_character(),
                                    subtype = readr::col_character()
                                  )) %>%
  arrange(type, subtype, reward)

usethis::use_data(reward_details, overwrite = TRUE)

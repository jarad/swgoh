users <- readr::read_csv("users.csv", 
                         col_types = readr::cols(
                           date = col_date(format = "%Y-%m-%d"),
                           userID = col_integer(),
                           level = col_integer()
                         ))

usethis::use_data(users, overwrite = TRUE)

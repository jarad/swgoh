library("tidyverse")

###############################################################################
# Get filenames and extract date

get_files <- function(path) {
  tibble(
    filename = list.files(path = path,
                          pattern = "*.csv",
                          recursive = TRUE,
                          full.names = TRUE)) %>%
    mutate(date = regmatches(filename, regexpr("[[:digit:]]+", filename)),
           date = as.Date(date, format = c("%Y%m%d")))
}

files = list()
files$battle   = get_files("../battles") 
files$reward   = get_files("../rewards") 
files$bronzium = get_files("../store") 


################################################################################
# Get current md5sums

get_md5sums <- function(files) {
  vapply(files,
         FUN = function(x) tools::md5sum(x),
         FUN.VALUE = character(1))
}

files$battle$new_battle_md5sum     = get_md5sums(files$battle$filename)
files$reward$new_reward_md5sum     = get_md5sums(files$reward$filename)
files$bronzium$new_bronzium_md5sum = get_md5sums(files$bronzium$filename)

if (!file.exists("md5sum.csv")) {
  # Create md5sum.csv
}


################################################################################
# Compare to old md5sums

md5sums = read_csv("md5sum.csv") %>%
  
  left_join(files$battle   %>% rename(battle_filename   = filename)) %>%
  left_join(files$reward   %>% rename(reward_filename   = filename)) %>%
  left_join(files$bronzium %>% rename(bronzium_filename = filename)) %>%
  
  mutate(passed = passed & 
           (battle_md5sum == new_battle_md5sum) &
           (reward_md5sum == new_reward_md5sum),
         
         # bronzium files are every 7 days
         passed = ifelse(is.na(new_bronzium_md5sum), 
                         passed, 
                         passed & (bronzium_md5sum == new_bronzium_md5sum)),
         
         battle_md5sum = new_battle_md5sum,
         reward_md5sum = new_reward_md5sum,
         bronzium_md5sum = new_bronzium_md5sum) %>%
  
  select(date, passed, 
         battle_filename, reward_filename, bronzium_filename,
         battle_md5sum, reward_md5sum, bronzium_md5sum)

write_csv(md5sums,
          path = "md5sum.csv")

dates <- Sys.Date()-1
# dates <- seq(as.Date("2019-12-03"), Sys.Date(), "days") # uncomment to test all files

files <- data.frame(
  battle = paste0("../battles/b", format(dates, "%Y%m%d"), ".csv"),
  reward = paste0("../rewards/r", format(dates, "%Y%m%d"), ".csv"),
  
  stringsAsFactors = FALSE
)

load("../../data/battle_rewards.rda")

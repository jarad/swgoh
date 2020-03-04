# Data

These data sets are created by the `run_all.R` script:

  - battles: battles fought
  - rewards: battle rewards
  - users: daily user information including level and galactic power
  - store/bronzium: bronzium cards purchased in the store
  - battle_details: battle energy cost
  - battle_rewardss: possible battle rewards
  

  
## battles

Files with filename bYYYYMMDD.csv containing the following columns:

  - battleID: sequence of integers starting each day at 1
  - userID: designated user identification number
  - battle: battle name
  - n_sims: number of times the battle was simulated, if 0 then the battle was fought
  
## rewards

Files with filenames rYYYYMMDD.csv containing the following columns:

  - battleID: battle identification number for that day
  - reward: reward name
  - count: number of that reward received
  
## users

Files with filenames YYYY-MM.csv containing the following columns:

  - date: date in YYYY-MM-DD format
  - userID: designated user identification number
  - level: the level for that user at the start of the day
  - power: the galactic power for that user at the start of the day
  
## store

The store data currently only contains bronzium card data. 
Bronzium cards have filenames bronziumYYYYMMDD.csv and containg the following
columns:

  - userID: designated user identification number
  - type: whether the card was purchased for `free` or was `paid` for using ally points
  - reward: the reward received
  - amount: the amount of that reward received
  
  
## battle_details/

Two files containing static battle details:

battle_details.csv columns:

  - battle
  - energy

battle_rewards.csv columns:

  - battle
  - reward
  
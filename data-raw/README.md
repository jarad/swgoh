# Data

Three data sets

  - battles: contains all battles fought
  - rewards: contains rewards for those battles
  - users: contains level information for specific users
  - store/bronzium: contains data for bronzium cards purchased in the store
  - battle_rewards: static directory/file contain possible battle rewards
  
The battles and rewards data set have a new file created each day while
the users data set has a new file each month.
  
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
  
## store

The store data currently only contains bronzium card data. 
Bronzium cards have filenames bronziumYYYYMMDD.csv and containg the following
columns:

  - userID: designated user identification number
  - type: whether the card was purchased for `free` or was `paid` for using ally points
  - reward: the reward received
  - amount: the amount of that reward received
  
## battle_rewards

A static file containing each battle and the possible rewards from that battle.
The file is battle_rewards.csv and contains the columns:

  - battle
  - reward
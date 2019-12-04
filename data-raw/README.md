# Data

Three data sets

  - battles: contains all battles fought
  - rewards: contains rewards for those battles
  - users: contains level information for specific users
  
The battles and rewards data set have a new file created each day while
the users data set is a single growing file.
  
## battles

Contains the following columns

  - battleID
  - userID
  - battle_name
  - n_sims
  
## rewards

Contains the following columns

  - battleID
  - reward
  - count
  
## users

Contains the following columns

  - date
  - userID
  - level
#' Rewards received
#' 
#' This data set is just 
#' a concatenation of all the data files containing rewards received. This does
#' not include any rewards that could have been received and therefore the 
#' rewards_complete data set is most likely of more use.
#' 
#' @format A data.frame with 3 columns:
#' \describe{
#'   \item{battleID}{character, unique battle identifier}
#'   \item{reward}{character, name of reward}
#'   \item{count}{integer, amount of that reward received}
#' }
#' @seealso rewards_complete, battles, battle_rewards
"rewards"
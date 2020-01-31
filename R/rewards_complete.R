#' Complete set of rewards for battles fought
#' 
#' Data set that combines the data in battles, battle_rewards,
#' and rewards. This data set includes zeros for rewards not received
#' and therefore is a much more relevant data set than rewards.
#' 
#' @format A data frame with 3 columns:
#' \describe{
#'   \item{date}{Date, date battle was fought}
#'   \item{battleID}{character, unique battle identifier using YYYYMMDD-### format}
#'   \item{userID}{character, unique account identifier}
#'   \item{battle}{character, battle name}
#'   \item{simulated}{logical, indicates if the battle was simulated (TRUE) or fought (FALSE)}
#'   \item{n}{integer, number of times battle was fought/simulated}
#'   \item{reward}{character, type of reward received}
#'   \item{count}{integer, number of that reward received}
#' }
#' @seealso rewards, battles, battle_rewards
"rewards_complete"
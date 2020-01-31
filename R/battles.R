#' Battles fought
#' 
#' This \code{data.frame} is just 
#' a concatenation of all the data files containing battles fought. Since the 
#' battles can be simulated, up to 5 for Hard battles and 20 for other battles,
#' the `attempts` column indicates the number of attempts for the battle.
#' 
#' @format A data frame with 3 columns:
#' \describe{
#'   \item{date}{Date, when battle was fought}
#'   \item{battleID}{character, unique battle identifier}
#'   \item{userID}{character, unique account identifier}
#'   \item{battle}{character, name of the battle}
#'   \item{attempts}{integer, number of attempts for the battle}
#'   \item{simulated}{logical, whether the battle was simulated (TRUE) or fought (FALSE)}
#' }
#' @seealso rewards_complete, rewards, battle_rewards
"battles"
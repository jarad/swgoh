#' Battles
#' 
#' Battles fought. These battles could be simulated or fought manually. When 
#' simulated you can choose the number of battles to simulate.
#' 
#' @format A data frame with 3 columns:
#' \describe{
#'   \item{date}{date battle(s) were fought}
#'   \item{battleID}{unique battle identifier}
#'   \item{userID}{unique user identifier}
#'   \item{battle_name}{official name for the battle}
#'   \item{n_sims}{number of simulations, if 0 then the battle was fought manually}
#' }
"battles"
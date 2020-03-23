#' Rewards for battles fought
#' 
#' Data set that combines the data in \code{battles}, \code{battle_rewards},
#' and \code{rewards_raw}. This data set includes zeros for rewards not received
#' and therefore is more relevant than \code{rewards_raw}.
#' 
#' @format A data frame with 3 columns:
#' \describe{
#'   \item{date}{Date, date battle was fought}
#'   \item{battleID}{character, unique battle identifier using YYYYMMDD-### format}
#'   \item{userID}{character, unique account identifier}
#'   \item{battle}{character, battle name}
#'   \item{attempts}{integer, number of times battle was fought/simulated}
#'   \item{simulated}{logical, indicates if the battle was simulated (TRUE) or fought (FALSE)}
#'   \item{reward}{character, type of reward received}
#'   \item{count}{integer, number of that reward received}
#' }
#' @seealso \link{\code{rewards_raw}}, \link{\code{battles}}, \link{\code{battle_rewards}}
"rewards"


#' Raw rewards data
#' 
#' This data set is a concatenation of all the raw data files containing rewards 
#' received. This does not include any rewards that could have been received and 
#' therefore the \code{rewards} data set is most likely of more use.
#' 
#' @format A data.frame with 3 columns:
#' \describe{
#'   \item{battleID}{character, unique battle identifier}
#'   \item{reward}{character, name of reward}
#'   \item{count}{integer, amount of that reward received}
#' }
#' @seealso \link{\code{rewards}}, \link{\code{battles}}, \link{\code{battle_rewards}}
"rewards_raw"
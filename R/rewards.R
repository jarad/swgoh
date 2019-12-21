#' Rewards
#' 
#' Rewards received from competing in battles
#' 
#' @format A data frame with 3 columns:
#' \describe{
#'   \item{battleID}{character, unique battle identifier}
#'   \item{date}{Date, date of battle}
#'   \item{userID}{integer, user identifier}
#'   \item{battle}{character, name of the battle}
#'   \item{simulated}{logical, whether or not the battle was simulated}
#'   \item{n}{integer, the number to battle attempts}
#'   \item{...}{remaining columns are reward names and the number of that reward received for that battle}
#' }
"rewards"
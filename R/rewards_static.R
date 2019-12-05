#' Static rewards
#' 
#' Subset of rewards that appear to be static based on two days worth of 
#' data. Data for these rewards was not collected after day 2.
#' 
#' @format A data frame with 3 columns:
#' \describe{
#'   \item{battleID}{unique battle identifier}
#'   \item{reward}{name of reward}
#'   \item{count}{number received}
#' }
"reward_static"
#' Run package shiny apps
#' 
#' @param app The name of a shiny app in this package. 
#' @details Launches a shiny app
#' @export
#' 
runShinyApp <- function(app) {
  # code modified from https://deanattali.com/2015/04/21/r-package-shiny-app/
  
  stopifnot(require(shiny))
  
  # locate all the shiny app examples that exist
  validApps <- list.files(system.file("shiny", package = "swgoh"))
  
  validAppsMsg <-
    paste0(
      "Valid examples are: '",
      paste(validApps, collapse = "', '"),
      "'")
  
  # if an invalid example is given, throw an error
  if (missing(app) || !nzchar(app) ||
      !app %in% validApps) {
    stop(
      'Please run `runShinyApp()` with a valid app as an argument.\n',
      validAppsMsg,
      call. = FALSE)
  }
  
  # find and launch the app
  appDir <- system.file("shiny", app, package = "swgoh")
  shiny::runApp(appDir, display.mode = "normal")
}
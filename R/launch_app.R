#' Launch the Movies Review Application
#'
#' Starts the Movies Review Shiny application, which provides a customizable
#' scatter plot interface for analyzing movie data.
#' 
#' @param options Shiny options.
#' @param run where to launch the application. Choices are: 
#' *  p: RStudio viewer pane  
#' *  b: New browser window   
#' *  w: RStudio window   
#'
#' @return A **Shiny application** object.
#'
#' @section Details:
#' The application uses:
#' - **UI**: Defined in [`movies_ui()`].
#' - **Server Logic**: Defined in [`movies_server()`].
#'
#' @seealso
#' - [`movies_ui()`] for the user interface.
#' - [`movies_server()`] for the server logic.
#'
#' @family **Standalone Application**
#'
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
#'
#' 
#' @export
#' 
#' @import shiny
#' 
launch_app <- function(options = list(), run = "p") {
  display_type(run = run)
  shinyApp( 
    ui = movies_ui(),
    server = movies_server,
    options = options
  )
}
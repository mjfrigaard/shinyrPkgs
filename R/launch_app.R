#' Launch the Movies Review Application
#'
#' Starts the Movies Review Shiny application, which provides a customizable
#' scatter plot interface for analyzing movie data.
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
launch_app <- function() {
  shiny::shinyApp(ui = movies_ui, server = movies_server)
}

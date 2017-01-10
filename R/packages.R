NULL
#'
#' Packages Menu
#'
#' Interactive menu to download a package
#' 
#' @param q query
#' @param rows Number of rows to be returned in the menu, DEFAULT=100 (TODO: Possibily add a warning/message if rows is reached)
#' @param sel Override Package selection
#' 
#' @export
#' @return NOTHING [TBC]
#'
menu_packages <- function(q = NULL, rows = 100, sel = NULL ) {
    r <- search_query(q)
    if (!is.null(r)) {
        if (is.null(sel)) {
            choices <- r$title
            sel <- menu(choices, 
                        title = 'The query returned these datasets, which one do you want to load?')
        }
        pack <- r[sel, ]
        select_resource(pack)
    }
}
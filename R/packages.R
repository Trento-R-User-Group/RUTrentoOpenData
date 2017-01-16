#'
#' Packages Menu
#'
#' Interactive menu to download a package
#' 
#' @param q query
#' @param rows Number of rows to be returned in the menu, DEFAULT=100 (TODO: Possibily add a warning/message if rows is reached)
#' @param pack_sel Override Package selection
#' @param res_sel Override Resource selection
#' 
#' @return The selected Package
#'
menu_packages <- function(q = NULL,
                          rows = 100,
                          pack_sel = NULL,
                          res_sel = NULL) {
    r <- search_query(q, rows = rows)
    if (!is.null(r)) {
        if (is.null(pack_sel)) {
            choices <- r$title
            pack_sel <- menu(choices,
                        title = "The query returned these datasets,
                        which one do you want to load?")
        }
        pack <- r[pack_sel, ]
        return(pack)
    }
}

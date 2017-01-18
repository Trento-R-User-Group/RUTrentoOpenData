#'
#' Packages Menu
#'
#' Interactive menu to download a package
#'
#' @param s query
#' @param rows Number of rows to be returned in the menu, DEFAULT=100 (TODO: Possibily add a warning/message if rows is reached)
#' @param pack_sel Override Package selection
#'
#' @return The selected Package
#'
menu_packages <- function(s,
                          rows = 100,
                          pack_sel = NULL) {
    if (!is.null(s)) {
        if (is.null(pack_sel)) {
            choices <- s$title
            pack_sel <- menu(choices,
                             title = "The query returned these datasets,
                             which one do you want to load?")
            if (nrow(s) == rows) {
                message(
                    "There are probably more datasets than showed,
                    use the rows parameter to increase the limit"
                )
            }
            }
        pack <- s[pack_sel,]
        return(pack)
        }
    }
#'
#' Organization default resource
#'
#' If we know the structure of a organization tipical package, we can attempt to download it automatically
#'
#' @param pack Package df as returned by menu_packages
#' @param res Resource options (RENAME - REFACTOR)
#'
#' @return The automatically selected Resource
#'
pack_default <- function(pack, res) {
    if (pack$organization$title == "ISPAT") {
        res <- list(res_sel = 2,
                    sep = ";")
    }
    
    return(res)
}

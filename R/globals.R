#'
#' Ask data to Trentino Open Data!
#'
#' dati.trentino.it is one of the most complete open data portal in europe,
#' and now you can easily discover and use
#'
#' @param query A text input to search and download data
#' @param pack_sel Package selection. Custom parameter to override, force or set default package
#' @param res_sel Resource selection. Custom parameter to override, force or set default resource
#' @param rows Number of rows to be returned from the query
#' @param ... Additional parameters to further customize behaviour
#'
#' @export
#'
#' @return A dataset if everything goes ok
#' 
#' @examples \dontrun{
#' dat <- ask_tod('nati')
#' dat <- ask_tod('nati', pack_sel = 1)
#' dat <- ask_tod('dipendenti', pack_sel = 24, res_sel = 2)
#' }
#'
ask_tod <- function(query,
             pack_sel = NULL,
             res_sel = NULL,
             rows = 100,
             ...) {
        #IMPORTANT
        ckanr::ckanr_setup("dati.trentino.it")

        s <- search_query(query = query, rows = rows)
        p <- menu_packages(s = s,
                           rows = rows,
                           pack_sel = pack_sel)
        r <- select_resource(pack = p,
                             res_sel = res_sel)
        dat <- download_resource(r, ...)
        return(dat)
    }


#'
#' Search function
#'
#' This function search the portal for the specified query and return a data.frame containing the related packages
#'
#' @param query query to be run against the CKAN portal
#' @param rows Number of rows to be returned from the query, DEFAULT=100 (TODO: Possibily add a warning/message when max is reached)
#'
#' @return A data.frame as returned from ckanr::package_search
#'
search_query <- function (query, rows = 100) {
    if (is.null(query) | query == "") {
        stop("Empty query, please ask something")
        return(NULL)
    }

    res <- ckanr::package_search(q = query,
                                 rows = rows,
                                 as = "table")

    res <- res$results
}

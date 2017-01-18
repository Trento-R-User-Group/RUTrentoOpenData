#'
#' Main function / entry point
#'
#' This is the main function and then only that should be invoked, at least for now
#'
#' @param q A text input to search and download data
#' @param pack_sel Package selection. Custom parameter to override, force or set default package
#' @param res_sel Resource selection. Custom parameter to override, force or set default resource
#' @param rows Number of rows to be returned from the query
#' @param ... Additional parameters to further customize behaviour
#'
#' @export
#'
#' @return A dataset if everything goes ok, otherwise...(TODO)
#'
trentino <- function(q,
             pack_sel = NULL,
             res_sel = NULL,
             rows = 100,
             ...) {
        #IMPORTANT
        ckanr::ckanr_setup("dati.trentino.it")

        s <- search_query(q, rows = rows)
        p <- menu_packages(s = s,
                           rows = rows,
                           pack_sel = pack_sel)
        r <- select_resource(pack = p,
                             res_sel = res_sel)
        download_resource(r, ...)
        # Should return a data.frame
    }


#'
#' Search function
#'
#' This function search the portal for the specified query and return a data.frame containing the related packages
#'
#' @param q query
#' @param rows Number of rows to be returned from the query, DEFAULT=100 (TODO: Possibily add a warning/message when max is reached)
#'
#' @return A data.frame as returned from ckanr::package_search
#'
search_query <- function (q, rows = 100) {
    if (is.null(q) | q == "") {
        stop("Empty query, please ask something")
        return(NULL)
    }

    res <- ckanr::package_search(q = q,
                                 rows = rows,
                                 as = "table")

    res <- res$results
}

# TODO: Add comment
# 
# Author: Trento R User Group


#' 
#' Main function / entry point
#' 
#' This is the main function and then only that should be invoked, at least for now
#' 
#' @param q A text input to search and download data
#' @param rows Number of rows to be returned from the query, DEFAULT=100 (TODO: Possibily add a warning/message when max is reached)
#' @param pack_sel Package selection. Custom parameter to override, force or set default package
#' @param res_sel Resource selection. Custom parameter to override, force or set default resource
#' 
#' @return A dataset if everything goes ok, otherwise...(TODO)
#' 
trentino <- function(q, rows = 100, pack_sel = NULL, res_sel = NULL) {
    #IMPORTANT
    ckanr::ckanr_setup('dati.trentino.it')
    
    if (is.null(q) | q == '') {
        message('Empty query, please ask something')
        return(NULL)
    }
    menu_packages(q, rows, pack_sel)
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
search_query <- function (q = NULL, rows = 100) {
    res <- ckanr::package_search(q = q,
                                 as = 'table',
                                 rows = rows)$results
    return(res)
}


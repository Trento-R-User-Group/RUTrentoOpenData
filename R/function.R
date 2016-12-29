# TODO: Add comment
# 
# Author: Trento R User Group
###############################################################################
NULL
#' 
#' Main search function
#' 
#' This is the main search function and will return the result of the query
#' from dati.trentino
#' 
#' @param q query
#' @param ... further arguments
#' 
#' @return 
#' 
#'
#' @examples 
#' 
#' ll <- search_query('nati')
#' 
#' 
#' 
#' 
#' 


search_query <- function (q = NULL,...) {
    
    ckanr::ckanr_setup('dati.trentino.it')
    
    if (is.null(q) | q == '') {
        message('Empty query, please ask something')
        return(NULL)
    } else {
        res <- ckanr::package_search(q = q,
                                     as = 'table',
                                     rows = 100)$results
        return(res)
    }
    
    
}	

#'
#' Interactive menu to download a package
#' 
#' @param q query
#'

packages_menu <- function(q = NULL, sel = NULL ) {
    ckanr::ckanr_setup('dati.trentino.it')
    r <- search_query(q)
    if (!is.null(r) & is.null(sel)) {
        choices <- r$title
        c <- menu(choices, 
                  title = 'The query returned these datasets, 
                  which one do you want to load?')
        resources <- r[c, 'resources'][[1]]
        return(resources)
    }
}

#'
#' Interactive menu to download a resource
#' 
#' @param resources A data.frame as returned by \code{packages_menu}
#'


resources_menu <- function(resources = NULL ) {
    choices <- recources$name
    if (!is.null(resources))
    c <- menu(choices,
              title = 'These are the available resources,
                  which one do you want?')
    resources[c, 'url']
    result <- read.csv2(resources[c, 'url'])
    return(result)
}



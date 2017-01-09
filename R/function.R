# TODO: Add comment
# 
# Author: Trento R User Group
###############################################################################

#' 
#' Main function / entry point
#' 
#' This is the main function and should be invoked alone
#' 
#' @param q A text input to search and download data
#' 

trentino <- function(q, rows = 100, pack_sel = NULL, res_sel = NULL) {
    ckanr::ckanr_setup('dati.trentino.it')
    if (is.null(q) | q == '') {
        message('Empty query, please ask something')
        return(NULL)
    }
    packages_menu(q, rows, pack_sel)
}


#' 
#' Search function
#' 
#' This function search the portal for the specified query and return a data.frame containing the related packages
#' 
#' @param q query
#' 



search_query <- function (q = NULL, rows = 100) {
        res <- ckanr::package_search(q = q,
                                     as = 'table',
                                     rows = rows)$results
        return(res)
}	

#'
#' Interactive menu to download a package
#' 
#' @param q query
#'

packages_menu <- function(q = NULL, rows = 100, sel = NULL ) {
    r <- search_query(q)
    if (!is.null(r)) {
        if (is.null(sel)) {
            choices <- r$title
            sel <- menu(choices, 
                        title = 'The query returned these datasets, which one do you want to load?')
        }
        pack <- r[sel, ]
        handle_resource(pack)
    }
}

handle_resource <- function(package, res_sel = NULL) {
    if (is.null(res_sel)) {
        # TODO:
        # check_default()
        # Se package appartiene a organizzazione conosciuta, possiamo impostare un res_sel di default (sovrascrivibile)
        res_sel = resources_menu(package$resources[[1]])
    }
    resource <- package$resources[[1]][res_sel, ]
    download_resource(resource)
}


download_resource <- function(resource) {
    if (resource$format == 'JSON') {
        res <- jsonlite::fromJSON(resource$url)[[1]]
    } else if (resource$format == 'CSV') {
        res <- read.csv2(resource$url)
    } else {
        message('I don\'t know how to download this format, pls contribute!')
        res <- NULL
    }
    return(res)
}
#'
#' Interactive menu to download a resource given a package
#' 
#' @param resources A data.frame as returned by \code{packages_menu}
#'


resources_menu <- function(resources = NULL ) {
    choices <- resources$name
    res_sel <- menu(choices,
              title = 'These are the available resources, which one do you want?')
    return(res_sel)
}



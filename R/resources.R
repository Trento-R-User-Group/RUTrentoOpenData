#'
#' Handle the resource selection
#' 
#' Search if the package have a default resource selection, if not ask and THEN download it
#'
#' @param package A Package data.frame 
#' @param res_sel Override Resource selection
#' 
#' @return NOTHING [TBC]
#' 
#' 
select_resource <- function(package, res_sel = NULL) {
    if (is.null(res_sel)) {
        # TODO:
        # default_resource()
        # Se package appartiene a organizzazione conosciuta, possiamo impostare un res_sel di default (sovrascrivibile)
        res_sel = resources_menu(package$resources[[1]])
    }
    resource <- package$resources[[1]][res_sel, ]
    download_resource(resource)
    # Should return a data.frame
}


#'
#' Handle the Resource download# Should return a data.frame
#' 
#' Check the type of Resource and donwload&parse accordingly
#' 
#' @param resource A Resource data.frame
#' 
#' @return Should be a data.frame with actual data in it
#' 
download_resource <- function(resource) {
    format <- resource$format
    url <- resource$url
    if (format == 'JSON') {
        res <- jsonlite::fromJSON(url)[[1]]
    } else if (format == 'CSV') {
        res <- read.csv2(url)
    } else {
        message('I don\'t know how to download this format, pls contribute!')
        res <- NULL
    }
    return(res)
}


#' 
#' Resources Menu
#'
#' Interactive menu to download a Resource given a Package
#' 
#' @param resources A Package data.frame
#'
menu_resources <- function(resources = NULL) {
    choices <- resources$name
    res_sel <- menu(choices,
                    title = 'These are the available resources, which one do you want?')
    return(res_sel)
}
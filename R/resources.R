NULL
#'
#' Handle the resource selection
#' 
#' Search if the package have a default resource selection, if not ask and THEN download it
#'
#' @param package A Package data.frame 
#' @param res_sel Override Resource selection
#' 
#' @export
#' @return NOTHING [TBC]
#' 
#' 
select_resource <- function(package, res_sel = 'manual') {
    if (res_sel == 'manual') {
        res_sel = menu_resources(package$resources[[1]])
    } else {
        # TODO:
        # default_resource()
        # Se package appartiene a organizzazione conosciuta, possiamo impostare un res_sel di default (sovrascrivibile)
        print('default_resource() [TBI]')
    }

    resource <- package$resources[[1]][res_sel, ]
    download_resource(resource)
    # Should return a data.frame
}

NULL
#'
#' Handle the Resource download# Should return a data.frame
#' 
#' Check the type of Resource and donwload&parse accordingly
#' 
#' @param resource A Resource data.frame
#' 
#' @export 
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

NULL
#' 
#' Resources Menu
#'
#' Interactive menu to download a Resource given a Package
#' 
#' @export
#' @param resources A Package data.frame
#'
menu_resources <- function(resources = NULL) {
    choices <- resources$name
    res_sel <- menu(choices,
                    title = 'These are the available resources, which one do you want?')
    return(res_sel)
}
#'
#' Handle the resource selection
#'
#' Search if the package have a default resource selection, if not ask
#'
#' @param pack A Package data.frame
#' @param res_sel Override Resource selection
#'
#' @return The selected Resource
#'
select_resource <- function(pack, res_sel) {
    # Default values
    res <- list(res_sel = res_sel,
                sep = ";")
    resources <- pack$resources[[1]]
    # If pack enters one of the test inside
    # override default
    res <- default_package(pack = pack, res = res)
    # If only one resource, pick that
    if (nrow(resources) == 1) {
        res$res_sel <- 1
    }
    # Else ask selection
    if (is.null(res$res_sel)) {
        res$res_sel <- menu_resources(pack = pack)
    }
    res$resource <- resources[res$res_sel, ]
    return(res)
}


#'
#' Handle the Resource download# Should return a data.frame
#'
#' Check the type of Resource and donwload&parse accordingly
#'
#' @importFrom utils menu read.csv2 URLencode
#' @importFrom methods hasArg
#'
#' @param res A Resource data.frame
#' @param sep a custom separator, if present
#'
#' @return The actual data
#'
download_resource <- function(res, ...) {
    format <- res$resource$format
    url <- URLencode(res$resource$url)
    sep <- res$sep
    if (hasArg(sep)) {
        sep <- list(...)$path
    }
    if (!is.null(res$downloader)) {
        res$dowloader(res)
    }
    if (format == "JSON") {
        dat <- jsonlite::fromJSON(url)
    } else if (format == "CSV") {
        dat <- read.csv2(url, sep = sep)
    }else if (format == "shp" || format == "zip (shp)"){
        if (hasArg(path)) {
            downloads_folder <- list(...)$path
            dat <- get_spatial_data_frame(url, downloads_folder)
            
        }else{
            dat <- get_spatial_data_frame(url)
        }
    } else {
        message(format)
        message("I don\'t know how to download this format, pls contribute!")
        dat <- NULL
    }
    return(dat)
}


#'
#' Resources Menu
#'
#' Interactive menu to download a Resource given a Package
#'
#' @param pack A Package data.frame
#'
#' @return The selected Resource as chosen by the user
#'
menu_resources <- function(pack = NULL) {
    resource <- pack$resources[[1]]
    choices <- resource$name
    res_sel <- menu(choices,
                    title = "These are the available resources,
                    which one do you want?")
    return(res_sel)
}

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

    # If pack enters one of the test inside
    # override default
    res <- default_package(pack = pack, res = res)

    # Else ask selection
    if (is.null(res$res_sel)) {
        res$res_sel <- menu_resources(pack = pack)
    }

    res$resource <- pack$resources[[1]][res$res_sel, ]
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
download_resource <- function(res, sep) {
    format <- res$resource$format
    url <- URLencode(res$resource$url)
    sep <- res$sep

    if (hasArg(sep)) {
        sep <- sep
    }

    if (format == "JSON") {
        dat <- jsonlite::fromJSON(url)
    } else if (format == "CSV") {
        dat <- read.csv2(url, sep = sep)
    }else if (format == "shp"){
        dat <- getSpatialDataFrame(url)
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


#' 
#' Extract shape file from remote zip.
#' 
#' @import rgdal
#' 
#' @param url The url of the zip file
#' 
#' @return A SpatialDataFrame of selected resource.
#' 
getSpatialDataFrame <- function(url) {
    #insert other statement? -----
    shape <- readOGR(dsn = getZip(url))
    return(shape)
}


#' 
#' Download zip from remote and unzip
#' 
#' It create a temporary folder, download the selected resource
#' as zip file into the folder, and then extract all file into this path.
#' 
#' 
#' @param url The url of the zip file
#' 
#' @return The path where files have been extracted
#' 
getZip <- function(url) {
    temp_folder <- tempdir()
    temp_file <- tempfile(tmpdir = temp_folder, fileext = ".zip")
    download.file(url,temp_file)
    unzip(temp_file, exdir = temp_folder, overwrite = TRUE)
    unlink(temp)
    return(temp_folder)
}

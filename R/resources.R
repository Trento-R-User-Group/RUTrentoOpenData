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
select_resource <- function(pack, res_sel = "manual") {
    if (pack$organization$title %in% c("ISPAT")) {

        res_sel <- organization_default(pack)

    } else if (!is.numeric(res_sel)) {

        res_sel <- menu_resources(pack)

    }

    # Force integer as I can't filter based on a list class object
    index <- as.integer(res_sel$res_sel)

    resource <- pack$resources[[1]][index, ]
    res <- list(resource = resource,
                sep = res_sel$sep)
    return(res)
}


#'
#' Handle the Resource download# Should return a data.frame
#' 
#' Check the type of Resource and donwload&parse accordingly
#' 
#' @importFrom utils menu read.csv2
#' 
#' @param resource A Resource data.frame
#' 
#' @return The actual data
#' 
download_resource <- function(resource) {
    format <- resource$resource$format
    url <- resource$resource$url
    sep <- resource$sep
    if (format == "JSON") {
        res <- jsonlite::fromJSON(url)[[1]]
    } else if (format == "CSV") {
        res <- read.csv2(url, sep = sep)
    }else if (format == "shp"){
        res <- getSpatialDataFrame(url)
    } else {
        message("I don\'t know how to download this format, pls contribute!")
        res <- NULL
    }
    return(res)
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
    res <- list(res_sel = res_sel,
                sep = ",")
    return(res)
}


#' 
#' Organization default resource
#' 
#' If we know the structure of a organization tipical package, we can attempt to download it automatically
#' 
#' @param pack Package df as returned by menu_packages
#' 
#' @return The automatically selected Resource
#' 
organization_default <- function(pack) {
    if (pack$organization$title == "ISPAT") {
        res <- list(res_sel = 2,
                    sep = ";"
        )
    }
    return(res)
}


#' 
#' Extract shape file from remote zip.
#' 
#' 
#' 
#' @param url The url of the zip file
#' 
#' @return The automatically selected Resource
#' 
getSpatialDataFrame <- function(url) {
    file_ls <- unzip(temp, list = TRUE)
    #temp <- tempfile()
    temp <- "/Users/danieleandreis/Documents/tempShp.zip"
    download.file(url,temp)
    file_ls <- unzip(temp, list = TRUE, exdir = "./tempShape")
    #file_name <- file_ls$Name[which(grepl("(.shp)$",file_ls$Name))[1]]
    shape <- rgdal::readOGR(dsn = temp)
    #unlink(temp)
    return(shape)
}
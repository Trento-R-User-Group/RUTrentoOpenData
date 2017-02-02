#' 
#' Extract shape file from remote zip.
#' 
#' @importFrom rgdal readOGR
#' 
#' @param url The url of the zip file
#' 
#' @return A SpatialDataFrame of selected resource.
#' 
get_spatial_data_frame <- function(url, downloads_folder = NULL) {
    # This can be an utility function (search if folder contains a file)-------
    folder <- download_zip_file(url, downloads_folder)
    files_path <- list.files(path = folder,
                             recursive = TRUE,
                             pattern = "(.shp)$",
                             full.names = TRUE)
    if (length(files_path) > 0){
        shape <- readOGR(dsn = files_path[1])
    } else {
        shape <- NULL
    }
    unlink(folder, recursive = FALSE)
    return(shape)
}

#' 
#' Download zip from remote and unzip
#' 
#' It create a temporary folder, download the selected resource
#' as zip file into the folder, and then extract all file into this path.
#' 
#' @importFrom utils download.file unzip
#' 
#' @param url The url of the zip file
#' 
#' @return The path where files have been extracted
#' 
download_zip_file <- function(url, downloads_folder) {
    if(is.null(downloads_folder)){
        temp_folder <- tempdir()
        temp_file <- tempfile(tmpdir = temp_folder, fileext = ".zip")
        
    }else{
        subFolder <- "openData"
        temp_folder <- file.path(downloads_folder, subFolder)
        print(temp_folder)
        ifelse(!dir.exists(temp_folder), dir.create(temp_folder), FALSE)
        temp_file <- paste(temp_folder, "openData.zip", sep="/")
        if(!file.create(temp_file)){
            #exception to throw
        }
        
    }
    download.file(url, temp_file)
    print(temp_file)
    unzip(temp_file, exdir = temp_folder, overwrite = TRUE)
    unlink(temp_file)
    return(temp_folder)
}
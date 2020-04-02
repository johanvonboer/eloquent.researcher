.onLoad <- function(libname, pkgname) {

  split_path <- function(path) {
    if (dirname(path) %in% c(".", path)) return(basename(path))
    return(c(basename(path), split_path(dirname(path))))
  }
  # Första elementet är "Program", och därefter är elementen bibliotek från / i omvänd ordning
  project.name <- split_path(getwd())[2]
  dataPath <- file.path(getwd(),
                        "..",
                        "Data")
  if(dir.exists(dataPath)){
    emuDBpath <- file.path(dataPath,
                           paste0(project.name,emuR:::emuDB.suffix))

    assign("EMUDB",emuR::load_emuDB(emuDBpath,verbose = FALSE), envir = .GlobalEnv)
  }
}

.onUnLoad <- function(libname, pkgname) {
  if(exists("EMUDB")){
    RSQLite::dbDisconnect(EMUDB$connection)
    remove(list=c("EMUDB"),envir = .GlobalEnv)
  }

}

.onDetach <- .onUnLoad

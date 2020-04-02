.onLoad <- function(libname, pkgname) {
  assign("DATABASE", file.path(getwd(),
                               "..",
                               "Data",
                               paste0("teet",emuR:::emuDB.suffix))
         , envir = .GlobalEnv)

}

.onUnLoad <- function(libname, pkgname) {
  remove(list=c("DATABASE"),envir = .GlobalEnv)
}

.onDetach <- .onUnLoad

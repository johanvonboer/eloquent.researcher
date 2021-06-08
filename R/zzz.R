.onLoad <- function(libname, pkgname) {
  #Handle the dual conventions used at humlab speech
  pdir <- dir(pattern="*-project")

  if(! length(pdir) ==  1 ){
    baseDir <- "project"
  }else{
    baseDir <- pdir
  }
  if(!dir.exists(baseDir)){
    pathArr <- strsplit(getwd(),.Platform$file.sep)[[1]]
    baseInd <- match(baseDir,pathArr)
    if(! is.na(baseInd)){
        #set up HS reference
        ind <- seq(1,baseInd,1)
        assign("HS",file.path(pathArr[ind]))

    }else{
      warning("Unable to set up pointers to HS, DB, DATA and RESULTS.")
    }
  }else{
    #Make HS available as a reference to the "VISP" directory globaly
    assign("HS",file.path(getwd(),baseDir))
    if(dir.exists(file.path(HS,"Data"))){
      assign("DATA",file.path(HS,"Data"),envir = .GlobalEnv)
      if(dir.exists(file.path(DATA,"VISP_emuDB"))){
        assign("DB",emuR::load_emuDB(file.path(DATA,"VISP_emuDB")),envir = .GlobalEnv)
      }else{
        warnings("Could not create a DB reference to the speech database")
      }
    }else{
      warnings("Could not create a DATA reference to the project Data directory")
    }
    if(dir.exists(file.path(HS,"Results"))){
      assign("RES",file.path(HS,"Results"),envir = .GlobalEnv)
    }else{
      warnings("Could not create a RESULTS reference to the project Results directory")
    }
    if(dir.exists(file.path(HS,"Applications"))){
      assign("APPS",file.path(HS,"Applications"),envir = .GlobalEnv)
      #Move to the project directory
      setwd(file.path(HS,"Applications"))
    }else{
      warnings("Could not create a APPS reference to the project Programs directory")
    }
  }
}

.onUnLoad <- function(libname, pkgname) {
  if(exists("DB")){
    RSQLite::dbDisconnect(EMUDB$connection)
    remove(list=c("DB","RES","DATA","HS","APPS"),envir = .GlobalEnv)
  }

}

.onDetach <- .onUnLoad

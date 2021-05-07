.onLoad <- function(libname, pkgname) {
  #Handle the dual conventions used at humlab speech
  pdir <- dir(pattern="*-project")

  if(! length(pdir) ==  1 ){
    baseDir <- "humlabspeech"
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
    #Make HS available as a reference to the "humlabspeech" directory globaly
    assign("HS",file.path(getwd(),baseDir))
    if(dir.exists(file.path(HS,"Data"))){
      assign("DATA",file.path(HS,"Data"),envir = .GlobalEnv)
      if(dir.exists(file.path(DATA,"humlabspeech_emuDB"))){
        assign("DB",emuR::load_emuDB(file.path(DATA,"humlabspeech_emuDB")),envir = .GlobalEnv)
      }else{
        warnings("Could not create a DB reference to the speech database")
      }
    }else{
      warnings("Could not create a DATA reference to the project Data directory")
    }
    if(dir.exists(file.path(HS,"Results"))){
      assign("RESULTS",file.path(HS,"Results"),envir = .GlobalEnv)
    }else{
      warnings("Could not create a RESULTS reference to the project Results directory")
    }
    if(dir.exists(file.path(HS,"Applications"))){
      assign("PROGRAMS",file.path(HS,"Programs"),envir = .GlobalEnv)
    }else{
      warnings("Could not create a PROGRAMS reference to the project Programs directory")
    }
  }
}

.onUnLoad <- function(libname, pkgname) {
  if(exists("DB")){
    RSQLite::dbDisconnect(EMUDB$connection)
    remove(list=c("DB","RESULTS","DATA","HS"),envir = .GlobalEnv)
  }

}

.onDetach <- .onUnLoad

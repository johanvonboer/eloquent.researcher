# Eloquent.researcher

Detta R-paket är skapat för internt bruk inom Humlab Speech vid Umeå Universitet.
This package is intended for internal use within the *Humlab speech* infrastructure at Umeå University.

The primary purpose of the package is to set up an environment which bootstraps research projects for an efficient, reliable, and repeatable workflow. To achieve this, this package sets up some globally available entities that the user may rely on in their analyses. That way, efficient code reuse and switching between projects are facilitated. Within the *Humlab speech* infrastructure, user will be provided with a directory structure like this:


> Data

This is where the user should store all their raw data. Within this directory, the user will have a speech database "humlabspeech_emuDB" directory containing all their speech data. The user will not have to familiarize themselves with this directory though, as this package will make sure that the user always have `DATA` set up to point to the Data directory itself when loaded. Also, a `DB` that points to the project speech database will also be created at load time.

> Documents

This directory is where the documentation on the ethical approval for the project should be stored. The user may further keep the data management plan and other documents that are important to store near the data here.

> Applications

This is where project scripts, markdown files and so on are stored. 

> Results

This is where analysis output such as figure files and tables are stored.


## Demonstration

In order to demonstrate the basic functionality of the package, a small project is set up
```r
dir.create("~/Desktop/my-project/Documents",recursive = TRUE)
dir.create("~/Desktop/my-project/Results")
dir.create("~/Desktop/my-project/Applications")
emuR::create_emuRdemoData("~/Desktop/my-project")
file.rename("~/Desktop/my-project/emuR_demoData","~/Desktop/my-project/Data")
emuR::rename_emuDB("~/Desktop/my-project/Data/ae_emuDB/","humlabspeech")
```
If we then place ourselves at the base of the project directory, then the package "eloquent.researcher" will set up the predefined *global* variables for the user, so that `DB` immediately becomes available and can be used for accessing the database.

```r
> setwd("~/Desktop/")
> library("eloquent.researcher")
> DB
[1] "<emuDBhandle> (dbName = 'src', basePath = '[....]/Desktop/my-project/Data/humlabspeech_emuDB')"
> emuR::list_files(DB)
# A tibble: 28 x 4
   session bundle   file                absolute_file_path                                                                                   
   <chr>   <chr>    <chr>               <chr>                                                                                                
 1 0000    msajc003 msajc003_annot.json /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc003_bndl/msajc003_annot.json
 2 0000    msajc003 msajc003.dft        /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc003_bndl/msajc003.dft       
 3 0000    msajc003 msajc003.fms        /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc003_bndl/msajc003.fms       
 4 0000    msajc003 msajc003.wav        /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc003_bndl/msajc003.wav       
 5 0000    msajc010 msajc010_annot.json /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc010_bndl/msajc010_annot.json
 6 0000    msajc010 msajc010.dft        /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc010_bndl/msajc010.dft       
 7 0000    msajc010 msajc010.fms        /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc010_bndl/msajc010.fms       
 8 0000    msajc010 msajc010.wav        /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc010_bndl/msajc010.wav       
 9 0000    msajc012 msajc012_annot.json /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc012_bndl/msajc012_annot.json
10 0000    msajc012 msajc012.dft        /Users/frkkan96/Desktop/my-project/Data/humlabspeech_emuDB/0000_ses/msajc012_bndl/msajc012.dft       
# … with 18 more rows
```


# TODO

Eventually we want the default environment for R to be placed in the "Applications" directory, as that would make keeping projects neat and tidy for archiving very easy. That way, the "Applications" directory contains all the code that performs analysis and the environment in which the code is run, and the "Data" directory (to which the `DATA` constant always points) contain all the original data files. 

Once we have decided how and where Rstudio and jypyter should be started, a proper .Rprofile file should be set up for each project, like this:

```r
# .Rprofile -- commands to execute at the beginning of each R session       
#                                                                           
# You can use this file to load packages, set options, etc.                 
#                                                                           
# NOTE: changes in this file won't be reflected until after you quit        
# and start a new session                                                   
#                                                                           

setwd("~/Desktop")                                                                     
options(defaultPackages="eloquent.researcher")                             

```

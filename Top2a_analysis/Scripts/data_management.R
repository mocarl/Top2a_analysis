### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Script consolidates and copies data to R_project folders
## Author: Carl Möller mocarl@chalmers.se


### Dependencies
library("plyr")                                     # Load plyr package
library("dplyr")                                    # Load dplyr package
library("readr")                                    # Load readr package
library(openxlsx)
library(stringr)
library(gtools)

####

source("Scripts/Functions/copy_data.R")
source("Scripts/Functions/data_consolidation.R")
source("Scripts/Functions/move_outlines.R")

move_outlines("/Volumes/Carl_Ext_2/Evgeniya_TOP2a/2nd_iteration/with_ATP/2022-04-11-rel pFLIP-FUSE + 10 nM TOP2A")
data_consolidation(path= "/Volumes/Carl_Ext_2/Evgeniya_TOP2a/2nd_iteration/with_ATP", C0 =  "Top2a"  , C1 = "YOYO1" )


copy_data(from = "/Volumes/Carl_Ext_2/Evgeniya_TOP2a/2nd_iteration/with_ATP", ext = ".xlsx")

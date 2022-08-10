### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Colocalisation analysis by comparing geometric centre of particles detected in imagej
## 
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")

## Import the conditions you want to analyse by defining search words for the files names
## All subfolders in Data will be checked for matching files
import_xlsx("Data/3rd",c("noATP","results", "sc"))

## Define the two channels you want to analyse. Channel1 is assumed to be channel of interest.
## Coloc is defined as particles having any overlapping point on a circle defined by the particles mass centre and a radius derived from particle area.
## The particles is assumed to be perfect circles in this approach as this is the most likely footprint of a true protein condensate.
## See outline images with particle mask for true geometry of detected particles.

mass_coloc("2022-05-04-rel_pFLIP-FUSE_+_10_nM_TOP2A_no_ATP_Top2a_results","2022-05-04-rel_pFLIP-FUSE_+_10_nM_TOP2A_no_ATP_YOYO1_results","pFLIP_FUSE_relaxed_10nM_Top2a_noATP_1st")

coloc_particles("2022-06-23_sc-pFLIP-FUSE_10nMTOP2A_noATP_Top2a_results","2022-06-23_sc-pFLIP-FUSE_10nMTOP2A_noATP_YOYO1_results","Data/3rd/2022-06-23_sc-pFLIP-FUSE_10nMTOP2A_noATP")

import_csv("Data/2022-05-04-sc pFLIP-FUSE + 10 nM TOP2A no ATP")

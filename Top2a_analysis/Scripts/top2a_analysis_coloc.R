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
import_xlsx("Data/MYC/MYC",c("7114","results"))

## Define the two channels you want to analyse. Channel1 is assumed to be channel of interest.
## Coloc is defined as particles having any overlapping point on a circle defined by the particles mass centre and a radius derived from particle area.
## The particles is assumed to be perfect circles in this approach as this is the most likely footprint of a true protein condensate.
## See outline images with particle mask for true geometry of detected particles.

mass_coloc()

coloc_particles("Experiment-7112.czi_split_Top2a_results","Experiment-7112.czi_split_YOYO1_results","Data/MYC/MYC/2022-07-06_scpFLIP-FUSE_75nM-MYC", c("YOYO1","Top2a"))
coloc_particles("Experiment-7112.czi_split_Top2a_results","Experiment-7112.czi_split_MYC_results","Data/MYC/MYC/2022-07-06_scpFLIP-FUSE_75nM-MYC", c("MYC","Top2a"))
coloc_particles("Experiment-7112.czi_split_MYC_results","Experiment-7112.czi_split_YOYO1_results","Data/MYC/MYC/2022-07-06_scpFLIP-FUSE_75nM-MYC", c("YOYO1","MYC"))

coloc_particles("Experiment-7114.czi_split_Top2a_results","Experiment-7114.czi_split_YOYO1_results","Data/MYC/MYC/2022-07-06_scpFLIP-FUSE_100nM-MYC", c("YOYO1","Top2a"))
coloc_particles("Experiment-7114.czi_split_Top2a_results","Experiment-7114.czi_split_MYC_results","Data/MYC/MYC/2022-07-06_scpFLIP-FUSE_100nM-MYC", c("MYC","Top2a"))
coloc_particles("Experiment-7114.czi_split_MYC_results","Experiment-7114.czi_split_YOYO1_results","Data/MYC/MYC/2022-07-06_scpFLIP-FUSE_100nM-MYC", c("YOYO1","MYC"))

import_csv("Data/2022-05-04-sc pFLIP-FUSE + 10 nM TOP2A no ATP")

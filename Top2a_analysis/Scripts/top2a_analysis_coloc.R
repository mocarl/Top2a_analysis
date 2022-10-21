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
import_xlsx("Data/V4",c("results"))


## Define the two channels you want to analyse. Channel1 is assumed to be channel of interest.
## Coloc is defined as particles having any overlapping point on a circle defined by the particles mass centre and a radius derived from particle area.
## The particles is assumed to be perfect circles in this approach as this is the most likely footprint of a true protein condensate.
## See outline images with particle mask for true geometry of detected particles.

mass_coloc()
for (variable in vector) {
  
}

coloc_particles("V4_25nM_Top2a_100nM_MYC_rep1_Top2a_results","V4_25nM_Top2a_100nM_MYC_rep1_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_100nM_MYC_BSAslide/Rep_1/split/V4", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
coloc_particles("V4_25nM_Top2a_100nM_MYC_rep1_Top2a_results","V4_25nM_Top2a_100nM_MYC_rep1_MYC_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_100nM_MYC_BSAslide/Rep_1/split/V4", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
coloc_particles("V4_25nM_Top2a_100nM_MYC_rep1_MYC_results","V4_25nM_Top2a_100nM_MYC_rep1_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_100nM_MYC_BSAslide/Rep_1/split/V4", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

coloc_particles("V4_25nM_Top2a_100nM_MYC_rep2_Top2a_results","V4_25nM_Top2a_100nM_MYC_rep2_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_100nM_MYC_BSAslide/Rep_2/split/V4", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
coloc_particles("V4_25nM_Top2a_100nM_MYC_rep2_Top2a_results","V4_25nM_Top2a_100nM_MYC_rep2_MYC_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_100nM_MYC_BSAslide/Rep_2/split/V4", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
coloc_particles("V4_25nM_Top2a_100nM_MYC_rep2_MYC_results","V4_25nM_Top2a_100nM_MYC_rep2_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_100nM_MYC_BSAslide/Rep_2/split/V4", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1


coloc_particles("V4_25nM_Top2a_rep1_Top2a_results","V4_25nM_Top2a_rep1_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_BSAslide/Rep_1/split/V4", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
coloc_particles("V4_25nM_Top2a_rep2_Top2a_results","V4_25nM_Top2a_rep2_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/25nM_Top2_BSAslide/Rep_2/split/V4", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1

coloc_particles("V4_100nM_MYC_rep1_MYC_results","V4_100nM_MYC_rep1_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/100nM_MYC_BSAslide/Rep_1/split/V4", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1
coloc_particles("V4_100nM_MYC_rep2_MYC_results","V4_100nM_MYC_rep2_YOYO1_results","/Volumes/Carl_Ext_2/EXPERIMENTS/20221012/100nM_MYC_BSAslide/Rep_2/split/V4", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

import_csv("Data/2022-05-04-sc pFLIP-FUSE + 10 nM TOP2A no ATP")

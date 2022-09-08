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
import_xlsx("Data/V3/MYC",c("results"))


## Define the two channels you want to analyse. Channel1 is assumed to be channel of interest.
## Coloc is defined as particles having any overlapping point on a circle defined by the particles mass centre and a radius derived from particle area.
## The particles is assumed to be perfect circles in this approach as this is the most likely footprint of a true protein condensate.
## See outline images with particle mask for true geometry of detected particles.

mass_coloc()

#coloc_particles("2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_Top2a_results","2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
#coloc_particles("2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_Top2a_results","2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_MYC_results","Data/V3/MYC/2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
#coloc_particles("2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_MYC_results","2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

#coloc_particles("2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_Top2a_results","2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
#coloc_particles("2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_Top2a_results","2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_MYC_results","Data/V3/MYC/2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
#coloc_particles("2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_MYC_results","2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

coloc_particles("2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_Top2a_results","2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_YOYO1_results","Data/V3/MYC/2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
coloc_particles("2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_Top2a_results","2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_MYC_results","Data/V3/MYC/2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
coloc_particles("2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_MYC_results","2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_YOYO1_results","Data/V3/MYC/2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_Top2a_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_Top2a_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_MYC_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_MYC_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_Top2a_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_Top2a_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_MYC_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_MYC_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_Top2a_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC", label = c("YOYO1", "Top2a")) #Channel 1 = Top2a Channel 2 = YOYO1
coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_Top2a_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_MYC_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC", label = c("MYC", "Top2a")) #Channel 1 = Top2a Channel 2 = MYC
coloc_particles("2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_MYC_results","2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_YOYO1_results","Data/V3/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC", label = c("YOYO1", "MYC")) #Channel 1 = MYC Channel 2 = YOYO1

import_csv("Data/2022-05-04-sc pFLIP-FUSE + 10 nM TOP2A no ATP")

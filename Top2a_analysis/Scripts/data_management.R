### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Script consolidates and copies data to R_project folders
## Author: Carl Möller mocarl@chalmers.se

folder = c("/Volumes/Carl_Ext_2/EXPERIMENTS/20221022/25nM_Top2a_BSAslides/Rep_1/25nM_Top2a_BSAslides_rep1",
           "/Volumes/Carl_Ext_2/EXPERIMENTS/20221022/25nM_Top2a_BSAslides/Rep_2/25nM_Top2a_BSAslides_rep2",
           "/Volumes/Carl_Ext_2/EXPERIMENTS/20221022/100nM_MYC_BSAslides/Rep_1/100nM_MYC_BSAslides_rep1",
           "/Volumes/Carl_Ext_2/EXPERIMENTS/20221022/100nM_MYC_BSAslides/Rep_2/100nM_MYC_BSAslides_rep2")
for (i in folder){

#Move mask imagease from Imagej to a separate folder for easier overview
move_outlines(i)

#Consolidate all csv files from each channel into one xlsx file with a separate sheet for every image
data_consolidation(path= i, C0 =  "YOYO1", C1 = "Top2a", C2 = "MYC")
}

for (i in folder) {
  copy_data(from = i, ext = ".xlsx")
}
# Copies data from a source to the Data folder contained in the R project environment.
# This is necessary for functions to find the data. Make note that the data should not be pushed to repository



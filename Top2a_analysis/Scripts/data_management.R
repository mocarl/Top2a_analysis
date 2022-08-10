### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Script consolidates and copies data to R_project folders
## Author: Carl Möller mocarl@chalmers.se
folder = "/Volumes/Carl_Ext_2/Evgeniya_TOP2a/3rd_iteration/2022-06-22_rel-pFLIP_10nmTOP2a_noATP"
#Move mask imagease from Imagej to a separate folder for easier overview
move_outlines(folder)

#Consolidate all csv files from each channel into one xlsx file with a separate sheet for every image
data_consolidation(path= folder, C0 =  "Top2a", C1 = "YOYO1")

# Copies data from a source to the Data folder contained in the R project environment.
# This is necessary for functions to find the data. Make note that the data should not be pushed to repository
copy_data(from = folder, ext = ".xlsx")

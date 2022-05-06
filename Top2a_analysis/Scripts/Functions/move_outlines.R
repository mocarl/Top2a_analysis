### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Copies all TIFF files to a separate folder for better overview
## Author: Carl Möller mocarl@chalmers.se

move_outlines <- function(path){
  dir.create(paste0(path,"/","Mask_Outlines"))
  tiff <- list.files(path = path,  # Identify all CSV files
                       pattern = ".tiff", full.names = TRUE)
  for (i in tiff) {
    file.copy(i,paste0(path,"/","Mask_Outlines"))
    file.remove(i)
  }
}
  
### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Copies all TIFF files to a separate folder for better overview
## Author: Carl Möller mocarl@chalmers.se

move_outlines <- function(path){
  str = c("outlines.tiff","overlay_montage.tif")
  if(!dir.exists(paste0(path,"/","Mask_Outlines"))){
    dir.create(paste0(path,"/","Mask_Outlines"))
  } else {
  tiff <- list.files(path = path,  # Identify all CSV files
                       pattern = paste(str,collapse="|"), full.names = TRUE)
  for (n in tiff) {
    file.rename(n,paste0(path,"/","Mask_Outlines/",basename(n)))
    #file.remove(i)
  }
  
  }
  print("Images are moved")
}
  
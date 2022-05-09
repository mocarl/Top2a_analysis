### Import from all folders recursively with extension .csv
## path = path to top directory of data


### Re-import files as data.frames ###
## Looks for csv files from path and down
import_csv <- function(path){
  
  file.list <- list.files(path,  # Identify all csv files recursively
                          pattern = ".csv", full.names = TRUE, recursive = TRUE)
  ## Reformat strings to generate comprehensible variable names matching xlsx files
  for(k in file.list){
    assign(sub("*.csv","",basename(k)),read.csv(k),envir = parent.frame())
  }
}
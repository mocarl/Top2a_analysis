### Import from all folders recursively with extension .csv
## path = path to top directory of data


### Re-import files as data.frames ###
## Looks for csv files from path and down
import_csv <- function(path, str = NULL){
  str = c(str,".csv")
  file.list <- list.files(path,  # Identify all csv files recursively
                          pattern = paste(str,collapse=""), full.names = TRUE, recursive = TRUE)
  ## Reformat strings to generate comprehensible variable names matching xlsx files
  var_csv = c()
  for(k in file.list){
    assign(sub("*.csv","",basename(k)),read.csv(k),envir = parent.frame())
    var_csv = c(var_csv, sub("*.csv","",basename(k)))
  }
  assign("var_csv", var_csv, envir = parent.frame())
}
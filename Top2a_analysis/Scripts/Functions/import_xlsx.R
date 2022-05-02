### Import from all folders recursively with extension .xlsx
## path = path to top directory of data
## str = additional string to search for
### Re-import files as data.frames ###
import_xlsx <- function(path,str){
  


file.list <- list.files(path,  # Identify all XLSX files
                        pattern = paste0(str,".xlsx"), full.names = TRUE, recursive = TRUE)
## List all xlsx file recursively for all conditions
name <- sub(".xlsx*","",sub("(/*)","",sub("(.*)(/.*)", "\\2", list.files(path = path, pattern = paste0(str,".xlsx"), recursive = TRUE)))) 
## Reformat strings to generate comprehensible variable names matching xlsx files
for(k in 1:length(file.list)){
  df = data.frame()
  a <- loadWorkbook(file.list[k])
  sheetNames <- sheets(a) 
  for(i in 1:length(sheetNames)){
    #assign(sheetNames[i],readWorkbook(a,sheet = i))
    df = rbind(df, readWorkbook(a,sheet = i))
  }                         # Store all files in list
  assign(name[k], df, envir = parent.frame())
}
}
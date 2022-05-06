### Import from all folders recursively with extension .xlsx
## path = path to top directory of data

## str = additional string to search for
### Re-import files as data.frames ###
import_xlsx <- function(path,str){
str = c(str,".xlsx")

file.list <- list.files(path,  # Identify all XLSX files
                        pattern = paste(str,collapse="||"), full.names = TRUE, recursive = TRUE)
file.list = file.list[apply(sapply(X = str, FUN = grepl, file.list), MARGIN =  1, FUN = all)]
## List all xlsx file recursively for all conditions
name <- sub(".xlsx*","",sub("(/*)","",sub("(.*)(/.*)", "\\2", basename(file.list)))) 
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
#### Copy folder structure and specific data from outside project ####
### Specify top directory to be copied and data type
### The set destination is "Data" in the project folder

copy_data <- function(from, ext){
  if(length(list.files(from, pattern = paste0(ext),recursive = TRUE))<1){
  for (i in basename(list.dirs(from))[-1]) {
    if(length(list.files(file.path(from,i), pattern = paste0(ext),recursive = TRUE))>1){
      dir.create(file.path("Data",paste(i))) ## Create list of dirs to make (exclude top directory)
      file.copy(list.files(file.path(from,i), pattern = paste0(ext), full.names = TRUE, recursive = TRUE), file.path("Data",i), recursive = TRUE)
    } else {
      next
    }
  }
  } else {
    dir.create(file.path("Data",basename(from))) ## Create list of dirs to make (exclude top directory)
    file.copy(list.files(from, pattern = paste0(ext), full.names = TRUE, recursive = TRUE), file.path("Data",basename(from)), recursive = TRUE)
  }
}
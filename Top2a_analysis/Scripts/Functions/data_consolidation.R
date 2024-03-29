### Part of statistical analysis of Top2a deposited on funcitonalised glass slides
## Script includes the consolidation of CSV and XLSX files generated from particle detection done in Imagej
## Author: Carl Möller mocarl@chalmers.se

### Combine CSV in to one dataframe ###



####
# The script will concatenate all csv files generated from particle detection in Imagej into one xlsx file for easier data management
# Note that the csv files will be erased after concatenation to avoid duplicate data
### Set experiment folder
# This folder should contain all conditions of the experiment 
# The name of each subfolder will be used to name the concatenated xlsx files
### Name channels
# Look into the metadata of czi files to see which is which. 
# This will depend on your microscope settings

#path = path to top folder of experiment
#C0 = name of channel
#C1 = name of channel
#C2 = name of channel

data_consolidation <- function(path, C0, C1=NULL, C2=NULL){


  
if(length(list.files(path = path,pattern = ".csv", full.names = TRUE))<1){
for (i in list.dirs(path, recursive = FALSE)){
  if(length(list.files(path = paste0(i),pattern = ".csv", full.names = TRUE))>1){
    if(is.null(C1)){
      data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?0.+csv", full.names = TRUE) %>% 
        lapply(read_csv)                              # Store all files in list
      write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_results.xlsx")) ### Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+csv", full.names = TRUE))
      
      data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE) %>% 
        lapply(read_table)                          # Store all files in list
      write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_summary.xlsx")) # Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE))
    } else if(is.null(C2)) {
      
   #### Load and concatenate results csv files. OBS: files are removed after concatenation
      
      data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?1.+csv", full.names = TRUE) %>% 
      lapply(read_csv)                              # Store all files in list
      write.xlsx(data_1,paste0(i,"/",basename(i),"_",C1,"_results.xlsx")) ### Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+csv", full.names = TRUE))
  
      data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?0.+csv", full.names = TRUE) %>% 
      lapply(read_csv)                              # Store all files in list
      write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_results.xlsx")) ### Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+csv", full.names = TRUE))
  
  #### Load and concatenate results csv files. OBS: files are removed after concatenation
      data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE) %>% 
      lapply(read_table)                            # Store all files in list
      write.xlsx(data_1,paste0(i,"/",basename(i), "_",C1,"_summary.xlsx"))   # Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE))
  
      data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE) %>% 
      lapply(read_table)                          # Store all files in list
      write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_summary.xlsx")) # Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE))
  ####
    } else {
      #### Load and concatenate results csv files. OBS: files are removed after concatenation
      data_2 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?2.+csv", full.names = TRUE) %>% 
        lapply(read_csv)                              # Store all files in list
      write.xlsx(data_2,paste0(i,"/",basename(i),"_",C2,"_results.xlsx")) ### Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?2.+csv", full.names = TRUE))
      
      data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?1.+csv", full.names = TRUE) %>% 
        lapply(read_csv)                              # Store all files in list
      write.xlsx(data_1,paste0(i,"/",basename(i),"_",C1,"_results.xlsx")) ### Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+csv", full.names = TRUE))
      
      data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?0.+csv", full.names = TRUE) %>% 
        lapply(read_csv)                              # Store all files in list
      write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_results.xlsx")) ### Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+csv", full.names = TRUE))
      
      #### Load and concatenate results csv files. OBS: files are removed after concatenation
      data_2 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?2.+Summary.xls", full.names = TRUE) %>% 
        lapply(read_table)                            # Store all files in list
      write.xlsx(data_2,paste0(i,"/",basename(i), "_",C2,"_summary.xlsx"))   # Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?2.+Summary.xls", full.names = TRUE))
      
      data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE) %>% 
        lapply(read_table)                            # Store all files in list
      write.xlsx(data_1,paste0(i,"/",basename(i), "_",C1,"_summary.xlsx"))   # Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE))
      
      data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                           pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE) %>% 
        lapply(read_table)                          # Store all files in list
      write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_summary.xlsx")) # Concatenate input to single xlsx
      file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE))
      ####
  }
  } else {
    next
  }
}
} else {
  i = path
  if(is.null(C1)){
    data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?0.+csv", full.names = TRUE) %>% 
      lapply(read_csv)                              # Store all files in list
    write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_results.xlsx")) ### Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+csv", full.names = TRUE))
    
    data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE) %>% 
      lapply(read_table)                          # Store all files in list
    write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_summary.xlsx")) # Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE))
  } else if(is.null(C2)) {
  #### Load and concatenate results csv files. OBS: files are removed after concatenation
    
  data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?1.+csv", full.names = TRUE) %>% 
    lapply(read_csv)                              # Store all files in list
  write.xlsx(data_1,paste0(i,"/",basename(i),"_",C1,"_results.xlsx")) ### Concatenate input to single xlsx
  file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+csv", full.names = TRUE))
  
  data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?0.+csv", full.names = TRUE) %>% 
    lapply(read_csv)                              # Store all files in list
  write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_results.xlsx")) ### Concatenate input to single xlsx
  file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+csv", full.names = TRUE))
  
  #### Load and concatenate results csv files. OBS: files are removed after concatenation
  
  data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE) %>% 
    lapply(read_table)                            # Store all files in list
  write.xlsx(data_1,paste0(i,"/",basename(i), "_",C1,"_summary.xlsx"))   # Concatenate input to single xlsx
  file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE))
  
  data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                       pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE) %>% 
    lapply(read_table)                          # Store all files in list
  write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_summary.xlsx")) # Concatenate input to single xlsx
  file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE))
  ####
  } else {
    #### Load and concatenate results csv files. OBS: files are removed after concatenation
    data_2 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?2.+csv", full.names = TRUE) %>% 
      lapply(read_csv)                              # Store all files in list
    write.xlsx(data_2,paste0(i,"/",basename(i),"_",C2,"_results.xlsx")) ### Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?2.+csv", full.names = TRUE))
    
    data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?1.+csv", full.names = TRUE) %>% 
      lapply(read_csv)                              # Store all files in list
    write.xlsx(data_1,paste0(i,"/",basename(i),"_",C1,"_results.xlsx")) ### Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+csv", full.names = TRUE))
    
    data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?0.+csv", full.names = TRUE) %>% 
      lapply(read_csv)                              # Store all files in list
    write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_results.xlsx")) ### Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+csv", full.names = TRUE))
    
    #### Load and concatenate results csv files. OBS: files are removed after concatenation
    data_2 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?2.+Summary.xls", full.names = TRUE) %>% 
      lapply(read_table)                            # Store all files in list
    write.xlsx(data_2,paste0(i,"/",basename(i), "_",C2,"_summary.xlsx"))   # Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?2.+Summary.xls", full.names = TRUE))
    
    data_1 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE) %>% 
      lapply(read_table)                            # Store all files in list
    write.xlsx(data_1,paste0(i,"/",basename(i), "_",C1,"_summary.xlsx"))   # Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?1.+Summary.xls", full.names = TRUE))
    
    data_0 <- list.files(path = paste0(i),  # Identify all CSV files
                         pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE) %>% 
      lapply(read_table)                          # Store all files in list
    write.xlsx(data_0,paste0(i,"/",basename(i), "_",C0,"_summary.xlsx")) # Concatenate input to single xlsx
    file.remove(list.files(path = paste0(i), pattern = ".+C[=]?0.+Summary.xls", full.names = TRUE))
    ####
}
}
}


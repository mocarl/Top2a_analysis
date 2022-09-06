### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

#Function scales given variable between 0-1 and returns it as "variable"'_norm
# data is a data.frame
# variable is a column name in data which will be scaled
#group is a vector of column which will be used for grouping to make sure that 
# variable is only scaled with values from the same condition/channeö

max_min_norm <- function(data, variable, group){
  

assign("groups", group)
  data <- data %>%
  group_by(groups) %>% 
  mutate(assign(paste0(variable,"_norm"), variable - min(variable)), 
         assign(paste0(variable,"_norm"), get(paste0(variable,"_norm")) / (max(variable)-min(variable))))
  
}
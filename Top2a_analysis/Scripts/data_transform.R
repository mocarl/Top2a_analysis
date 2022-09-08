### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


filter = data.frame()
for (i in 1:dim(temp.data.imgstat)[1]) {
  filter = rbind(filter, data.frame(temp.data[temp.data$Label == temp.data.imgstat$Label[i],"Mean"] > temp.data.imgstat$Mean[i]))
}
  
  
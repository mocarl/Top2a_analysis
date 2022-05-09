### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")

import_csv("/Users/mocarl/Documents/GitHub/Top2a_analysis/Top2a_analysis/Output")
stats = setdiff(ls(), lsf.str())
# Allocate space
temp = data.frame()
## Consolidate data to be plotted

for(k in 1:length(stats)){
  temp = rbind(temp,get(stats[k])[dim(get(stats[k]))[1],])
  temp$Image[k] = stats[k]
}

ggplot(temp, aes(x=Image, y=Relative_coloc)) +
  geom_bar(aes(fill=Image),position = position_dodge(),
           stat = "identity")

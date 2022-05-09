### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Colocalisation analysis by comparing geometric centre of particles detected in imagej
## 
## Author: Carl Möller mocarl@chalmers.se

## Import the conditions you want to analyse by defining search words for the files names
## All subfolders in Data will be checked for matching files
import_xlsx("Data",c("_ATP","results", "sc"))

## Define the two channels you want to analyse. Channel1 is assumed to be channel of interest.
## Coloc is defined as particles having any overlapping point on a circle defined by the particles mass centre and a radius derived from particle area.
## The particles is assumed to be perfect circles in this approach as this is the most likely footprint of a true protein condensate.
## See outline images with particle mask for true geometry of detected particles.

mass_coloc("2022-04-20-sc pFLIP-FUSE + 10 nM TOP2A_Top2a_ATP_results","2022-04-20-sc pFLIP-FUSE + 10 nM TOP2A_YOYO1_ATP_results")




### Filter data
data.temp = data[[1]] %>% 
  filter(`Circ.` > 0.6)

### Plot all particles in both channels

plot(data[[2]][["X"]],data[[2]][["Y"]], pch=20, col = "Green")
points(data[[1]][["X"]],data[[1]][["Y"]], pch = 20, col = "Red") 

## Centre of mass
plot(data[[2]][["XM"]],data[[2]][["YM"]], pch=20, col = "Green")
points(data[[1]][["XM"]],data[[1]][["YM"]], pch = 20, col = "Red")

### Plot particles as a circle based on area and centre of mass
circles.plot(cbind(data[[1]][["XM"]],data[[1]][["YM"]]),sqrt(data[[1]][["Area"]]/pi))



### Plot colocalised particles 
plot(data.temp[["XM"]],data.temp[["YM"]], col = "Green")
points(data[[1]][["XM"]],data[[1]][["YM"]], pch = 20, col = "Red")

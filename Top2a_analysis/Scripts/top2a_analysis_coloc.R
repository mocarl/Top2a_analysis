### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Colocalisation analysis by comparing geometric centre of particles detected in imagej
## 
## Author: Carl Möller mocarl@chalmers.se

## Dependencies
library(stringr)
library(gtools)
library(openxlsx)
library("plyr") 
library("dplyr")                                    
library("readr") 
library(plotrix)
library(smacpod)


## Make temp copies of each data set for simple scripting
var = setdiff(ls(), lsf.str())
name = sprintf("data%d", 1:length(var)) 
## Reformat strings to generate comprehensible variable names matching xlsx files
for(k in 1:length(var)){
  assign(name[k], get(var[k]))
}

## Get labels for all images
data1_labels = unique(data1[["Label"]])
data2_labels = unique(data2[["Label"]])
## Plot both channels for each image based on centre of mass
if(length(data1_labels)==length(data2_labels)){
  for (i in 1:length(data1_labels)) {
    plot(data2[data2$Label == data2_labels[i],]$XM,data2[data2$Label == data2_labels[i],]$YM, pch = 19, col = "Green")
    points(data1[data1$Label == data1_labels[i],]$XM,data1[data1$Label == data1_labels[i],]$YM, pch = 20, col = "Red")
  }
}


coloc.part = c()
for (n in 1:length(data1_labels)) {
  ### Points with intersecting circles r are assumed to be likely colocalised
  temp.mask = matrix(nrow = dim(data2[data2$Label == data2_labels[n],])[1], ncol = dim(data1[data1$Label == data1_labels[n],])[1])
  for (i in 1:dim(data1[data1$Label == data1_labels[n],])[1]) {
    x= data1[data1$Label == data1_labels[n],]$XM[[i]]
    y= data1[data1$Label == data1_labels[n],]$YM[[i]]
    h= data2[data2$Label == data2_labels[n],]$XM
    k= data2[data2$Label == data2_labels[n],]$YM
    d=sqrt((x-h)^2+(y-k)^2)
    r1=sqrt(data1[data1$Label == data1_labels[n],]$Area[[i]]/pi)
    r2=sqrt(data2[data2$Label == data2_labels[n],]$Area/pi)
    temp.mask[,i] = d<(r1+r2)
  }
  coloc.part = c(coloc.part,sum(colSums(temp.mask)))
  data.temp = tibble()
  for (m in 1:dim(data1[data1$Label == data1_labels[n],])[1]) {
    data.temp = rbind(data.temp, data2[data2$Label == data2_labels[n],][temp.mask[,m],])
  }
  
  ### Plot colocalised particles with multiple candidates
  plot(data.temp[["XM"]],data.temp[["YM"]], col = "Green")
  points(data1[data1$Label == data1_labels[n],]$XM,data1[data1$Label == data1_labels[n],]$YM, pch = 20, col = "Red")
  
  }

sum(coloc.part)/dim(data1)[1]*100


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

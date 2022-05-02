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




## Set path to image csv folder
setwd("/Volumes/Carl_Ext_2/EXPERIMENTS/20220409")

### Import csv files with statistics
for (q in list.dirs(getwd(), recursive = FALSE)){
file.list <- list.files(path = paste0(q),  # Identify all XLSX files
                       pattern = "results.xlsx", full.names = TRUE, recursive = FALSE)

## List all xlsx file recursively for all conditions
name = sprintf("data%d", 1:length(file.list)) 
## Reformat strings to generate comprehensible variable names matching xlsx files
for(k in 1:length(file.list)){
  df = data.frame()
  a <- loadWorkbook(file.list[k])
  sheetNames <- sheets(a) 
  for(i in 1:length(sheetNames)){
    #assign(sheetNames[i],readWorkbook(a,sheet = i))
    df = rbind(df, readWorkbook(a,sheet = i))
  }                         # Store all files in list
  assign(name[k], df)
}

## Get labels for all images
data1_labels = unique(data1[["Label"]])
data2_labels = unique(data2[["Label"]])
## Plot both channels for each image based on centre of mass
for (i in 1:length(sheetNames)) {
  plot(data2[data2$Label == data2_labels[i],]$XM,data2[data2$Label == data2_labels[i],]$YM, pch = 20, col = "Green")
  points(data1[data1$Label == data1_labels[i],]$XM,data1[data1$Label == data1_labels[i],]$YM, pch = 20, col = "Red")
}

coloc.part = c()
for (n in 1:length(sheetNames)) {
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
}

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

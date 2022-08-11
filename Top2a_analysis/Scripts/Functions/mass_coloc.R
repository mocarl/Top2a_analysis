### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Colocalisation analysis by comparing mass centre of particles detected in imagej
## 
## Author: Carl Möller mocarl@chalmers.se

## Function takes data from two channels. The channels needs to be from the same experiment
# Channel1 should be the protein channel and is assumed to be the channel of interest
# Channel2 should be the DNA substrate channel and is assumed to contain the most particles
## It will output images of coloc particles and a relative number of coloc particles for channel1

#output_name is a character vector giving the name of output folder, images and data .txt
# ! use underscore (_) instead if spaces

mass_coloc <- function(channel1,channel2,output_name){

## Makes dir in Output 
  dir.create(paste0("Output/",output_name))
## Make temp copies of each data set for simple scripting
var = c(channel1,channel2)
name = sprintf("data%d", 1:length(var)) 
## Reformat strings to generate comprehensible variable names matching xlsx files
for(k in 1:length(var)){
  assign(name[k], get(var[k]))
}

## Get labels for all images
data1_labels = unique(data1[["Label"]])
data2_labels = unique(data2[["Label"]])

if(length(data1_labels)>length(data2_labels)){
  data1_labels = data1_labels[str_detect(data1_labels,str_c(sapply(strsplit(data2_labels, ".czi"), "[", 1), collapse = "|"))]
} else {
  data2_labels = data2_labels[str_detect(data2_labels,str_c(sapply(strsplit(data1_labels, ".czi"), "[", 1), collapse = "|"))]
}

## Plot both channels for each image based on centre of mass
dir.create(paste0("Output/",output_name,"/all_particles"))
for (i in 1:length(data1_labels)) {
  tiff(file=paste0("Output/",output_name,"/all_particles/",output_name,"_",sub(" -.*","",data1_labels[i]),"_all_particles",".tiff"), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
  plot(data2[data2$Label == data2_labels[i],]$XM,data2[data2$Label == data2_labels[i],]$YM, pch = 19, col = "Green",  main=sub(" -.*","",data1_labels[i]),sub="All particles, centre of mass",  xlab= "Pixel", ylab= "Pixel")
  points(data1[data1$Label == data1_labels[i],]$XM,data1[data1$Label == data1_labels[i],]$YM, pch = 20, col = "Red")
  dev.off()
}


dir.create(paste0("Output/",output_name,"/coloc_particles"))
coloc.part = c()
stats = data.frame()
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
  stats = rbind(stats, data.frame(Image = sub(" -.*","",data1_labels[n]), channel1 = dim(data1[data1$Label == data1_labels[n],])[1], channel2 =dim(data2[data2$Label == data2_labels[n],])[1],Colocalised = coloc.part[n], Relative_coloc = coloc.part[n]/dim(data1[data1$Label == data1_labels[n],])[1]*100 ))
  ### Plot colocalised particles with multiple candidates
  tiff(file=paste0("Output/",output_name,"/coloc_particles/",output_name,"_",sub(" -.*","",data1_labels[n]),"_coloc_particles",".tiff"), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
  plot(data.temp[["XM"]],data.temp[["YM"]], col = "Green", main=sub(" -.*","",data1_labels[n]), sub = "Colocalised particles, centre of mass",  xlab= "Pixel", ylab= "Pixel")
  points(data1[data1$Label == data1_labels[n],]$XM,data1[data1$Label == data1_labels[n],]$YM, pch = 20, col = "Red")
  dev.off()
  
}
stats = rbind(stats, data.frame(Image = "Total", channel1 = sum(stats$channel1), channel2 = sum(stats$channel2), Colocalised = sum(coloc.part),Relative_coloc = sum(coloc.part)/sum(stats$channel1)*100 ))
write_delim(stats,file=paste0(output_name,"/",output_name,"_","_coloc_statistics",".csv"), delim = ",")
return(sprintf("Relative colocalisation: %0.f%%", sum(coloc.part)/dim(data1)[1]*100))
return(output_name)
}




### Plot particles as a circle based on area and centre of mass
#circles.plot(cbind(data[[1]][["XM"]],data[[1]][["YM"]]),sqrt(data[[1]][["Area"]]/pi))


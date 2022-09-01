### Function takes XY coordinates from channel1 and look for coordinates in channel2 
## within r1+r2 and calls colocalisation from this

## Channel1 and 2 can be vectors of variable names
# label is a vector of strings with equal length to the number of channels
# Each string will be added to the repsective output for user ID
coloc_particles <- function(channel1,channel2,output_path, label = NULL)

  for (p in channel1){
    for(j in channel2){
      var = c(p,j)
      ## Create temp variables for easier scripting
      name = sprintf("data%d", 1:length(var)) 
      for(k in 1:length(var)){
        assign(name[k], get(var[k]))
      }
      
      ## Get labels for all images
      data1_labels = unique(data1[["Label"]])
      data2_labels = unique(data2[["Label"]])
      
      if(max(unlist(str_locate_all(data1_labels, c(".czi"))))>max(unlist(str_locate_all(data1_labels, c(".tif"))))){
        if(length(data1_labels)>length(data2_labels)){
          data1_labels = data1_labels[str_detect(data1_labels,str_c(sapply(strsplit(data2_labels, ".czi"), "[", 1), collapse = "|"))]
          data1=data1[data1$Label %in% data1_labels,]
        } else if (length(data1_labels)<length(data2_labels)){
          data2_labels = data2_labels[str_detect(data2_labels,str_c(sapply(strsplit(data1_labels, ".czi"), "[", 1), collapse = "|"))]
          data2=data2[data2$Label %in% data2_labels,]
        }
      } else if(max(unlist(str_locate_all(data1_labels, c(".tif"))))>max(unlist(str_locate_all(data1_labels, c(".czi"))))) {
        if(length(data1_labels)>length(data2_labels)){
          data1_labels = data1_labels[str_detect(data1_labels,str_c(sapply(strsplit(data2_labels, ".tif"), "[", 1), collapse = "|"))]
          data1=data1[data1$Label %in% data1_labels,]
        } else if (length(data1_labels)<length(data2_labels)) {
          data2_labels = data2_labels[str_detect(data2_labels,str_c(sapply(strsplit(data1_labels, ".tif"), "[", 1), collapse = "|"))]
          data2=data2[data2$Label %in% data2_labels,]
        }
      }
      
    
      data1["Coloc"] = NA
      data2["Coloc"] = NA
      data1["Coloc.index"] = NA
      data2["Coloc.index"] = NA
      data1.temp = c()
      data2.temp = c()
      Coloc.index1 = c()
      Coloc.index2 = c()
      for (n in 1:length(data1_labels)) {
        ### Points with intersecting circles r are assumed to be likely colocalised
        temp.mask = matrix(nrow = dim(data2[data2$Label == data2_labels[n],])[1], ncol = dim(data1[data1$Label == data1_labels[n],])[1])
        ID.index1 = rep(NA,dim(data1[data1$Label == data1_labels[n],])[1])
        ID.index2 = rep(NA,dim(data2[data2$Label == data2_labels[n],])[1])
        for (i in 1:dim(data1[data1$Label == data1_labels[n],])[1]) {
          x= data1[data1$Label == data1_labels[n],]$XM[[i]]
          y= data1[data1$Label == data1_labels[n],]$YM[[i]]
          h= data2[data2$Label == data2_labels[n],]$XM
          k= data2[data2$Label == data2_labels[n],]$YM
          d=sqrt((x-h)^2+(y-k)^2)
          r1=sqrt(data1[data1$Label == data1_labels[n],]$Area[[i]]/pi)
          r2=sqrt(data2[data2$Label == data2_labels[n],]$Area/pi)
          temp.mask[,i] = d<(r1+r2)
          data1.temp = c(data1.temp, sum(temp.mask[,i]))
          
        }
        ID.arrayInd = arrayInd(which(temp.mask), dim(temp.mask))
        ID.index1[ID.arrayInd[,2]] = ID.arrayInd[,1]
        ID.index2[ID.arrayInd[,1]] = ID.arrayInd[,2]
        Coloc.index1 = c(Coloc.index1, ID.index1)
        Coloc.index2 = c(Coloc.index2, ID.index2)
        data2.temp = c(data2.temp,rowSums(temp.mask))
      }
      data1["Coloc"] = data1.temp > 0
      data2["Coloc"] = data2.temp > 0
      data1["Coloc.index"] = Coloc.index1
      data2["Coloc.index"] = Coloc.index2
      if (is.null(label)){
        write_csv(data1, file = paste0(output_path,"/",p,"_coloc_pop.csv"))
        write_csv(data2, file = paste0(output_path,"/",j,"_coloc_pop.csv"))
      } else {
        write_csv(data1, file = paste0(output_path,"/",p,"_",label[1],"_coloc_pop.csv"))
        write_csv(data2, file = paste0(output_path,"/",j,"_",label[2],"_coloc_pop.csv"))
      }
      
      
      }
  }




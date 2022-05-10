
coloc_particles <- function(channel1,channel2,output_path)

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
      
      if(length(data1_labels)>length(data2_labels)){
        data1_labels = data1_labels[str_detect(data1_labels,str_c(sapply(strsplit(data2_labels, ".czi"), "[", 1), collapse = "|"))]
        data1=data1[data1$Label %in% data1_labels,]
      } else {
        data2_labels = data2_labels[str_detect(data2_labels,str_c(sapply(strsplit(data1_labels, ".czi"), "[", 1), collapse = "|"))]
        data2=data2[data2$Label %in% data2_labels,]
      }
      data1["Coloc"] = NA
      data2["Coloc"] = NA
      data1.temp = c()
      data2.temp = c()
      
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
          data1.temp = c(data1.temp, sum(temp.mask[,i]))
        }
        data2.temp = c(data2.temp,rowSums(temp.mask))
        for (m in 1:dim(data1[data1$Label == data1_labels[n],])[1]) {
          
        }
      }
      data1["Coloc"] = data1.temp > 0
      data2["Coloc"] = data2.temp > 0
      write_csv(data1, file = paste0(output_path,"/",p,"_coloc_pop.csv"))
      write_csv(data2, file = paste0(output_path,"/",j,"_coloc_pop.csv"))
      
      }
  }




### Data format

## Filters and format datasets


### Subtracts image mean from particle mean value
temp.data.sub_mean = temp.data
for (i in unique(temp.data.imgstat$Label)) {
  if(dim(temp.data.sub_mean[temp.data$Label == i,])[1]>0){
    temp.data.sub_mean[temp.data.sub_mean$Label == i,"Mean"]=(temp.data.sub_mean[temp.data.sub_mean$Label == i,"Mean"]-temp.data.imgstat[temp.data.imgstat$Label == i,"Mean"])#/(temp.data.imgstat[temp.data.imgstat$Label == i,"Max"]-temp.data.imgstat[temp.data.imgstat$Label == i,"Min"])
  } else {
    next
  }
}
### Remove any mean values below 0
temp.data.sub_mean = temp.data.sub_mean[temp.data.sub_mean$Mean > 0,]
### Recalcualtes the IntDen variable based on the corrected mean value for the particle
for (i in 1:dim(temp.data.sub_mean)[1]) {
    temp.data.sub_mean[i,"IntDen"] = temp.data.sub_mean[i,"Area"]*temp.data.sub_mean[i,"Mean"]
}

### Discards all data below 75th quartile
### Channel, batch and technical repeat speciifc

temp.data.sub_mean_75th = temp.data.sub_mean
for (i in unique(temp.data.sub_mean_75th$Channel)) {
for (k in 1:max(tech_rep)) {
  for (m in 1:max(batch_rep)) {
   q = quantile(temp.data.sub_mean_75th[temp.data.sub_mean_75th$Channel == i & temp.data.sub_mean_75th$TechRepeat == k & temp.data.sub_mean_75th$BatchRepeat == m & temp.data.sub_mean_75th$Mean >0,"Mean"], c(0.75))
   temp.data.sub_mean_75th = temp.data.sub_mean_75th[!c(temp.data.sub_mean_75th$Channel == i & temp.data.sub_mean_75th$TechRepeat == k & temp.data.sub_mean_75th$BatchRepeat == m & temp.data.sub_mean_75th$Mean < q),]
   q = quantile(temp.data.sub_mean_95th[temp.data.sub_mean_95th$Channel == i & temp.data.sub_mean_95th$TechRepeat == k & temp.data.sub_mean_95th$BatchRepeat == m & temp.data.sub_mean_95th$Mean >0,"IntDen"], c(0.95))
   temp.data.sub_mean_95th = temp.data.sub_mean_95th[!c(temp.data.sub_mean_95th$Channel == i & temp.data.sub_mean_95th$TechRepeat == k & temp.data.sub_mean_95th$BatchRepeat == m & temp.data.sub_mean_95th$IntDen < q),]
  
   }
}
}
### Discards all data below 95th quartile
### Channel, batch and technical repeat speciifc
temp.data.sub_mean_95th = temp.data.sub_mean
for (i in unique(temp.data.sub_mean_95th$Channel)) {
  for (k in 1:max(tech_rep)) {
    for (m in 1:max(batch_rep)) {
      q = quantile(temp.data.sub_mean_95th[temp.data.sub_mean_95th$Channel == i & temp.data.sub_mean_95th$TechRepeat == k & temp.data.sub_mean_95th$BatchRepeat == m & temp.data.sub_mean_95th$Mean >0,"Mean"], c(0.95))
      temp.data.sub_mean_95th = temp.data.sub_mean_95th[!c(temp.data.sub_mean_95th$Channel == i & temp.data.sub_mean_95th$TechRepeat == k & temp.data.sub_mean_95th$BatchRepeat == m & temp.data.sub_mean_95th$Mean < q),]
      q = quantile(temp.data.sub_mean_95th[temp.data.sub_mean_95th$Channel == i & temp.data.sub_mean_95th$TechRepeat == k & temp.data.sub_mean_95th$BatchRepeat == m & temp.data.sub_mean_95th$Mean >0,"IntDen"], c(0.95))
      temp.data.sub_mean_95th = temp.data.sub_mean_95th[!c(temp.data.sub_mean_95th$Channel == i & temp.data.sub_mean_95th$TechRepeat == k & temp.data.sub_mean_95th$BatchRepeat == m & temp.data.sub_mean_95th$IntDen < q),]
      }
  }
}

### Check for unimodality and bimodality
for (i in unique(temp.data.sub_mean$Channel)) {
  for (n in unique(temp.data.sub_mean$Experiment)) {
    for (k in 1:max(tech_rep)) {
      for (m in 1:max(batch_rep)) {
        print(is.unimodal(temp.data.sub_mean[temp.data.sub_mean$Channel == i & temp.data.sub_mean$TechRepeat == k & temp.data.sub_mean$BatchRepeat == m & temp.data.sub_mean$Experiment == n & temp.data.sub_mean$Mean >0,"Mean"]))
        print(paste(i,n,k,m, sep = "-"))
      }
    }
  }
}


mean.particle.mean = c()
for (i in temp.data.imgstat$Label) {
  if(dim(temp.data[temp.data$Label == i,])[1]>0){
    mean.particle.mean = c(mean.particle.mean, mean(temp.data[temp.data$Label == i,"Mean"]))
  } else {
    mean.particle.mean = c(mean.particle.mean, 0)
  }
}

mean.particle.std = c()
for (i in temp.data.imgstat$Label) {
  if(dim(temp.data[temp.data$Label == i,])[1]>0){
    mean.particle.std = c(mean.particle.std, mean(temp.data[temp.data$Label == i,"StdDev"]))
  } else {
    mean.particle.std = c(mean.particle.std, 0)
  }
}

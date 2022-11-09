### Data format

## Filters and format datasets

temp.data.thresh_mean = temp.data

for (i in temp.data.imgstat$Label) {
  if(dim(temp.data.thresh_mean[temp.data$Label == i,])[1]>0){
    temp.data.thresh_mean[temp.data.thresh_mean$Label == i,"Mean"]=temp.data.thresh_mean[temp.data.thresh_mean$Label == i,"Mean"]-temp.data.imgstat[temp.data.imgstat$Label == i,"Mean"]
  } else {
    next
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

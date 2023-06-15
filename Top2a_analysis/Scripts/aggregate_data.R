### Aggregates results from repeats ###
# Author: Carl Möller mocarl@chalmers.se
# 20230615

#Loop through repeats and aggregate results

for (i in temp.data.sub_mean$TechRepeat) {
  for (j in temp.data.sub_mean$BatchRepeat) {
    tdata = temp.data.sub_mean[(temp.data.sub_mean[,"TechRepeat"] == i & temp.data.sub_mean[,"BatchRepeat"] == j),]
    tdata = tdata[tdata$Mean > 0,]
    for (p in tdata$Channel) {
      tdata[tdata$Channel == p,]
    }
  }
  }


temp.data.sub_mean_agg = cbind(aggregate(.~TechRepeat + BatchRepeat + Experiment + Channel, temp.data.sub_mean[,c("TechRepeat","BatchRepeat","Experiment","Channel","Mean","IntDen","Area")], mean))



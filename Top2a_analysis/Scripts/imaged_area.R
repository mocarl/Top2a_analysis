### Finds the total imaged area of each condition ###
# Author: Carl Möller
# 


imgs = temp.data.imgstat
imgs$Label = gsub("^.{0,3}", "", temp.data.imgstat$Label)
imgs = imgs[match(unique(imgs$Label), imgs$Label),]
temp.data.area = data.frame()
for (i in unique(tech_rep)) {
  for (p in unique(batch_rep)) {
  for (j in unique(condition)) {
    for (l in unique(channel)) {
      temp = temp.data[(temp.data[,"TechRepeat"] == i & temp.data[,"BatchRepeat"] == p & temp.data[,"Experiment"] == j & temp.data[,"Channel"] == l),]
      temp.imgs = unique(gsub("^.{0,3}", "", temp$Label))
      temp.area = sum(imgs[match(temp.imgs, imgs$Label),"Area"])
      data = data.frame(ImgArea = temp.area, Experiment = j, Channel = l, TechRepeat = i, BatchRepeat = p)
      temp.data.area = rbind(temp.data.area, data)
    }
  }
  }
}


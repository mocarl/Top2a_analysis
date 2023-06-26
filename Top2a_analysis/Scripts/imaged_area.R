### Finds the total imaged area of each condition ###
# Author: Carl Möller
# 


imgs = temp.data.imgstat
imgs$Label = gsub("^.{0,3}", "", temp.data.imgstat$Label)
imgs = imgs[match(unique(imgs$Label), imgs$Label),]
temp.data.area = data.frame()
for (i in unique(tech_rep)) {
  for (p in unique(concentration)) {
  for (j in unique(condition)) {
    for (l in unique(channel)) {
      temp = temp.data[(temp.data[,"TechRepeat"] == i & temp.data[,"Concentration"] == p & temp.data[,"Condition"] == j & temp.data[,"Channel"] == l),]
      temp.imgs = unique(gsub("^.{0,3}", "", temp$Label))
      temp.area = sum(imgs[match(temp.imgs, imgs$Label),"Area"])
      data = data.frame(ImgArea = temp.area, Experiment = j, Channel = l, TechRepeat = i, BatchRepeat = p)
      temp.data.area = rbind(temp.data.area, data)
    }
  }
  }
}

temp = temp.data.sub_mean[(temp.data.sub_mean$Channel == "Top2\u03b1" & temp.data.sub_mean$IntDen > 250 & (temp.data.sub_mean$TechRepeat == 1 | temp.data.sub_mean$TechRepeat == 3)),c("Concentration", "Condition","IntDen")]
for (i in unique(tech_rep)) {
  for (p in unique(concentration)) {
    for (j in unique(condition)) {
        nmr = dim(temp[(temp[,"TechRepeat"] == i & temp[,"Concentration"] == p & temp[,"Condition"] == j & temp[,"Channel"] == "Top2\u03b1"),])[1]
        area = temp.data.area[(temp.data.area[,"TechRepeat"] == i & temp.data.area[,"Experiment"] == j & temp.data.area[,"BatchRepeat"] == p & temp.data.area[,"Channel"] == "Top2\u03b1"),"ImgArea"]
       print(nmr)
      }
  }
}

my_summary <- temp %>%
  count(Concentration, Condition, sort = TRUE) 
ggplot(my_summary, aes(Condition, n, fill = Concentration)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = 'Particle mean intensity', subtitle = "25nM Top2\u03b1 - 100nM MYC - 250nM pFLIP/pFLIP-FUSE - supercoiled - w/o ATP", caption = "") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle integrated intensity") +
  ylab("")

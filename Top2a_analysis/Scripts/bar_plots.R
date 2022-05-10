### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")

import_csv("/Users/mocarl/Documents/GitHub/Top2a_analysis/Top2a_analysis/Output/pFLIP")
stats = setdiff(ls(), lsf.str())
# Allocate space
temp = data.frame()
## Consolidate data to be plotted
labels = c("rel. w. ATP",
           "rel. wo. ATP",
           "sc. w. ATP",
           "sc. wo. ATP")
for(k in 1:length(stats)){
  temp = rbind(temp,get(stats[k])[dim(get(stats[k]))[1],])
  temp$Image[k] = labels[k]
}
temp = cbind(temp, data.frame(Condition = c("ATP", "no ATP", "ATP", "no ATP")))

#dir.create(paste("Output/","Graphs"))
dir.create(paste("Output/","Graphs/","pFLIP"))

tiff(file=paste("Output/","Graphs/","pFLIP_FUSE/","pFLIP_10nM_TOP2",".tiff"), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
ggplot(temp, aes(x=Image, y=Relative_coloc)) +
  geom_bar(aes(fill=Condition),width = 0.7,position = position_dodge(0.5),
           stat = "identity", color= "white")+
  labs(title=expression(paste("pFLIP / 10nM TOP2",alpha)), x="Conditions", y ="Relative colocalisation" )+
  scale_fill_manual(values=c("#E1BE6A", "#40B0A6"))+
  theme_minimal()+
  ylim(0,100)+
  theme(aspect.ratio = 2/1)+
  scale_x_discrete(labels=labels)+
  theme(axis.text.x = element_text(color="black", size=9, angle=30, hjust=0.5, vjust =1),axis.text.y = element_text(face="bold",color="black", size=10, angle=0, hjust=0, vjust =0))
dev.off()
 
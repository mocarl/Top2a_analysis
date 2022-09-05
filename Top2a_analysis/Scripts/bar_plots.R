### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")

import_csv("/Users/mocarl/Documents/GitHub/Top2a_analysis/Top2a_analysis/Output/pFLIP_FUSE")


stats = setdiff(ls(), lsf.str())
# Allocate space
temp = data.frame()
## Consolidate data to be plotted
labels = c("rel. w. ATP",
           "rel. wo. ATP",
           "rel. w. yATP",
           "sc. w. ATP",
           "sc. wo. ATP",
           "sc. w. yATP")
for(k in 1:length(stats)){
  temp = rbind(temp,get(stats[k])[dim(get(stats[k]))[1],])
  temp$Image[k] = labels[k]
}
temp = cbind(temp, data.frame(Condition = c("ATP", "no ATP","yATP", "ATP", "no ATP","yATP")))
temp$Image = factor(temp$Image, levels = temp$Image)
#dir.create(paste("Output/","Graphs"))
dir.create(paste("Output/","Graphs/","pFLIP"))

## File format
svg(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Kathryn_Donald_temp/","relColoc_Top2a_MYC_95th.svg",sep = ""), width = 5, height = 5, pointsize = 7)
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Kathryn_Donald_temp/","relColoc_Top2a_MYC_95th.tiff",sep = ""), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
#Plot command
#Coloc statistics
ggplot(coloc_stats[-c(13,14),], aes(x=Experiment, y=Coloc.Per, fill=Category, na.rm= TRUE)) +
  geom_bar(aes(fill=Category),width = 0.7,position = position_dodge(0.5),
           stat = "identity", color= "white", na.rm = TRUE)+
  labs(title="Relative colocalisation of Top2\u03b1 \nand MYC in large DNA droplets", x="Conditions", y ="Relative colocalisation", caption = "1 replicate, 95th percentile only")+
  scale_fill_manual(values=c("#E1BE6A", "#40B0A6","#D6E897"))+
  theme_minimal()+
  ylim(0,100)+
  theme(aspect.ratio = 2/1)+
  theme(axis.text.x = element_text(color="black", size=9, angle=30, hjust=0.5, vjust =1),axis.text.y = element_text(face="bold",color="black", size=10, angle=0, hjust=0, vjust =0))
#Close plot
dev.off()
 

## File format
svg(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Kathryn_Donald_temp/","relIntensity_Top2a_MYC.svg",sep = ""), width = 5, height = 5, pointsize = 7)
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Kathryn_Donald_temp/","relIntensity_Top2a_MYC.tiff",sep = ""), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
#Plot command
# Intensity statistics
ggplot(intensity_stats[-c(15,16),], aes(x=Experiment, y=Coloc.Per, fill=Category, na.rm= TRUE)) +
  geom_bar(aes(fill=Category),width = 0.7,position = position_dodge(0.5),
           stat = "identity", color= "white", na.rm = TRUE)+
  labs(title="Relative intensity of Top2\u03b1 \nand MYC colocalised DNA droplets", x="Conditions", y ="Relative colocalisation", caption = "1 replicate, 5th and 95th percentile removed")+
  scale_fill_manual(values=c("#4f73a1", "#359d73","#F8B195","#f0be39"))+
  theme_minimal()+
  ylim(0,100)+
  theme(aspect.ratio = 2/1)+
  theme(axis.text.x = element_text(color="black", size=9, angle=30, hjust=0.5, vjust =1),axis.text.y = element_text(face="bold",color="black", size=10, angle=0, hjust=0, vjust =0))
dev.off()



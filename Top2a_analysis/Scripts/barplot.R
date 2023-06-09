### Statistical analysis of Top2a deposited on funcitonalised glass slides
## 
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")


### Sum of pixel intensity per particle with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Supp 4/","box_plot_YOYOcontrol.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)

ggplot(temp.data.sub_mean[temp.data.sub_mean$Channel == "YOYO1" & temp.data.sub_mean$Mean > 500,], aes(y =Mean, x = Condition, fill = Channel)) +
  geom_text(aes(label=..count..), y=0, stat='count', colour="red", size=3)+
  geom_bar(stat="identity", width=0.5)+
  #facet_wrap(~Concentration + Condition, scale="free")+
  labs(title = 'Particle mean intensity', subtitle = "25nM Top2\u03b1 - 100nM MYC - 250nM pFLIP/pFLIP-FUSE - supercoiled - w/o ATP", caption = "") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle integrated intensity") +
  ylab("")
ylim(0,1000)

dev.off()

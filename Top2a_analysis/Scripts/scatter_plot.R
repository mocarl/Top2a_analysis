### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")


tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/","scatter_Area_IntDen_MYC_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp.data, aes(y = Area, x = Mean, color = Channel)) +
  geom_point(alpha = 0.5)+
  facet_wrap(.~Experiment + coloc, scale="free_x")+
  #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Area VS IntDen - non & colocalised population', subtitle = "25 Top2\u03b1 - 25-100nM MYC 250 pFLIP-FUSE - supercoiled - w/o ATP", caption = "1 Replicates")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  scale_fill_manual(
    name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
    labels = unique(channel))+
ylim(0,50)
#coord_fixed(ratio = 0.4)
#scale_x_discrete(breaks=unique(rep),labels=ylab)
dev.off()

### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")


tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 2/V3/","scatter_StdDev_Area.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp.data[temp.data$Coloc == TRUE,], aes(y = StdDev, x = Area, shape = Plasmid, color = Experiment)) +
  geom_point()+
  facet_wrap(.~Plasmid, scale="free_x")+
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Mean VS Median - non & colocalised population', subtitle = "10nM Top2\u03b1 - 250nM pFLIP/pFLIP-FUSE - supercoiled/relaxed - w/o ATP", caption = "3 Replicates - 5th and 95th percentile removed")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()
  xlab("Particle area distribution") +
  ylab("\u03bcm^2")
  ylim(0,1500)
#coord_fixed(ratio = 0.4)
scale_x_discrete(breaks=unique(rep),labels=ylab)
dev.off()

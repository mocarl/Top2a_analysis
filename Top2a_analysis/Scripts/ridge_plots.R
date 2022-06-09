### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

### Import and arrange data into one dataframe
import_csv("Output/pFLIP/pFLIP_relaxed_10nM_Top2a_noATP")
import_csv("Output/pFLIP/pFLIP_supercoiled_10nM_Top2a_noATP")
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_relaxed_10nM_Top2a_noATP")
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_supercoiled_10nM_Top2a_noATP")
rm(pFLIP_relaxed_10nM_Top2a_noATP__coloc_statistics)
rm(pFLIP_supercoiled_10nM_Top2a_noATP__coloc_statistics)
rm(pFLIP_FUSE_relaxed_10nM_Top2a_noATP__coloc_statistics)
rm(pFLIP_FUSE_supercoiled_10nM_Top2a_noATP__coloc_statistics)
var = setdiff(ls(), lsf.str())

temp.data = data.frame()
plasmid=c("pFLIP-supercoiled",
          "pFLIP-supercoiled",
          "pFLIP-relaxed",
          "pFLIP-relaxed",
          "pFLIP-FUSE-supercoiled",
          "pFLIP-FUSE-supercoiled",
          "pFLIP-FUSE-relaxed",
          "pFLIP-FUSE-relaxed")
temp.data = data.frame()
for (i in 1:length(var)){
  temp.data = rbind(temp.data, data.frame(get(paste0(var[i])),Experiment = paste0(var[i]), Plasmid=paste(plasmid[i])))
}
temp.data$Experiment = factor(temp.data$Experiment, levels = temp.data$Experiment)
## Generate ridgeplot with density and histogram overlay

#Define labels for y-axis ticks
ylab=c("pFLIP-supercoiled \nYOYO-1",
       "pFLIP-supercoiled \nTop2\u03b1",
       "pFLIP-relaxed \nYOYO-1",
       "pFLIP-relaxed \nTop2\u03b1",
       "pFLIP-FUSE-supercoiled \nYOYO-1",
       "pFLIP-FUSE-supercoiled \nTop2\u03b1",
       "pFLIP-FUSE-relaxed \nYOYO-1",
       "pFLIP-FUSE-relaxed \nTop2\u03b1")

### Area distribution with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 2/","ridge_plot_area_noncolocpop.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp.data[temp.data$Coloc == FALSE,], aes(x = Area, fill = Experiment, y = Plasmid, height=..density..,scale=0.9)) +
  geom_density_ridges(stat = "binline", bins=150,
                      draw_baseline = F, alpha = 1,lwd=0.1 )+
  geom_density_ridges(quantile_lines = TRUE, quantiles = 2, rel_min_height = 0.001, alpha = 0.4, lwd=0.3, colour="black")+
  #facet_wrap(~Plasmid, scale="free")
  labs(title = 'Particle area colocalised population', subtitle = "10nM Top2\u03b1 - 250nM pFLIP/pFLIP-FUSE - w/o ATP") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle area histogram/density with median") +
  ylab("Plasmid")+
  xlim(0,5)+
  scale_fill_cyclical(values = c("#40B0A6","#E1BE6A"),
                      guide = "legend", name = "Channel",
                      labels = c("Top2\u03b1", "YOYO-1"))

dev.off()
#scale_fill_manual(
 # name = "Population", values = c("#E1BE6A", "#40B0A6"),
  #labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
### Sum of pixel intensity per particle with median
tiff(file=paste("Output/","Graphs/","pFLIP/","pFLIP_relaxed_10nM_TOP2_intensity_dist_yATP",".tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp.data, aes(x = IntDen, y = Experiment, fill = Coloc, height=..density..,scale=1)) +
  geom_density_ridges(stat = "binline", bins=150,
                      draw_baseline = F, alpha = 1,lwd=0.1 )+
  geom_density_ridges(quantile_lines = TRUE, quantiles = 2, rel_min_height = 0.001, alpha = 0.4, lwd=0.3, colour="black")+
  labs(title = 'Summed pixel intensity per particle', subtitle = "10nM pFLIP relaxed w/wo ATP") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Sum of pixel intensity per particle with median") +
  ylab("Condition")+
  xlim(-1,200)+
  scale_y_discrete(breaks=var,labels=ylab)+
  scale_fill_manual(
    name = "Population", values = c("#E1BE6A", "#40B0A6"),
    labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
dev.off()


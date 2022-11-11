### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

### Import and arrange data into one dataframe
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_supercoiled_10nM_Top2a")
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_relaxed_10nM_Top2a")
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_relaxed_10nM_Top2a_noATP")
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_supercoiled_10nM_Top2a_noATP")
rm(pFLIP_relaxed_10nM_Top2a_noATP__coloc_statistics)
rm(pFLIP_supercoiled_10nM_Top2a_noATP__coloc_statistics)
rm(pFLIP_FUSE_relaxed_10nM_Top2a_noATP__coloc_statistics)
rm(pFLIP_FUSE_supercoiled_10nM_Top2a_noATP__coloc_statistics)
var = setdiff(ls(), lsf.str())

temp.data = data.frame()
plasmid=c("pFLIP-supercoiled",
          "pFLIP-supercoiled")

for (i in 1:length(var)){
  temp.data = rbind(temp.data, data.frame(get(paste0(var[i])),Experiment = paste0(var[i])))
}
temp.data$Experiment = factor(temp.data$Experiment, levels = unique(temp.data$Experiment))
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


#Filter data
q = quantile(temp.data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
temp = temp.data[temp.data$Area<=q[1] & temp.data$Circ.>0.5,] # Generate temp data set that can be altered until right filter settings are found
### Area distribution with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 4/MYC/","ridge_plot_area_colocpop_MYConly_95th.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
 ggplot(df[df$Channel == "YOYO1",], aes(x = IntDen, y = BatchRepeat , fill = Experiment, height=..density..,scale=0.9)) +
  geom_density_ridges(stat = "binline", bins=100,
                      draw_baseline = F, alpha = 1,lwd=0.2 )+
  geom_density_ridges(quantile_lines = TRUE, quantiles = c(0.5 ,0.75), rel_min_height = 0.001, alpha = 0.4, lwd=0.5)+
  facet_wrap(~TechRepeat, scales = "fixed")+
  labs(title = 'Particle area colocalised population', subtitle = "25-100nM MYC - 250nM pFLIP-FUSE-supercoiled - w/o ATP",caption = "1 Replicate - 95th percentile only") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle area histogram/density with median") +
  ylab("Population")+
  xlim(0,500)
  scale_fill_cyclical(values = c("#E1BE6A","#40B0A6"),
                      guide = "legend", name = "Channel",
                      labels = c("Top2\u03b1", "YOYO-1"))
dev.off()

#scale_fill_manual(
 # name = "Population", values = c("#E1BE6A", "#40B0A6"),
  #labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
### Sum of pixel intensity per particle with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/","Area_Top2_MYC_Raw.tiff", sep=""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)


ggplot(temp.data[!(temp.data$Experiment == condition[4] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == condition[7] & temp.data$Plasmid == channel[1]),], aes(x = IntDen, y = Experiment, fill = Plasmid, height=..density.., scale=1)) +
  geom_density_ridges(stat = "binline", bins=500,
                      draw_baseline = F, alpha = 1,lwd=0.1 )+
  geom_density_ridges(quantile_lines = TRUE, quantiles = 2, rel_min_height = 0.001, alpha = 0.4, lwd=0.3, colour="black")+
  labs(title = 'Area per particle', subtitle = "25-100nM MYC - 250nM pFLIP-FUSE-supercoiled - w/o ATP", caption = "1 replicate - Data is unfiltered") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Area per particle with median") +
  ylab("Condition")+
  xlim(0,100)+
scale_fill_manual(
  name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
  labels = unique(channel))
  #scale_y_discrete(breaks=var,labels=ylab)
  #scale_fill_manual(name = "Population", values = c("#E1BE6A", "#40B0A6"),labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
dev.off()


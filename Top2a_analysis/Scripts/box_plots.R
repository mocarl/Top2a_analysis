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
#Unicode alpha = \u03b1
expression(paste0("pFLIP-supercoiled \nTop2a"))
#Define labels for y-axis ticks
ylab=c("pFLIP-supercoiled \nYOYO-1",
       "pFLIP-supercoiled \nTop2\u03b1",
       "pFLIP-relaxed \nYOYO-1",
       "pFLIP-relaxed \nTop2\u03b1",
       "pFLIP-FUSE-supercoiled \nYOYO-1",
       "pFLIP-FUSE-supercoiled \nTop2\u03b1",
       "pFLIP-FUSE-relaxed \nYOYO-1",
       "pFLIP-FUSE-relaxed \nTop2\u03b1")

temp.data <- temp.data %>%
  group_by(Experiment) %>% 
  mutate(value_norm = IntDen - min(IntDen), 
         value_norm = value_norm / max(value_norm))

### Area distribution with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 2/","box_plot_area_colocpop.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp.data[temp.data$Coloc == TRUE,], aes(y = Area, x = Experiment, fill = Plasmid)) +
  geom_boxplot()+
  facet_wrap(~Plasmid, scale="free")+
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Particle area - colocalised population', subtitle = "10nM Top2\u03b1 - 250nM pFLIP/pFLIP-FUSE - w/o ATP")+
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle area distribution") +
  ylab("")+
  ylim(0,10)+
  scale_x_discrete(breaks=var,labels=ylab)
  scale_fill_manual(
    name = "Population", values = c("#E1BE6A", "#40B0A6"),
    labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
dev.off()

#remove outliers = geom_boxplot(outlier.shape = NA)+
### Sum of pixel intensity per particle with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 2/","box_plot_IntDen.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp, aes(y =value_norm, x = Experiment, fill = Coloc)) +
  geom_boxplot()+
  facet_wrap(~Plasmid, scale="free")+
  labs(title = 'Particle integrated intensity', subtitle = "10nM Top2\u03b1 - 250nM pFLIP/pFLIP-FUSE - w/o ATP") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle integrated intensity") +
  ylab("")+
  ylim(0,0.1)+
  scale_x_discrete(breaks=var,labels=ylab)+
  scale_fill_manual(
    name = "Population", values = c("#E1BE6A", "#40B0A6"),
    labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
dev.off()





### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")


give.n <- function(x){
  return(c(y = median(x)*1.05, label = length(x))) 
  # experiment with the multiplier to find the perfect position
}
### Import and arrange data into one dataframe
import_csv("Data/3rd")
import_csv("Output/pFLIP/pFLIP_supercoiled_10nM_Top2a_noATP")
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_relaxed_10nM_Top2a_woATP")
import_csv("Output/pFLIP_FUSE/pFLIP_FUSE_supercoiled_10nM_Top2a_woATP")
rm()


var = setdiff(ls(), lsf.str())

plasmid=c( "pFLIP-FUSE-relaxed",
           "pFLIP-FUSE-relaxed",
           "pFLIP-FUSE-supercoiled",
           "pFLIP-FUSE-supercoiled",
           "pFLIP-relaxed",
           "pFLIP-relaxed",
           "pFLIP-FUSE-relaxed",
           "pFLIP-FUSE-relaxed",
           "pFLIP-supercoiled",
           "pFLIP-supercoiled",
           "pFLIP-FUSE-supercoiled",
           "pFLIP-FUSE-supercoiled",
           "pFLIP-relaxed",
           "pFLIP-relaxed",
           "pFLIP-FUSE-relaxed",
           "pFLIP-FUSE-relaxed",
           "pFLIP-supercoiled",
           "pFLIP-supercoiled",
           "pFLIP-FUSE-supercoiled",
           "pFLIP-FUSE-supercoiled",
           "pFLIP-relaxed",
           "pFLIP-relaxed",
           "pFLIP-supercoiled",
           "pFLIP-supercoiled")

rep=c( "A",
            "AY",
            "B",
            "BY",
            "C",
            "CY",
            "A",
            "AY",
            "D",
            "DY",
            "B",
            "BY",
            "C",
            "CY",
            "A",
            "AY",
            "D",
            "DY",
            "B",
            "BY",
            "C",
            "CY",
            "D",
            "DY")

temp.data = data.frame()
for (i in 1:length(var)){
    temp.data = rbind(temp.data, data.frame(get(paste0(var[i])),Experiment = paste(rep[i]), Plasmid=paste(plasmid[i])))
    }
temp.data$Experiment = factor(temp.data$Experiment, levels = temp.data$Experiment)
## Generate ridgeplot with density and histogram overlay
#Unicode alpha = \u03b1
expression(paste0("pFLIP-supercoiled \nTop2a"))
#Define labels for y-axis ticks

ylab=c( "pFLIP-FUSE-relaxed \nTop2\u03b1",
   "pFLIP-FUSE-relaxed \nYOYO-1",
   "pFLIP-FUSE-supercoiled \nTop2\u03b1",
   "pFLIP-FUSE-supercoiled \nYOYO-1",
   "pFLIP-relaxed \nTop2\u03b1",
   "pFLIP-relaxed \nYOYO-1",
   "pFLIP-FUSE-relaxed \nTop2\u03b1",
   "pFLIP-FUSE-relaxed \nYOYO-1",
   "pFLIP-supercoiled \nTop2\u03b1",
   "pFLIP-supercoiled \nYOYO-1",
   "pFLIP-FUSE-supercoiled \nTop2\u03b1",
   "pFLIP-FUSE-supercoiled \nYOYO-1",
   "pFLIP-relaxed \nTop2\u03b1",
   "pFLIP-relaxed \nYOYO-1",
   "pFLIP-FUSE-relaxed \nTop2\u03b1",
   "pFLIP-FUSE-relaxed \nYOYO-1",
   "pFLIP-supercoiled \nTop2\u03b1",
   "pFLIP-supercoiled \nYOYO-1",
   "pFLIP-FUSE-supercoiled \nTop2\u03b1",
   "pFLIP-FUSE-supercoiled \nYOYO-1",
   "pFLIP-relaxed \nTop2\u03b1",
   "pFLIP-relaxed \nYOYO-1",
   "pFLIP-supercoiled \nTop2\u03b1",
   "pFLIP-supercoiled \nYOYO-1")

### Way to scale 0-1 one variable
temp.data <- temp.data %>%
  group_by(Experiment) %>% 
  mutate(value_norm = IntDen - min(IntDen), 
         value_norm = value_norm / max(value_norm))
#Filter data
q = quantile(temp.data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
temp = temp.data[temp.data$Area<q[2] & temp.data$Area>q[1] & temp.data$Circ.>0.5,] # Generate temp data set that can be altered until right filter settings are found
## Set labels
xlabs <- paste(c( "pFLIP-FUSE-relaxed \nTop2\u03b1",
                  "pFLIP-FUSE-relaxed \nYOYO-1",
                  "pFLIP-FUSE-supercoiled \nTop2\u03b1",
                  "pFLIP-FUSE-supercoiled \nYOYO-1",
                  "pFLIP-relaxed \nTop2\u03b1",
                  "pFLIP-relaxed \nYOYO-1",
                  "pFLIP-FUSE-relaxed \nTop2\u03b1",
                  "pFLIP-FUSE-relaxed \nYOYO-1"),"\n(N=",table(temp$Experiment[temp$Coloc == TRUE]),")",sep="")
xlabs <- c( "pFLIP-FUSE-relaxed \nTop2\u03b1",
                  "pFLIP-FUSE-relaxed \nYOYO-1",
                  "pFLIP-FUSE-supercoiled \nTop2\u03b1",
                  "pFLIP-FUSE-supercoiled \nYOYO-1",
                  "pFLIP-relaxed \nTop2\u03b1",
                  "pFLIP-relaxed \nYOYO-1",
                  "pFLIP-FUSE-relaxed \nTop2\u03b1",
                  "pFLIP-FUSE-relaxed \nYOYO-1")
### Area distribution with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 2/","box_plot_area_colocpop.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp[temp$Coloc == TRUE,], aes(y = Area, x = Experiment, fill = Plasmid)) +
  geom_boxplot(outlier.alpha = 0.1)+
  facet_wrap(.~Plasmid, scale="free_x")+
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Particle area - colocalised population', subtitle = "10nM Top2\u03b1 - 250nM pFLIP/pFLIP-FUSE - w/o ATP", caption = "3 Replicates - only 95th percentile")+
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle area distribution") +
  ylab("\u03bcm^2")+
  ylim(0,10)+
  scale_x_discrete(breaks=unique(rep),labels=xlabs)
  stat_summary(fun= give.n, label = NULL, geom='text',col='blue',cex=5)
dev.off()

scale_fill_manual(
  name = "Population", values = c("#E1BE6A", "#40B0A6"),
  labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
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





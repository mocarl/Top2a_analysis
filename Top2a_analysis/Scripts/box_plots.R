### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")



## Generate ridgeplot with density and histogram overlay
#Unicode alpha = \u03b1
expression(paste0("pFLIP-supercoiled \nTop2a"))
#Define labels for y-axis ticks


max_min_norm(temp.data, Mean, c("Experiment", "Plasmid"))
#Filter data
q = quantile(temp.data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
temp = temp.data[temp.data$Area<q[2] & temp.data$Area>q[1] & temp.data$Circ.>0.5,] # Remove 5th and 95th percentile
temp = temp.data[temp.data$Area>q[2] & temp.data$Circ.>0.5,] # 95th percentile only
temp = temp.data

### Find data points that are colocalised in all labels
temp_all_coloc = data.frame()
count = 0
for (j in unique(rep)) {
  #temp = temp.data[temp.data[temp.data[temp.data$Plasmid == unique(plasmid)[3],]$Experiment == j,]$Coloc == TRUE,]
  temp = temp.data[temp.data$Plasmid == unique(plasmid)[1+count] & temp.data$Experiment == j,"Coloc"] 
  temp2 = temp.data[temp.data$Plasmid == unique(plasmid)[2+count] & temp.data$Experiment == j,]
  temp3 = temp2[temp,]
  temp3 = temp3[temp3$Coloc == TRUE,]
  temp_all_coloc = rbind(temp_all_coloc, temp3)
  count = count + 2
}
  temp = temp.data[temp.data$Plasmid == unique(plasmid)[3] & temp.data$Experiment == j & temp.data$Coloc == TRUE,]
  temp = temp.data[temp.data$Plasmid == unique(plasmid)[4] & temp.data$Experiment == j & temp.data$Coloc == TRUE,]
  temp = temp.data[temp.data$Plasmid == unique(plasmid)[5] & temp.data$Experiment == j & temp.data$Coloc == TRUE,]

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
                  "pFLIP-supercoiled \nTop2\u03b1",
                  "pFLIP-supercoiled \nYOYO-1")



### PLot boxes
df = data.frame(IntDen = temp.data.sub_mean_75th[,"Area"]*temp.data.sub_mean_75th[,"Mean"],
                Experiment = temp.data.sub_mean_75th[,"Experiment"], 
                BatchRepeat = temp.data.sub_mean_75th[,"BatchRepeat"], 
                Channel = temp.data.sub_mean_75th[,"Channel"],
                TechRepeat = temp.data.sub_mean_75th[,"TechRepeat"])

tiff(file=paste("Output/top_down/","box_plot_Mean_zoom.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp.temp.data, aes(y = Mean, x = BatchRepeat, fill = Channel)) +
  geom_boxplot(outlier.alpha = 0.1, width=0.5, position = position_dodge(0.6))+
  #geom_text(aes(label=..count..), y=0, stat='count', colour="red", size=4)+
  facet_wrap(.~TechRepeat + Experiment, scale="free_x")+
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Mean intensity - ', subtitle = "10nM Top2\u03b1 - 100nM MYC - 250nM pFLIP/pFLIP-FUSE - supercoiled - w/o ATP", caption = "2 Technical replicates - 2 within batch replicatses")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  #xlab("Particle area distribution") +
  #ylab("\u03bcm^2")+
  ylab("a.u.")+
  ylim(0,2500)
  #coord_fixed(ratio = 0.4)
  #scale_x_discrete(breaks=unique(rep),labels=ylab)
dev.off()

ggplotly(box)

scale_fill_manual(
  name = "Population", values = c("#E1BE6A", "#40B0A6"),
  labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
#remove outliers = geom_boxplot(outlier.shape = NA)+

### Sum of pixel intensity per particle with median
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Supp 4/","box_plot_YOYOcontrol.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp.data, aes(y =Area, x = Plasmid, fill = Experiment)) +
  geom_boxplot()+
  facet_wrap(~Plasmid, scale="free")+
  labs(title = 'Particle area distribution', subtitle = "10nM Top2\u03b1 - 250nM pFLIP/pFLIP-FUSE - supercoiled/relaxed - w/o ATP w/o YOYO1", caption = "1 replicate without YOYO1") +
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle integrated intensity") +
  ylab("")+
  ylim(0,5)
  scale_x_discrete(breaks=var,labels=ylab)+
  scale_fill_manual(
    name = "Population", values = c("#E1BE6A", "#40B0A6"),
    labels = c(paste0("Non-colocalised"),paste0("Colocalised")))
dev.off()





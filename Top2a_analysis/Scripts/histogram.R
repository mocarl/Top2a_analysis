### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")



variable = "Median"
for (n in 1:length(unique(condition))) {
  data1 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & temp.data$Experiment == unique(condition)[n],]
  data2 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & filter == FALSE & temp.data$Experiment == unique(condition)[n],]
  
  comb_data = rbind(data1, data2)
  
  #temp.temp.data = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & temp.data$Experiment == unique(condition)[n],]
if(unique(condition)[n]==unique(condition)[2]){
  tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","histo_",variable,"_",unique(condition)[n],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
  g <- ggplot(comb_data, aes(x = Median, fill = Plasmid)) +
    geom_histogram(data = data1,alpha = 0.7, bins = 200, position = "identity")+
    geom_histogram(data = data2,alpha = 0.3, bins = 200, position = "identity",lwd=0.1, colour="black")+
    facet_wrap(.~Experiment, scale="free_x")+
    #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
    labs(title = paste(variable, " - non & colocalised population"), caption = "1 Replicates - Shadow bars represent particles with mean < img.mean")+
    theme(
      legend.position="right",
      panel.spacing.x = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
    theme_minimal()+
    scale_fill_manual(
      name = "Channel", values = c("#5982e2", "#225500"),
      labels = unique(channel)[-2])
  print(g)
  dev.off()
}  else if(unique(condition)[n]==unique(condition)[3]){
  tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","histo_",variable,"_",unique(condition)[n],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
  g <- ggplot(comb_data, aes(x = Median, fill = Plasmid)) +
    geom_histogram(data = data1,alpha = 0.7, bins = 200, position = "identity")+
    geom_histogram(data = data2,alpha = 0.3, bins = 200, position = "identity",lwd=0.1, colour="black")+
    facet_wrap(.~Experiment, scale="free_x")+
    #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
    labs(title = paste(variable, " - non & colocalised population"), caption = "1 Replicates - Shadow bars represent particles with mean < img.mean")+
    theme(
      legend.position="right",
      panel.spacing.x = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
    theme_minimal()+
    scale_fill_manual(
      name = "Channel", values = c("#e55151", "#225500"),
      labels = unique(channel)[-1])
  print(g)
  dev.off()
} else {
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","histo_",variable,"_",unique(condition)[n],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
g <- ggplot(comb_data, aes(x = Median, fill = Plasmid)) +
  geom_histogram(data = data1,alpha = 0.7, bins = 200, position = "identity")+
  geom_histogram(data = data2,alpha = 0.3, bins = 200, position = "identity",lwd=0.1, colour="black")+
  facet_wrap(.~Experiment, scale="free_x")+
  #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = paste(variable, " - non & colocalised population"), caption = "1 Replicates - Shadow bars represent particles with mean < img.mean")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  scale_fill_manual(
    name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
    labels = unique(channel))
print(g)
dev.off()
}
}

## Overlaid histogram
p = 4
data1 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & temp.data$YOYO1_coloc == TRUE & temp.data$Experiment == unique(condition)[p],]
data2 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & temp.data$YOYO1_coloc == FALSE & temp.data$Experiment == unique(condition)[p],]
data3 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & (temp.data$Top2a_coloc == TRUE | temp.data$MYC_coloc == TRUE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]
data4 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & (temp.data$Top2a_coloc == FALSE | temp.data$MYC_coloc == FALSE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]


#data1 = temp.data[temp.data$YOYO1_coloc == TRUE & temp.data$Experiment == unique(condition)[p],]
#data2 = temp.data[temp.data$YOYO1_coloc == FALSE & temp.data$Experiment == unique(condition)[p],]
#data3 = temp.data[(temp.data$Top2a_coloc == TRUE | temp.data$MYC_coloc == TRUE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]
#data4 = temp.data[(temp.data$Top2a_coloc == FALSE | temp.data$MYC_coloc == FALSE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]



comb_data = rbind(data1, data2, data3, data4)
variable = "IntDen"
  tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","histo_overlaid_",variable,"_",unique(condition)[p],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
 ggplot(comb_data, aes(x = Median, fill = Plasmid, na.rm = TRUE)) +
   geom_histogram(data = data2,alpha = 0.3, bins = 200, position = "identity",na.rm = TRUE,lwd=0.1, colour="black")+
   geom_histogram(data = data4,alpha = 0.3, bins = 200, position = "identity",na.rm = TRUE,lwd=0.1, colour="black")+
   geom_histogram(data = data1,alpha = 0.9, bins = 200, position = "identity",na.rm = TRUE)+
   geom_histogram(data = data3,alpha = 0.9, bins = 200, position = "identity",na.rm = TRUE)+
  #facet_wrap(.~Experiment, scale="free_x")+
  #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = paste(variable, " - overlaid non & colocalised population"), subtitle = paste(unique(condition)[p]), caption = "1 Replicates - Shadow histogram is noncolocalised population")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  scale_fill_manual(
   name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
    labels = unique(channel))
dev.off()

p = 6
variable = "Median"
data1 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]
data2 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & (temp.data$Top2a_coloc == TRUE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]
data2.1 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & (temp.data$MYC_coloc == TRUE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]
data3 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & (temp.data$Top2a_coloc == FALSE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]
data3.1 = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & (temp.data$MYC_coloc == FALSE) & temp.data$Experiment == unique(condition)[p] & temp.data$Plasmid == "YOYO1",]
comb_data = rbind(data1, data2,data2.1, data3, data3.1)
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","density_overlaid_YOYO1_",variable,"_",unique(condition)[p],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(comb_data, aes(x = Median, na.rm = TRUE)) +
  #geom_density(data = data1,alpha = 0.9, position = "identity",na.rm = TRUE, lwd=0.1, colour="black", fill = "#225500")+
  geom_density(data = data2,alpha = 0.5, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "#e55151")+
  geom_density(data = data2.1,alpha = 0.5, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "#5982e2")+
  geom_density(data = data3,alpha = 0.5, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "grey")+
  geom_density(data = data3.1,alpha = 0.5, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "grey")+
  #facet_wrap(.~Experiment, scale="free_x")+
  #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = paste(variable, " -non & colocalised YOYO1 population"), subtitle = paste(unique(condition)[p]), caption = "1 Replicates - Darh bars is noncolocalised particles and colored are colocalised")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()
dev.off()


ggplot(comb_data, aes(x = Median, na.rm = TRUE)) +
  geom_histogram(data = data1,alpha = 0.3, bins = 200, position = "identity",na.rm = TRUE, lwd=0.1, colour="black", fill = "#225500")+
  geom_histogram(data = data2,alpha = 0.3, bins = 200, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "#e55151")+
  geom_histogram(data = data2.1,alpha = 0.3, bins = 200, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "5982e2")+
  geom_histogram(data = data3,alpha = 0.2, bins = 200, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "black")+
  geom_histogram(data = data3.1,alpha = 0.2, bins = 200, position = "identity",na.rm = TRUE,lwd=0.1, colour="black", fill = "black")+
  #facet_wrap(.~Experiment, scale="free_x")+
  #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = paste(variable, " -non & colocalised YOYO1 population"), subtitle = paste(unique(condition)[p]), caption = "1 Replicates - Darh bars is noncolocalised particles and colored are colocalised")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  scale_fill_manual(
    name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
    labels = unique(channel))
    
dev.off()
  #Single histogram
thresh = mean(temp.data.thresh_mean$Mean)

  ggplot(temp.data.thresh_mean[temp.data.thresh_mean$Channel == "YOYO1",], aes(x = Area, fill = Experiment)) +
    geom_histogram(aes(y=..density..),alpha = 0.9, bins = 250, position = "identity")+
    #facet_wrap(.~TechRepeat + BatchRepeat, scale="free")+
    scale_fill_viridis(alpha=0.5, discrete = TRUE)+
    labs(title = 'Adjusted mean particle intensity - DNA', subtitle = "Mean intensity of DNA particles adjusted by image mean - top_down analysis", caption = "")+
    theme(
      legend.position="right",
      panel.spacing.x = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
    theme_minimal()+
    ylab("a.u.")+
    #scale_fill_manual(
     # name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
      #labels = unique(channel))
  xlim(0,5)
  
  tiff(file=paste("Output/top_down/","histogram_mean_control_DNA_background_adjusted.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
  dev.off()
  
  ggplot(temp.data.sub_mean[temp.data.sub_mean$Mean > 100,], aes(x = Mean, fill = Experiment)) +
    geom_histogram(aes(y=..density..),alpha = 0.9, bins = 250, position = "identity")+
    #facet_wrap(.~TechRepeat, scale="free")+
    scale_fill_viridis(alpha=0.5, discrete = TRUE)+
    labs(title = 'Mean particle intensity -  DNA channel background adjusted ', subtitle = "Mean intensity of DNA particles - top_down analysis", caption = "")+
    theme(
      legend.position="right",
      panel.spacing.x = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
    theme_minimal()+
    ylab("Relative count")+
    #scale_fill_manual(
    #name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
    #labels = unique(channel))
    xlim(0,500)

  ggplot(temp.data.thresh_mean_control[temp.data.thresh_mean_control$Channel == "YOYO1",], aes(x = Area, fill = Experiment)) +
    geom_histogram(aes(y=..density..),alpha = 0.9, bins = 150, position = "identity")+
    scale_fill_viridis(alpha=0.5, discrete = TRUE)+
    labs(title = 'Mean particle intensity - DNA ', subtitle = "Mean intensity of DNA particles - top_down analysis", caption = "")+
    theme(
      legend.position="right",
      panel.spacing.x = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
    theme_minimal()+
    ylab("a.u.")+
    xlim(0,5)

  
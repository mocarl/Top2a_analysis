### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")



variable = "IntDen"
for (n in 1:length(unique(condition))) {
  data1 = temp.temp.data = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & temp.data$Experiment == unique(condition)[n],]
  data2 = temp.temp.data = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & filter == FALSE & temp.data$Experiment == unique(condition)[n],]
  
  comb_data = rbind(data1, data2)
  
  #temp.temp.data = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & temp.data$Experiment == unique(condition)[n],]
if(unique(condition)[n]==unique(condition)[2]){
  tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","histo_",variable,"_",unique(condition)[n],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
  g <- ggplot(comb_data, aes(x = IntDen, fill = Plasmid)) +
    geom_histogram(data = data2, aes(y = (..count..)/sum(..count..)*100),alpha = 0.1, bins = 500, position = "identity", color = "grey")+
    geom_histogram(data = data1, aes(y = (..count..)/sum(..count..)*100),alpha = 0.9, bins = 500, position = "identity")+
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
      labels = unique(channel)[-2])+
    ylim(0,.5)
  print(g)
  dev.off()
}  else if(unique(condition)[n]==unique(condition)[3]){
  tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","histo_",variable,"_",unique(condition)[n],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
  g <- ggplot(comb_data, aes(x = IntDen, fill = Plasmid)) +
    geom_histogram(data = data2, aes(y = (..count..)/sum(..count..)*100),alpha = 0.1, bins = 500, position = "identity", color = "grey")+
    geom_histogram(data = data1, aes(y = (..count..)/sum(..count..)*100),alpha = 0.9, bins = 500, position = "identity")+
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
      labels = unique(channel)[-1])+
    ylim(0,.5)
  print(g)
  dev.off()
} else {
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersStudents/Top2a_project/Figures/Figure 4/Data_explo/Histo/","histo_",variable,"_",unique(condition)[n],"_Raw.tiff", sep = ""), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
g <- ggplot(comb_data, aes(x = IntDen, fill = Plasmid)) +
  geom_histogram(data = data2, aes(y = (..count..)/sum(..count..)*100),alpha = 0.1, bins = 500, position = "identity", color = "grey")+
  geom_histogram(data = data1, aes(y = (..count..)/sum(..count..)*100),alpha = 0.9, bins = 500, position = "identity")+
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
    labels = unique(channel))+
  ylim(0,.5)
print(g)
dev.off()
}
}

data1 = temp.temp.data = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]),]
data2 = temp.temp.data = temp.data[!(temp.data$Experiment == unique(condition)[2] & temp.data$Plasmid == channel[2]) & !(temp.data$Experiment == unique(condition)[3] & temp.data$Plasmid == channel[1]) & filter == FALSE,]

comb_data = rbind(data1, data2)

 ggplot(comb_data, aes(x = Mean, fill = Plasmid)) +
   geom_histogram(data = data2,alpha = 0.1, bins = 500, position = "identity", color = "black")+
  geom_histogram(data = data1,alpha = 0.9, bins = 500, position = "identity")+
  facet_wrap(.~Experiment, scale="free_x")+
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Area VS IntDen - non & colocalised population', subtitle = "25 Top2\u03b1 - 25-100nM MYC 250 pFLIP-FUSE - supercoiled - w/o ATP", caption = "1 Replicates")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  scale_fill_manual(
   name = "Channel", values = c("#5982e2", "#e55151", "#225500"),
    labels = unique(channel))
  ylim(0,.5)


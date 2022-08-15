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
import_csv("Data/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC")
import_csv("Data/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC")
import_csv("Data/MYC/2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC")
rm()


var = setdiff(ls(), lsf.str())

plasmid=c("MYC/Top2a",
          "MYC/YOYO1",
          "Top2a/MYC",
          "Top2a/YOYO1",
          "YOYO1/MYC",
          "YOYO1/Top2a",
          "MYC/Top2a",
          "MYC/YOYO1",
          "Top2a/MYC",
          "Top2a/YOYO1",
          "YOYO1/MYC",
          "YOYO1/Top2a",
          "MYC/Top2a",
          "MYC/YOYO1",
          "Top2a/MYC",
          "Top2a/YOYO1",
          "YOYO1/MYC",
          "YOYO1/Top2a")

rep=c("25nM MYC",
      "25nM MYC",
      "25nM MYC",
      "25nM MYC",
      "25nM MYC",
      "25nM MYC",
      "50nM MYC",
      "50nM MYC",
      "50nM MYC",
      "50nM MYC",
      "50nM MYC",
      "50nM MYC",
      "75nM MYC",
      "75nM MYC",
      "75nM MYC",
      "75nM MYC",
      "75nM MYC",
      "75nM MYC")

temp.data = data.frame()
for (i in 1:length(var)){
    data = data.frame(get(paste0(var[i])),Experiment = paste(rep[i]), Plasmid=paste(plasmid[i]))
    q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
    data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
    #data = data[data$Area>=q[2] & data$Circ.>0.5,] # 95th percentile only
    temp.data = rbind(temp.data, data)
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
### Area distribution with median
#temp[temp$Coloc == TRUE & temp$Plasmid==c("pFLIP-FUSE-supercoiled","pFLIP-supercoiled"),]
tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 4/","box_plot_area_colocpop_MYC_95th.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(temp_all_coloc, aes(y = Area, x = Experiment, fill = Experiment)) +
  geom_boxplot(outlier.alpha = 0.1, width=0.5, position = position_dodge(0.5))+
  facet_wrap(.~Plasmid, scale="free_x")+
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Particle area - colocalised population', subtitle = "25nM Top2\u03b1 - 25-75nM MYC - 250nM pFLIP-FUSE-supercoiled - w/o ATP", caption = "1 Replicate - 95th percentile only")+
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  xlab("Particle area distribution") +
  ylab("\u03bcm^2")+
  ylim(0,10)
  scale_x_discrete(breaks=unique(rep),labels=xlabs)
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





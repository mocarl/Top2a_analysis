
### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


# Variables created below are dependent on variables created in "box_plot" script
# Until this become seslfcontained...
## Calculate relative coloc from particle counts
temp.var = var[c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE)]
temp.plasmid = channel[c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE)]
positive = rep(c("MYC postive", "Top2\u03b1 postive"),6)
#temp.rep = rep[c(TRUE, TRUE)]
temp.rep = condition[c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE)]
#Change order
temp.rep = factor(temp.rep, levels = c("100nM MYC",
                                       "25nM Top2\u03b1",
                                       "25nM Top2\u03b1 \n25nM MYC",
                                       "25nM Top2\u03b1 \n50nM MYC",
                                       "25nM Top2\u03b1 \n75nM MYC",
                                       "25nM Top2\u03b1 \n100nM MYC"))
coloc_stats = data.frame()
for (i in 1:length(temp.var)) {
  data = get(temp.var[i])
  q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
  data = data[data$Area>q[2] & data$Circ.>0.5,] # 95th percentile only
  result = sum(data$Coloc==TRUE)/length(data$Coloc)*100
  coloc_stats = rbind(coloc_stats, data.frame(Experiment=temp.rep[i], Category= positive[i],Coloc.Per = result))
}

##
coloc_stats = data.frame()
for (i in 1:length(condition)) {
  data = temp.data[temp.data$Experiment == condition[i] & temp.data$Plasmid == channel[i],]
  #q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
  #data = data[data$Area>q[2] & data$Circ.>0.5,] # 95th percentile only
  for (k in c("YOYO1_coloc","Top2a_coloc", "MYC_coloc")) {
    result = sum(data[k], na.rm = TRUE)/dim(data[k])[1]*100
    coloc_stats = rbind(coloc_stats, data.frame(Experiment=condition[i] ,Coloc = result, Plasmid = channel[i]))
  }

  #coloc_stats = rbind(coloc_stats, data.frame(Experiment=unique(condition)[i] ,eval(parse(text=k)) = result))
}

c("YOYO1_coloc", "YOYO1_index","Top2a_coloc", "Top2a_index", "MYC_coloc", "MYC_index")
# Find double positive DNA droplets

for (i in seq(1,length(temp.var),2)) {
  data1 = get(temp.var[i])
  q1 = quantile(data1$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data1 = data1[data1$Area<q1[2] & data1$Area>q1[1] & data1$Circ.>0.5,] # Remove 5th and 95th percentile
  data1 = data1[data1$Area>q1[2] & data1$Circ.>0.5,] # 95th percentile only
  data2 = get(temp.var[i+1])
  q2 = quantile(data2$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  data2 = data2[data2$Area>q2[2] & data2$Circ.>0.5,] # 95th percentile only
  #data2 = data2[data2$Area<q2[2] & data2$Area>q2[1] & data2$Circ.>0.5,] # Remove 5th and 95th percentile
  result = length(intersect(which(data1$Coloc == TRUE), which(data2$Coloc == TRUE)))/length(data1$Coloc)*100
  coloc_stats = rbind(coloc_stats, data.frame(Experiment=temp.rep[i], Category= "Top2\u03b1 & MYC positive",Coloc.Per = result))
  coloc_stats = rbind(coloc_stats, data.frame(Experiment=temp.rep[i+1], Category= "Top2\u03b1 & MYC positive",Coloc.Per = result))
}

### Relative intensity
intensity_stats = data.frame()
for (i in 1:length(temp.var)) {
  data = get(temp.var[i])
  q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
  #data = data[data$Area>q[2] & data$Circ.>0.5,] # 95th percentile only
  result = sum(data[data$Coloc == TRUE,"RawIntDen"])/sum( data$RawIntDen)*100
  intensity_stats = rbind(intensity_stats, data.frame(Experiment=temp.rep[i], Category= positive[i],Coloc.Per = result))
}
for (i in seq(1,length(temp.var),2)) {
  data1 = get(temp.var[i])
  q1 = quantile(data1$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  data1 = data1[data1$Area<q1[2] & data1$Area>q1[1] & data1$Circ.>0.5,] # Remove 5th and 95th percentile
  #data1 = data1[data1$Area>q1[2] & data1$Circ.>0.5,] # 95th percentile only
  data2 = get(temp.var[i+1])
  q2 = quantile(data2$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data2 = data2[data2$Area>q2[2] & data2$Circ.>0.5,] # 95th percentile only
  data2 = data2[data2$Area<q2[2] & data2$Area>q2[1] & data2$Circ.>0.5,] # Remove 5th and 95th percentile
  result = sum(data1[intersect(which(data1$Coloc == TRUE), which(data2$Coloc == TRUE)),"RawIntDen"])/sum( data1$RawIntDen)*100 
  intensity_stats = rbind(intensity_stats, data.frame(Experiment=temp.rep[i], Category= "Top2\u03b1 & MYC positive",Coloc.Per = result))
  intensity_stats = rbind(intensity_stats, data.frame(Experiment=temp.rep[i+1], Category= "Top2\u03b1 & MYC positive",Coloc.Per = result))
  result = sum(data1[intersect(which(data1$Coloc == FALSE), which(data2$Coloc == FALSE)),"RawIntDen"])/sum( data1$RawIntDen)*100 
  intensity_stats = rbind(intensity_stats, data.frame(Experiment=temp.rep[i], Category= "Top2\u03b1 & MYC negative",Coloc.Per = result))
  intensity_stats = rbind(intensity_stats, data.frame(Experiment=temp.rep[i+1], Category= "Top2\u03b1 & MYC negative",Coloc.Per = result))
  }
data1 = get(temp.var[3])
q1 = quantile(data1$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
data1 = data1[data1$Area<q1[2] & data1$Area>q1[1] & data1$Circ.>0.5,] # Remove 5th and 95th percentile
#data1 = data1[data1$Area>q1[2] & data1$Circ.>0.5,] # 95th percentile only
intensity_stats[17,"Coloc.Per"] = sum(data1[which(data1$Coloc == FALSE),"RawIntDen"])/sum( data1$RawIntDen)*100 

data1 = get(temp.var[4])
q1 = quantile(data1$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
data1 = data1[data1$Area<q1[2] & data1$Area>q1[1] & data1$Circ.>0.5,] # Remove 5th and 95th percentile
#data1 = data1[data1$Area>q1[2] & data1$Circ.>0.5,] # 95th percentile only
intensity_stats[18,"Coloc.Per"] = sum(data1[which(data1$Coloc == FALSE),"RawIntDen"])/sum( data1$RawIntDen)*100 





### Plot section

tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 4/MYC/","box_relative_coloc_MYConly_95th.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
 ggplot(coloc_stats, aes(x=Experiment, y=Coloc.Per, fill=Category, label = Category)) +
  geom_boxplot(width= 0.5, position = position_dodge(0.1)) +
   #geom_jitter(width = 0.2, color = "grey", alpha = 0.5)+
   #geom_text(check_overlap = TRUE,position=position_jitter(width=0.15))+
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Relative colocalisation of & YOYO-1 & MYC', subtitle = "25-100nM MYC - 250nM pFLIP-FUSE-supercoiled - w/o ATP", caption = "1 Replicate - 95th percentile only")+
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  ylim(0,100)+
  xlab("") +
  ylab("%")
dev.off()

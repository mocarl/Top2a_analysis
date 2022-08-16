
### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


# Variables created below are dependent on variables created in "box_plot" script
# Until this become seslfcontained...
## Calculate relative coloc from particle counts
temp.var = var[c(FALSE, TRUE, FALSE, FALSE, TRUE, FALSE)]
temp.plasmid = plasmid[c(FALSE, TRUE, FALSE, FALSE, TRUE, FALSE)]
#temp.rep = rep[c(TRUE, TRUE)]
temp.rep = rep[c(FALSE, TRUE, FALSE, FALSE, TRUE, FALSE)]
coloc_stats = data.frame()
for (i in 1:length(temp.var)) {
  data = get(temp.var[i])
  q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
  data = data[data$Area>q[2] & data$Circ.>0.5,] # 95th percentile only
  result = sum(data$Coloc==TRUE)/length(data$Coloc)*100
  coloc_stats = rbind(coloc_stats, data.frame(Experiment=temp.rep[i], Plasmid= temp.plasmid[i],Coloc.Per = result))
}

tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Figure 4/MYC/","box_relative_coloc_MYConly_95th.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
 ggplot(coloc_stats, aes(x=Plasmid, y=Coloc.Per, fill=Plasmid, label = temp.rep)) +
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

### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


# Variables created below are dependent on variables created in "box_plot" script
# Until this become seslfcontained...
## Calculate relative coloc from particle counts
temp.var = var[c(TRUE, TRUE)]
temp.plasmid = plasmid[c(TRUE, TRUE)]
#temp.rep = rep[c(TRUE, TRUE)]
temp.rep = ylab
coloc_stats = data.frame()
for (i in 1:length(temp.var)) {
  result = sum(get(temp.var[i])$Coloc==TRUE)/length(get(temp.var[i])$Coloc)*100
  coloc_stats = rbind(coloc_stats, data.frame(Experiment=temp.rep[i], Plasmid= temp.plasmid[i],Coloc.Per = result))
}

tiff(file=paste("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Figures/Supp 1/","box_relative_coloc.tiff"), width = 10, height = 10, units = "in", res = 300, pointsize = 7)
ggplot(coloc_stats, aes(x=Plasmid, y=Coloc.Per, fill=Experiment)) +
  geom_boxplot() +
  scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  labs(title = 'Relative colocalisation of Top2\u03b1 & YOYO-1', subtitle = "10nM Top2\u03b1 - 250nM pFLIP/pFLIP-FUSE - w/o ATP", caption = "3 Replicates")+
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
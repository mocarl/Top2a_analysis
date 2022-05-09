### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se

setdiff(ls(), lsf.str())

temp.data = rbind(get("2022-05-04-sc pFLIP-FUSE + 10 nM TOP2A no ATP_Top2a_results_coloc_pop"),get("2022-05-04-sc pFLIP-FUSE + 10 nM TOP2A no ATP_YOYO1_results_coloc_pop"))
## Generate ridlgeplot
ggplot(temp.data, aes(x = Area, y = Coloc, scale=1.5)) +
  stat_density_ridges(quantile_lines = TRUE, quantiles = 2, rel_min_height = 0.005)
  labs(title = 'Particle area distribution', subtitle = paste0(title)) 
  theme(
    legend.position="right",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = -2, face="bold", size = 10)
  )
  xlab("Density with median") +
  ylab(expression(paste("Concentration of TOP2",alpha)))+
  xlim(-1,22)+
  scale_y_discrete(breaks=sub_name,labels=c("1nM","","2,5nM","","5nM","","10nM","","15nM","","25nM",""))+
  scale_fill_manual(
    name = "Channel", values = c("#E1BE6A", "#40B0A6"),
    labels = c(paste0(C0),paste(C1))
  )

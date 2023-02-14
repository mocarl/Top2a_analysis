
## Generates histogram of max # fluors detected per particle
## Author: Carl Möller mocarl@chalmers.se

myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")))
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(0.5, 2))

  nr.bins = max(fluors_full[,"X0"])
ggplot(fluors_full, aes(x = X0, fill = ..count..)) +
    geom_histogram(aes(y=..count..),alpha = 0.9, bins = nr.bins, position = "identity", show.legend = FALSE)+
  annotate(geom="text", x=30, y=60, label="N = 264",
           color="red")+
    #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  scale_fill_gradient(low = "blue3", high = "red", )+
  labs(title = 'Fluorphores detected in Top2\u03b1 condensates', subtitle = "25mM Top2\u03b1 + 250nM pFLIP_FUSE_sc", caption = expression("2.36 kW/cm"^2 ~"laser 50ms exposure over 500-1000 frames"))+
    theme(
      legend.position="right",
      panel.spacing.x = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
    theme_minimal()+
    ylab("Count")+
    xlab("Number of flurophores")



svg(filename=paste(output_path,figure_title,"_fluorophore_hist.svg", sep = ""), width = 10, height = 10, pointsize = 12, bg="transparent")
dev.off()

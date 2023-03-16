
## Generates histogram of max # fluors detected per particle
## Author: Carl Möller mocarl@chalmers.se

myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")))
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(0.5, 2))
nr= dim(fluors_full)[1]
  nr.bins = max(fluors_full[,"X0"])
ggplot(fluors_full, aes(x = X0, fill = ..count..)) +
    geom_histogram(aes(y=..density..),alpha = 0.9, bins = 40, position = "identity", show.legend = FALSE)+
  annotate(geom="text", x=40, y=0.1, label=paste0("N = ",nr),
           color="red")+
    #scale_fill_viridis(alpha=0.5, discrete = TRUE)+
  scale_fill_gradient(low = "blue3", high = "red", )+
  labs(title = 'Fluorophores detected in Top2\u03b1 condensates', subtitle = "25nM Top2\u03b1", caption = expression("2.36 kW/cm"^2 ~"laser 50ms exposure over 500-1000 frames"))+
    theme(
      legend.position="right",
      panel.spacing.x = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
    theme_minimal()+
    ylab("Relative count")+
    xlab("Number of fluorophores")



svg(filename=paste(output_path,figure_title,"_fluorophore_hist.svg", sep = ""), width = 10, height = 10, pointsize = 12, bg="transparent")
dev.off()

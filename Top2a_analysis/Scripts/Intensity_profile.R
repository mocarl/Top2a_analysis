### Intensity profile

data = read_csv("/Users/mocarl/Documents/CarlMöller_Phd/Projects/TOP2A/Paper_MOCK/Main/Figure 2/snap6.csv")
data = as.data.frame(data)
data[data$Channel=="DNA","GrayValue"] = data[data$Channel=="DNA","GrayValue"]/rep(max(data[data$Channel=="DNA","GrayValue"]),length(data[data$Channel=="DNA","GrayValue"]))
data[data$Channel=="Top2a","GrayValue"] = data[data$Channel=="Top2a","GrayValue"]/rep(max(data[data$Channel=="Top2a","GrayValue"]),length(data[data$Channel=="Top2a","GrayValue"]))
data[data$Channel=="MYC","GrayValue"] = data[data$Channel=="MYC","GrayValue"]/rep(max(data[data$Channel=="MYC","GrayValue"]),length(data[data$Channel=="MYC","GrayValue"]))

ggplot(data, aes(x=Distance, y=GrayValue, group=Channel))+
  geom_line(aes(color=Channel))+
  labs(title = 'Intensity profile across inset', subtitle = "25nM Top2\u03b1 - 250nM pFLIP-FUSE - supercoiled - w/o ATP", caption = "")+
  theme(
    legend.position="right",
    panel.spacing.x = unit(0, "lines"),
    strip.text.x = element_text(size = 8),
    axis.text.y = element_text(vjust = 0, face="bold", size = 10))+
  theme_minimal()+
  scale_color_manual(name = "Channel", values = c("#4caf50","#e55151","#e6b400"),labels = unique(data$Channel))+
  #xlab("Particle area distribution") +
  ylab("Normalised intensity")

svg(file=paste("Output/top_down/","intprofile_inset_MYC_fig2_2_20230615.svg",sep = ""), width = 10, height = 10, pointsize = 7)
dev.off()

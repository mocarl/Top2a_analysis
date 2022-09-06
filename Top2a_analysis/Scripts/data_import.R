### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")

### Import and arrange data into one dataframe
import_xlsx("Data/YOYOcontrol", c("Top2a_results"))
import_csv("Data/V3/MYC")

## Arrange data into single data frame
var = setdiff(ls(), lsf.str())

names(get(var[1]))[names(get(var[1])) == "Coloc"] = "Top2a.coloc"

names(get(var[1]))[names(get(var[1])) == 'Coloc.index'] <- 'Top2a.coloc.index'
get(var[1])["Coloc"] 
get(var[1]) = cbind(get(var[1]), get(var[2])[,34:35])


#Define vectors with categories that will be added as the data is concatenated 
# into one large frame. This will decide how the subsequent plots will be organised
# Make note that the vector has to have length(var) elements
plasmid=c("pFLIP-FUSE relaxed",
          "pFLIP-FUSE relaxed",
          "pFLIP-FUSE supercoiled",
          "pFLIP-FUSE supercoiled",
          "pFLIP relaxed",
          "pFLIP relaxed",
          "pFLIP-FUSE relaxed",
          "pFLIP-FUSE relaxed",
          "pFLIP supercoiled",
          "pFLIP supercoiled",
          "pFLIP-FUSE supercoiled",
          "pFLIP-FUSE supercoiled",
          "pFLIP relaxed",
          "pFLIP relaxed",
          "pFLIP-FUSE relaxed",
          "pFLIP-FUSE relaxed",
          "pFLIP supercoiled",
          "pFLIP supercoiled",
          "pFLIP-FUSE supercoiled",
          "pFLIP-FUSE supercoiled",
          "pFLIP relaxed",
          "pFLIP relaxed",
          "pFLIP supercoiled",
          "pFLIP supercoiled")

rep=c("FFRT1","FFRY1",
      "FFST1","FFSY1",
      "FRT2","FRY2",
      "FFRT2","FFRY2",
      "FST2","FSY2",
      "FFST2","FFSY2",
      "FRT3","FRY3",
      "FFRT3","FFRY3",
      "FST3","FSY3",
      "FFST3","FFSY3",
      "FRT1","FRY1",
      "FST1","FSY1")

condition = c(rep(c("25nM Top2\u03b1 \n100nM MYC"),6),
              rep(c("100nM MYC"),6),
              rep(c("25nM Top2\u03b1"),6),
              rep(c("25nM Top2\u03b1 \n25nM MYC"),6),
              rep(c("25nM Top2\u03b1 \n50nM MYC"),6),
              rep(c("25nM Top2\u03b1 \n75nM MYC"),6))

channel = rep(c("MYC",
                "MYC",
                "Top2\u03b1",
                "Top2\u03b1",
                "YOYO1",
                "YOYO1"),6)

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

#Concatenate all the imported data in var into one large data.frame
temp.data = data.frame()
for (i in 1:length(var)){
  data = data.frame(get(paste0(var[i])),Experiment = paste(condition[i]), Plasmid=paste(channel[i]))
  q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
  #data = data[data$Area>=q[2] & data$Circ.>0.5,] # 95th percentile only
  temp.data = rbind(temp.data, data)
}


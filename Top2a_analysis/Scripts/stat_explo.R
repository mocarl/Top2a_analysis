### Statistical analysis of Top2a deposited on funcitonalised glass slides
## This script performs PLS on a given dataset
## Author: Carl Möller mocarl@chalmers.se

# Import data
import_xlsx("Data",c("pFLIP","results","0nM"))

var = setdiff(ls(), lsf.str())

plasmid=c( "pFLIP-FUSE-relaxed CONTROL",
           "pFLIP-FUSE-supercoiled CONTROL",
           "pFLIP-FUSE-relaxed deltaCTD 10nM",
           "pFLIP-FUSE-relaxed Top2a 10nM",
           "pFLIP-FUSE-supercoiled deltaCTD 10nM",
           "pFLIP-FUSE-supercoiled Top2a 10nM")
temp.data = data.frame()
for (i in 1:length(var)){
  temp.data = rbind(temp.data, data.frame(get(paste0(var[i])),Experiment = paste0(var[i]), Plasmid=paste(plasmid[i])))
}
variables = c("Area", "Mean", "StdDev","Min","Max","Perim.","Major","Minor","Angle","Circ.","Feret","IndDen","Median","Skew","RawIntDen","Round","Solidity","FeretX","FeretY","FeretAngle","MinFeret","AR","Plasmid")
temp = na.omit(temp.data[,names(temp.data) %in% variables])
pca_res <- prcomp(temp[,-22], scale. = TRUE)

autoplot(pca_res, data = temp, colour = "Plasmid",loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)
summary(pca_res)

pls_res <- plsr(octane ~ NIR, ncomp = 10, data = gasTrain, validation = "LOO")
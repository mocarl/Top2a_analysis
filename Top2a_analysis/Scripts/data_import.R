### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")

### Import and arrange data into one dataframe
import_xlsx("Data/YOYOcontrol", c("Top2a_results"))
import_csv("Data/V4")
import_csv("Data/V3/MYC", c("img_stat"))
## Arrange data into single data frame
var = setdiff(ls(), lsf.str())


names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_MYC_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[1], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_MYC_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[1], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_MYC_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[2], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_MYC_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[2], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_Top2a_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[3], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_Top2a_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[3], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_Top2a_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[4], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_Top2a_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[4], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_YOYO1_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[5], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_YOYO1_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[5], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_YOYO1_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[6], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP_FUSE_+_25_nM_TOP2A_+_100_nM_MYC_V3_YOYO1_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[6], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_MYC_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[7], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_MYC_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[7], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_MYC_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[8], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_MYC_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[8], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_Top2a_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[9], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_Top2a_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[9], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_Top2a_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[10], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_Top2a_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[10], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_YOYO1_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[11], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_YOYO1_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[11], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_YOYO1_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[12], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_100_nM_MYC_V3_YOYO1_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[12], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_MYC_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[13], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_MYC_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[13], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_MYC_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[14], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_MYC_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[14], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_Top2a_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[15], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_Top2a_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[15], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_Top2a_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[16], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_Top2a_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[16], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_YOYO1_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[17], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_YOYO1_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[17], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_YOYO1_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[18], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-14-sc_pFLIP-FUSE_+_25_nM_TOP2A_V3_YOYO1_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[18], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_MYC_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[19], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_MYC_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[19], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_MYC_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[20], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_MYC_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[20], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_Top2a_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[21], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_Top2a_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[21], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_Top2a_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[22], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_Top2a_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[22], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_YOYO1_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[23], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_YOYO1_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[23], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_YOYO1_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[24], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_25nM-MYC_V3_YOYO1_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[24], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_MYC_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[25], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_MYC_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[25], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_MYC_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[26], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_MYC_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[26], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_Top2a_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[27], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_Top2a_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[27], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_Top2a_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[28], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_Top2a_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[28], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_YOYO1_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[29], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_YOYO1_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[29], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_YOYO1_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[30], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_50nM-MYC_V3_YOYO1_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[30], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_MYC_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[31], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_MYC_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[31], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_MYC_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[32], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_MYC_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[32], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_Top2a_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[33], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_Top2a_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[33], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_Top2a_results_YOYO1_coloc_pop`)[34] = paste0(tail(str_split(var[34], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_Top2a_results_YOYO1_coloc_pop`)[35] = paste0(tail(str_split(var[34], "_")[[1]], n=3)[[1]],"_index")

names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_YOYO1_results_MYC_coloc_pop`)[34] = paste0(tail(str_split(var[35], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_YOYO1_results_MYC_coloc_pop`)[35] = paste0(tail(str_split(var[35], "_")[[1]], n=3)[[1]],"_index")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_YOYO1_results_Top2a_coloc_pop`)[34] = paste0(tail(str_split(var[36], "_")[[1]], n=3)[[1]],"_coloc")
names(`2022-06-28_sc-pFLIP-FUSE_25nM-TOP2A_75nM-MYC_V3_YOYO1_results_Top2a_coloc_pop`)[35] = paste0(tail(str_split(var[36], "_")[[1]], n=3)[[1]],"_index")

for (i in seq(1,length(var),2)){
  df = data.frame(temp1 = rep(NA,dim(get(var[i]))[1]), temp2 = rep(NA,dim(get(var[i]))[1]))
  names(df)[1] = paste0(tail(str_split(var[i], c("_"))[[1]], n=5)[[1]],"_coloc")
  names(df)[2] = paste0(tail(str_split(var[i], c("_"))[[1]], n=5)[[1]],"_index")
  assign(var[i],cbind(get(var[i]), get(var[i+1])[,34:35]), df)
  rm(list = var[i+1])
}
var = var[c(TRUE, FALSE)]


for (i in 1:length(var)){
  df = data.frame(temp1 = rep(NA,dim(get(var[i]))[1]), temp2 = rep(NA,dim(get(var[i]))[1]))
  names(df)[1] = paste0(tail(str_split(var[i], c("_"))[[1]], n=5)[[1]],"_coloc")
  names(df)[2] = paste0(tail(str_split(var[i], c("_"))[[1]], n=5)[[1]],"_index")
  assign(var[i],cbind(get(var[i]), df))
}

for (i in 1:length(var)){
  assign(var[i],cbind(get(var[i])[,c(1:(dim(get(var[i]))[2]-6))], get(var[i])[,c("YOYO1_coloc", "YOYO1_index","Top2a_coloc", "Top2a_index", "MYC_coloc", "MYC_index")]))
}


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

rep=c(1,1,2,2,rep(c(1),6),rep(c(2),6),1,1,2,2)

condition = c(rep(c("100nM MYC"),4),
              rep(c("25nM Top2\u03b1 \n100nM MYC"),12),
              rep(c("25nM Top2\u03b1"),4))

channel = c(rep(c("MYC","YOYO1"),2),
            rep(c("MYC","MYC","Top2\u03b1","Top2\u03b1","YOYO1","YOYO1"),2),
            rep(c("Top2\u03b1","YOYO1"),2))

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
  data = data.frame(get(paste0(var[i])),Experiment = paste(condition[i]), Channel=paste(channel[i]), Repeat = paste(rep[i]))
  names(data)[36] = unlist(str_split(names(data[36]), "[.]"))[-1]
  names(data)[37] = paste(unlist(str_split(names(data[37]), "[.]"))[-1],collapse  = "_")
  #q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
  #data = data[data$Area>=q[2] & data$Circ.>0.5,] # 95th percentile only
  temp.data = rbind(temp.data, data)
}

## Import img stat and add channel column for grouping
temp.data.imgstat = data.frame()
for (i in 1:length(var_csv)){
  data = data.frame(get(paste0(var_csv[i])), Plasmid = unique(condition)[i])
  temp.data.imgstat = rbind(temp.data.imgstat, data)
}

temp.data.imgstat[grep("C1",temp.data.imgstat$Label),"Channel"] = "C1"
temp.data.imgstat[grep("C2",temp.data.imgstat$Label),"Channel"] = "C2"
temp.data.imgstat[grep("C3",temp.data.imgstat$Label),"Channel"] = "C3"

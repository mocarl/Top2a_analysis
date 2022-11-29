### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Generates graphs from colocalisation statistics
## Author: Carl Möller mocarl@chalmers.se


## Clear all variables
rm(list = ls())
#Run dependencies
source("Scripts/dependencies.R")

### Import and arrange data into one dataframe
import_xlsx("Data/V4/20221027", c("results"))
import_xlsx("Data/top_down/Rep_1", c("results"))
import_xlsx("Data/V4/Rep_2", c("results"))
import_csv("Data/V4/Rep_1")
import_csv("Data/V4/Rep_2", c("img_stat"))
import_csv("Data/top_down/Rep_2", c("img_stat"))
## Arrange data into single data frame
var = setdiff(ls(), lsf.str())


## Add prefixes to data
add_prefix_varname(var_csv, "Rep_2")

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


#### Add channel info to coloc column
for (i in var) {
  df = get(i)
  
  df[which(df[,36]),36] = unlist(str_split(names(df[36]), "[.]"))[-2]
  assign(i ,df)
}

## Concatenate vars with duplicated data but different coloc info 
# Find vars with same dims
var[which(tabulate(match(unlist(lapply(var,function(x) dim(get(x))[1])),unique(unlist(lapply(var, function(x) dim(get(x))[1])))))>1)]

temp.var = var[duplicated(unlist(lapply(var,function(x) dim(get(x))[1]))) | duplicated(unlist(lapply(var,function(x) dim(get(x))[1])), fromLast = TRUE)]
for (i in seq(1,length(temp.var),2)) {
  df = get(temp.var[i])
  df[,36] = paste(get(temp.var[i])[,36] , get(temp.var[i+1])[,36], sep = "+")
  assign(paste(temp.var[i]) ,df)
}

var = var[!var %in% temp.var[c(FALSE,TRUE)]]

for (i in unique(temp.data$coloc)) {
  if(str_detect(i, "(FALSE[+])|([+]FALSE)")){
    if(sum(grepl("(FALSE)",str_split(i ,"[+]")[[1]]))>1){
      temp.data[temp.data$coloc == i,"coloc"] = "FALSE"
    } else {
      temp.data[temp.data$coloc == i,"coloc"] = str_split(i ,"[+]")[[1]][!grepl("(FALSE)",str_split(i ,"[+]")[[1]])]
    }
  } else {
    next
  }
#  temp.data$coloc == i
}

temp.data[temp.data$coloc == "FALSE","Coloc"] = FALSE
temp.data[temp.data$coloc != "FALSE","Coloc"] = TRUE
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

batch_rep=c(rep(c(rep(1,2),
            rep(2,2),
            rep(1,3),
            rep(2,3),
            rep(1,2),
            rep(2,2)),2),
            c(1,2),
            rep(1,2),
            rep(2,2),
            c(1,2),
            rep(1,2),
            rep(2,2),
            rep(1,3),
            rep(2,3)
            )

tech_rep=c(rep(c(1),14),
           rep(c(2),14),
           rep(c(1),2),
           rep(c(3),4),
           rep(c(2),2),
           rep(c(3),10)
           )

condition = c(rep(c(rep(c("100nM MYC"),4),
                  rep(c("25nM Top2\u03b1 \n100nM MYC"),6),
                  rep(c("25nM Top2\u03b1"),4)),2),
              rep(c("250nM pFLIP-FUSE-sc"),2),
              rep(c(rep(c("100nM MYC"),4),
                    rep(c("250nM pFLIP-FUSE-sc"),2),
                    rep(c("25nM Top2\u03b1"),4),
                    rep(c("25nM Top2\u03b1 \n100nM MYC"),6)
                    )))

channel = c(rep(c(rep(c("MYC","YOYO1"),2),
                rep(c("MYC","Top2\u03b1", "YOYO1"),2),
                rep(c("Top2\u03b1","YOYO1"),2)),2),
                rep(c("YOYO1"),2),
                rep(c("MYC","YOYO1"),2),
                rep(c("YOYO1"),2),
                rep(c("MYC","Top2\u03b1", "YOYO1"),2),
                rep(c("Top2\u03b1","YOYO1"),2)
            )

 



#Concatenate all the imported data in var into one large data.frame
temp.temp.data = data.frame()
for (i in 1:length(var)){
  data = data.frame(get(paste0(var[i])),Experiment = paste(condition[i]), Channel=paste(channel[i]), BatchRepeat = paste(batch_rep[i]), TechRepeat = paste(tech_rep[i]))
  #names(data)[36] = unlist(str_split(names(data[36]), "[.]"))[-1] #Change column naming for compatability
  #names(data)[37] = paste(unlist(str_split(names(data[37]), "[.]"))[-1],collapse  = "_") #Change column naming for compatability
  #q = quantile(data$Area,c(0.05,0.95)) # Calculate 5th and 95th percentile
  #data = data[data$Area<q[2] & data$Area>q[1] & data$Circ.>0.5,] # Remove 5th and 95th percentile
  #data = data[data$Area>=q[2] & data$Circ.>0.5,] # 95th percentile only
  temp.temp.data = rbind(temp.temp.data, data)
}

## Import img stat and add channel column for grouping
var_img_stat = setdiff(ls(), lsf.str())
var_img_stat = var_img_stat[str_detect(var_img_stat, "img_stat")]

batch_rep = rep(c(1,2),length(var_img_stat)/2)
tech_rep = c(rep(1,length(var_img_stat)/2),rep(2,length(var_img_stat)/2))
condition = rep(c(rep(c("100nM MYC"),2),
                  rep(c("25nM Top2\u03b1 \n100nM MYC"),2),
                  rep(c("25nM Top2\u03b1"),2)),2)
  
temp.data.imgstat = data.frame()
for (i in 1:length(var_img_stat)){
  data = data.frame(get(paste0(var_img_stat[i])), Experiment = paste(condition[i]), BatchRepeat = paste(batch_rep[i]), TechRepeat = paste(tech_rep[i]))
  temp.data.imgstat = rbind(temp.data.imgstat, data)
}



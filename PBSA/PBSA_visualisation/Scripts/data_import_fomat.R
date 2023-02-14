## Import data and format it for further analysis

import_csv("Data/Top2a_25nM_BSAslides_PBSA","result")

output_path = "Output/"
figure_title = "Top2a"

#Concatenate all the imported data in var into one large data.frame
# Find longest data set
#NA pad for concatenation
len = c()
for (i in var_csv) {
  len = c(len , length(get(i)))
  max.len = max(len)
}



temp.data = data.frame()
for (i in 1:length(var_csv)){
  if(length(get(var_csv[i]))<max.len){
    padNAcolumns(var_csv[i], max.len)
  }
  data = data.frame(get(paste0(var_csv[i])))
  #data = data[data$flag == 1 & data$type == "fluors_full","X0"]
  temp.data = rbind(temp.data, data)
}


## Subset fluors_full and flag == 1

fluors_full = temp.data[temp.data$type == "fluors_full" & temp.data$flag == 1,]

## Visualises PBSA trace data

data = `Experiment-342_difference_result`
temp.data = t(data[data$flag == 1 & data$type == "trace",49:1048])


# create plot
ggplot(temp.data, aes(x=seq(1:1000))) +
  geom_line()+
  # check.overlap avoids label overlapping
  scale_x_discrete(guide = guide_axis(check.overlap = TRUE)

t = 200
 plot(seq(1:t),temp.data[1:t,22], type = "l")
 
 n  = 250
index = rep(1:n, (dim(temp.data)[1]/n))
index <- index[order(index)]

temp = aggregate(x=temp.data, by = list(index), FUN=mean)


plot(seq(1:200), temp[1:200,3], type = "l")

temp.data1 = t(data[data$flag == 1 & data$type == "trace",49:1048])
temp.data2= t(temp.data[temp.data$flag == 1 & temp.data$type == "fluors_full",49])
hist(temp.data$Fluors_full, breaks = max(temp.data$Fluors_full))


### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Script visulises size distribution of Top2a condensates from glass slidess
## Author: Carl Möller mocarl@chalmers.se


### Dependencies
library("plyr")                                     # Load plyr package
library("dplyr")                                    # Load dplyr package
library("readr")                                    # Load readr package
library(ggplot2)
library(ggridges)
library(openxlsx)
library(stringr)
library(gtools)
library(ggplot2)
library(tidyverse)
library(hrbrthemes)
library(viridis)
####

source("Scripts/Functions/import_xlsx.R")


import_xlsx("Data",c("no","ATP","results", "rel"))

title = "pFLIP relaxed without Top2a"
  
    ### Data exploration
    
    his = hist(`pFLIP_rel_0nM_YOYO-1_results`[["Area"]], breaks = 100)
    dens = density(`pFLIP_rel_0nM_YOYO-1_results`[["Area"]])
    plot(his$counts, xlim = c(0,110))
    
    
    temp.data <- data.frame()
    circ.cutoff = 0.5
    ## Generate data vectors based on channels
    search_str <- c('results', C1)
    search_combined <- paste(paste0('(?=.*', search_str, ')'), collapse = '')
    sub_name <- mixedsort(name[str_detect(name, search_combined)])
    
    ## Vector of mean area for C1
    mean_area_C1 = c()
    temp.list <- list()
    for(k in sub_name){
      mean_area_C1=c(mean_area_C1,mean(get(k)$Area[!get(k)$Circ. < circ.cutoff]))
      temp.list[length(temp.list)+1] <- list(get(k)$Area[!get(k)$Circ. < circ.cutoff])
      temp.data <- rbind(temp.data, data.frame(group1 = c(k), group2 = paste0(C1), mean = mean(get(k)$Area[!get(k)$Circ. < circ.cutoff]), sd = sd(get(k)$Area[!get(k)$Circ. < circ.cutoff])))
      #temp.data <- rbind(temp.data, data.frame(group1 = c(k), group2 = c("C1"), sd = sd(get(k)$Area[!get(k)$Circ. < 0.1])))
    }

    search_str <- c('results', C0)
    search_combined <- paste(paste0('(?=.*', search_str, ')'), collapse = '')
    sub_name <- mixedsort(name[str_detect(name, search_combined)])
    ## Vector of mean area for C0
    mean_area_C0 = c()
    temp.list <- list()
    for(k in sub_name){
      mean_area_C0=c(mean_area_C0,mean(get(k)$Area[!get(k)$Circ. < circ.cutoff]))
      temp.list[length(temp.list)+1] <- list(get(k)$Area)
      temp.data <- rbind(temp.data, data.frame(group1 = c(k), group2 = paste0(C0), mean = mean(get(k)$Area[!get(k)$Circ. < circ.cutoff]), sd = sd(get(k)$Area[!get(k)$Circ. < circ.cutoff])))
      #temp.data <- rbind(temp.data, data.frame(group1 = c(k), group2 = c("C0"), sd = sd(get(k)$Area[!get(k)$Circ. < 0.1])))
    }
    
   

    
    ## Reorder data
    search_str <- c('results')
    search_combined <- paste(paste0('(?=.*', search_str, ')'), collapse = '')
    sub_name <- mixedsort(name[str_detect(name, search_combined)])
    temp.data$group1 <- factor(temp.data$group1, levels = sub_name)
   
    ### Bar plot with average area
      
    ggplot(temp.data, aes(x=group1, y=mean)) +           # ggplot2 barplot with mean
      geom_bar(aes(fill=group2),position = position_dodge(),
               stat = "identity") +
       geom_errorbar( aes(x=group1, ymin=mean, ymax=mean+sd), width=0.4, colour="black", alpha=0.9, position = position_dodge(0.9))+
       labs(title=expression(paste("Mean area" ~ (mu~m^{2}))), x=expression(paste("Concentration of TOP2",alpha)), y = expression(paste("Mean area" ~ (mu~m^{2}))), subtitle = paste0(title))+
       theme(axis.text.x = element_text(face="bold", color="#993333", size=10, angle=0, hjust=-0.5))+
       scale_x_discrete(breaks=sub_name,labels=c("XXnM",""))+
       guides(fill = guide_legend(title = "Channel"))+
      scale_fill_manual(values=c("#E1BE6A", "#40B0A6"))
       
#c("1nM","","2,5nM","","5nM","","10nM","","15nM","","25nM",""))
    
    ### Save image
     tiff(file=paste(name[1],"_barplot_avg_area.tiff"), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
     
     dev.off()
     
     
     ### Ridgeline plot for area distribution
     
     ## Generate data vectors based on channels
     temp.data <- data.frame()
     search_str <- c('results', C1)
     search_combined <- paste(paste0('(?=.*', search_str, ')'), collapse = '')
     sub_name <- mixedsort(name[str_detect(name, search_combined)])
     
     ## Vector of mean area for C1
     for(k in sub_name){
       temp.data <- rbind(temp.data, data.frame(group1 = c(k), group2 = paste(C1), area = get(k)$Area[!get(k)$Circ. < circ.cutoff]))
       
     }
  
     search_str <- c('results', C0)
     search_combined <- paste(paste0('(?=.*', search_str, ')'), collapse = '')
     sub_name <- mixedsort(name[str_detect(name, search_combined)])
     ## Vector of mean area for C0
     for(k in sub_name){
       temp.data <- rbind(temp.data, data.frame(group1 = c(k), group2 = paste(C0), area = get(k)$Area[!get(k)$Circ. < circ.cutoff]))
     }
     
     ## Reorder data
     search_str <- c('results')
     search_combined <- paste(paste0('(?=.*', search_str, ')'), collapse = '')
     sub_name <- mixedsort(name[str_detect(name, search_combined)])
     temp.data$group1 <- factor(temp.data$group1, levels = sub_name)
     
    
     ### Box plot
     
     boxplot(temp.data$area ~ temp.data$group1, 
             at = sort(c(seq(1, length(table(temp.data$group1)), by = 2),seq(1, length(table(temp.data$group1)), by = 2)+2/3)),
             main = paste0(title), 
             ylab = expression(paste("Particle area" ~ (mu~m^{2}))), 
             boxwex = 1/2, las=1, range = 1, outline = FALSE,
             col=c("#E1BE6A", "#40B0A6"),
             xlab = expression(paste("Concentration of Top2",alpha)),
             xaxt="n"
     )
     axis(side=1, labels=c("1nM","2,5nM","5nM","10nM","15nM","25nM"), at = seq(1, length(table(temp.data$group1)), by = 2)+1/3, tick = TRUE)
     legend("topleft", c(paste0(C0),paste0(C1)), fill = c("#E1BE6A", "#40B0A6"), border = FALSE, bty = "n" )
     
     tiff(file=paste(title,"_boxlot_area.tiff"), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
     
     dev.off()
     
     ## Generate ridlgeplot
     ggplot(temp.data, aes(x = area, y = group1, fill = group2, scale=1.5)) +
       stat_density_ridges(quantile_lines = TRUE, quantiles = 2, rel_min_height = 0.005)+
       labs(title = 'Particle area distribution', subtitle = paste0(title)) +
       theme(
         legend.position="right",
         panel.spacing = unit(0.1, "lines"),
         strip.text.x = element_text(size = 8),
         axis.text.y = element_text(vjust = -2, face="bold", size = 10)
       )+
       xlab("Density with median") +
       ylab(expression(paste("Concentration of TOP2",alpha)))+
       xlim(-1,22)+
     scale_y_discrete(breaks=sub_name,labels=c("1nM","","2,5nM","","5nM","","10nM","","15nM","","25nM",""))+
     scale_fill_manual(
       name = "Channel", values = c("#E1BE6A", "#40B0A6"),
       labels = c(paste0(C0),paste(C1))
     )
     
### Save as tiff
     
     tiff(file=paste(title,"_ridgeline_area.tiff"), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
     
     dev.off()

     
     
     
     #### Read txt files with coloc data
     ## Read csv 
     temp.csv <- read.csv("/Users/mocarl/Library/CloudStorage/OneDrive-ChalmersUniversityofTechnology/Top2a_project/Data/pFLIP/Relaxed/analysis_withoutATP/pFLIP_relax_coloc.csv", sep =";")
     temp.data <- data.frame()
     conc. = c("0nM","5nM","10nM","25nM","50nM")
     for(k in 1:length(conc.)){
       temp.data <- rbind(temp.data, data.frame(group1 = conc.[k], mean = mean(temp.csv[[k]], na.rm = TRUE), sd = sd(temp.csv[[k]], na.rm = TRUE)))
       
     }
     
     temp.data$group1 <- factor(temp.data$group1, levels = conc.)
     
     ggplot(temp.data, aes(x=group1, y=mean)) +           # ggplot2 barplot with mean
       geom_bar(position = position_dodge(),
                stat = "identity") +
       geom_errorbar( aes(x=group1, ymin=mean, ymax=mean+sd), width=0.4, colour="black", alpha=0.9, position = position_dodge(0.9))+
       labs(title="Avg. Pearson Coefficient", x=expression(paste("Concentration of TOP2",alpha)), y = "Avg. Pearson Coefficient", subtitle = "pFLIP relaxed without ATP")+
       theme(axis.text.x = element_text(face="bold", color="#993333", size=10, angle=0))+
       scale_x_discrete(breaks=conc.,labels=conc.)+
       guides(fill = guide_legend(title = "Channel"))+
       scale_fill_manual(values=c("#E1BE6A", "#40B0A6"))
     
     
     ### Save as tiff
     
     tiff(file=paste("pFLIP_relaxed_pearson_coloc.tiff"), width = 5, height = 5, units = "in", res = 300, pointsize = 7)
     
     dev.off()
     

     
     
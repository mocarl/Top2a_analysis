### Statistical analysis of Top2a deposited on funcitonalised glass slides
## Script contains all dependencies need to run scripts/functions with project
## Author: Carl Möller mocarl@chalmers.se

### Package dependencies
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
library(stringr)
library(plotrix)
library(smacpod)
library(pls)
library(grid)
library(scales)
library(plotly)
library(diptest)
library(LaplacesDemon)
####

### Function depedencies

source("Scripts/Functions/import_xlsx.R")
source("Scripts/Functions/data_consolidation.R")
source("Scripts/Functions/import_csv.R")

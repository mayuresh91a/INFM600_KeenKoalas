##--------------------------------------------------------------------------------------
# This is the working R plot coding file for Saba.

#Set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the Data_Cleaning.R script to perform data importing and setup.
source("INFM600_0101_KeenKoalas_RScript.R")

#Load ggplot2 for plotting. Put inside an if (!require()) condition to install the package if it is not already installed, then run library() to load the package again afterwards to make sure it is installed and loaded successfully.
if (suppressWarnings(!require("ggplot2"))) {
  install.packages("ggplot2")
}
library(ggplot2)

##--------------------------------------------------------------------------------------
#Please write the code for your plot below, along with the interpretation at the end :)

#Plot average concentration of pesticides by state and by grade.

#Avg. Concentration by State:
Avg_Conc_State_Plot <- ggplot(stat_14_states, aes(x=rownames(stat_14_states), y=`Avg Concentration`, fill=stat_14_states$Frequency)) + geom_bar(stat="identity", width=.8) + xlab("States") + ylab("Avg. Conc. (ppm)") + ggtitle("Average Concentration by State") + scale_fill_gradient("Samples \n in State", low="#132B43", high="#56B1F7")

#Avg Concentration by Grade:
Avg_Conc_Grade_Plot <- ggplot(stat_14_grade, aes(x=rownames(stat_14_grade), y=`Avg Concentration`, fill=stat_14_grade$`# of Samples`)) + geom_bar(stat="identity", width=.8) + xlab("Apple Grade") + ylab("Avg. Conc. (ppm)") + ggtitle("Average Concentration by Grade") + scale_fill_gradient("Samples \n in Grade", low="#132B43", high="#56B1F7")

#Plot average number of pesticides detected by state and by grade.

#Avg. # of Pesticides by State:
Avg_No_State_Plot <- ggplot(stat_14_states, aes(x=rownames(stat_14_states), y=`Avg # of Pesticides`, fill=stat_14_states$Frequency)) + geom_bar(stat="identity", width=.8) + xlab("States") + ylab("Avg. Number of Pesticides") + ggtitle("Average Number of Pesticides by State") + scale_fill_gradient("Samples \n in State", low="#132B43", high="#56B1F7")

#Avg. # of Pesticides by Grade:
Avg_No_Grade_Plot <- ggplot(stat_14_grade, aes(x=rownames(stat_14_grade), y=`Avg # of Pesticides`, fill=stat_14_grade$`# of Samples`)) + geom_bar(stat="identity", width=.8) + xlab("Apple Grade") + ylab("Avg. Number of Pesticides") + ggtitle("Average Number of Pesticides by Grade") + scale_fill_gradient("Samples \n in Grade", low="#132B43", high="#56B1F7")

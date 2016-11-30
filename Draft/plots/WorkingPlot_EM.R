##--------------------------------------------------------------------------------------
# This is the working R plot coding file for Eris.

#Set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the Data_Cleaning.R script to perform data importing and setup.
source("INFM600_0101_KeenKoalas_RScript.R")

##--------------------------------------------------------------------------------------

#Load ggplot2 for plotting. Put inside an if (!require()) condition to install the package if it is not already installed, then run library() to load the package again afterwards to make sure it is installed and loaded successfully.
if (suppressWarnings(!require("ggplot2"))) {
  install.packages("ggplot2")
}
library(ggplot2)

#Reorganize and plot average concentration by variety. For readability reasons, the 23 rows (22 varieties + 1 row for "unknown" varieties) of data on pesticide number of average concentration by variety will be restructured to the top 10 most frequent varieties plus a group called "Others" for all other remaining and unknown varieties.
stat_14_varieties_top10 <- stat_14_varieties[c(1:5,7:11),] #create a new subset of the average pesticide numbers and concentration for the top 10 varieties by frequency by storing rows 1-5 and 7-11 (bypassing row 6 which is not an actual variety but sum of all samples with unknown variety).

variety_14_others_Pestcode <- round(weighted.mean(variety_14_avgPestcode[c(6,12:23)],stat_14_varieties$Frequency[c(6,12:23)]),3) #Calculate the combined weighted average pesticide number per sample for the new "Others" group with all lower frequency varieties (including "unknown" varieties), and round to 3 decimal places.

variety_14_others_avgCONCEN <- round(weighted.mean(variety_14_avgCONCEN[c(6,12:23)], variety_14_CountCONCEN[c(6,12:23)]),3) #Calculate the combined weighted average concentration amount for the new "Others" group with all lower frequency varieties (including "unknown" varieties), and round to 3 decimal places.

stat_14_varieties_others <- data.frame(sum(stat_14_varieties$Frequency[c(6,12:23)]), round(sum(stat_14_varieties$Frequency[c(6,12:23)])/sum(stat_14_varieties$Frequency)*100,2), variety_14_others_Pestcode, variety_14_others_avgCONCEN) #combine the sum of low frequency variety samples, percentage these samples make up of the total, and the 2 weighted averages for low frequency varieties from above into a new data frame.

colnames(stat_14_varieties_others) <- c("Frequency", "Percentage", "Avg # of Pesticides","Avg Concentration") #Update the headers for the data frame columns for clarification.
rownames(stat_14_varieties_others) <- c("Others") #Updating the name for the row of data to the new "Others" variety group.
stat_14_varieties_top10 <- rbind(stat_14_varieties_top10, stat_14_varieties_others) #appending the row for "Others" data to the top 10 list for plotting.

ggplot(data=stat_14_varieties_top10, aes(x=factor(rownames(stat_14_varieties_top10), levels=unique(rownames(stat_14_varieties_top10))),y=stat_14_varieties_top10$`Avg # of Pesticides`)) +
  geom_bar(stat="identity")
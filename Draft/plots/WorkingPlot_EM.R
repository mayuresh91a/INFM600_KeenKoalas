##--------------------------------------------------------------------------------------
# This is the working R plot coding file for Eris.

#Set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the "INFM600_0101_KeenKoalas_RScript.R" script to perform data importing, setup, and basic stat preps.
source("INFM600_0101_KeenKoalas_RScript.R")

##--------------------------------------------------------------------------------------

##Load ggplot2 for plotting. Put inside an if (!require()) condition to install the package if it is not already installed, then run library() to load the package again afterwards to make sure it is installed and loaded successfully.
if (suppressWarnings(!require("ggplot2"))) {
  install.packages("ggplot2")
}
library(ggplot2)

#Reorganize and plot average concentration by variety. For readability reasons, the 23 rows (22 varieties + 1 row for "unknown" varieties) of data on pesticide number of average concentration by variety will be restructured to the top 10 most frequent varieties plus a group called "Others" for all other remaining and unknown varieties.
stat_14_varieties_top10 <- stat_14_varieties[c(1:5,7:11),] #Create a new subset of the average pesticide numbers and concentration for the top 10 varieties by frequency by storing rows 1-5 and 7-11 (bypassing row 6 which is not an actual variety but sum of all samples with unknown variety).

variety_14_others_avgPestcode <- round(weighted.mean(variety_14_avgPestcode[c(6,12:23)],stat_14_varieties$Frequency[c(6,12:23)]),3) #Calculate the combined weighted average pesticide number per sample for the new "Others" group with all lower frequency varieties (including "unknown" varieties), and round to 3 decimal places.

variety_14_others_avgCONCEN <- round(weighted.mean(variety_14_avgCONCEN[c(6,12:23)], variety_14_CountCONCEN[c(6,12:23)]),3) #Calculate the combined weighted average concentration amount for the new "Others" group with all lower frequency varieties (including "unknown" varieties), and round to 3 decimal places.

stat_14_varieties_others <- data.frame(sum(stat_14_varieties$Frequency[c(6,12:23)]), round(sum(stat_14_varieties$Frequency[c(6,12:23)])/sum(stat_14_varieties$Frequency)*100,2), variety_14_others_avgPestcode, variety_14_others_avgCONCEN, sum(variety_14_CountCONCEN[c(6,12:23)])) #Combine the sum of low frequency variety samples, percentage these samples make up of the total, the 2 weighted averages for low frequency varieties from above, and the combined number of residue concentrations detected into a new data frame.

colnames(stat_14_varieties_others) <- c("Frequency", "Percentage", "Avg # of Pesticides","Avg Concentration", "Concentration Count") #Update the headers for the data frame columns for clarification.
rownames(stat_14_varieties_others) <- c("Others") #Update the name for the row of data to the new "Others" variety group.
stat_14_varieties_top10 <- rbind(stat_14_varieties_top10, stat_14_varieties_others) #Append the row for "Others" data to the top 10 list for plotting.

##ggplot2 code for plotting the average number of pesticides by variety, with a color gradient to show the number of apple samples in the data for that variety. 
plot_variety_avgPestcode <- ggplot(data=stat_14_varieties_top10, aes(x=factor(rownames(stat_14_varieties_top10), levels=unique(rownames(stat_14_varieties_top10))),y=stat_14_varieties_top10$`Avg # of Pesticides`, fill=stat_14_varieties_top10$Frequency)) + #Using ggplot() to start so different layers can be added to the graph moving down. Plotting data in the top 10 variety data set from above with the varieties on x and avg pesticide # on y. Fill the graph according to the number of samples that exist for that variety.
  geom_bar(stat="identity") + #using a bar graph with y values exactly as they are in the data set.
  scale_fill_gradient("Samples\nin Variety",low = "#132B43", high = "#56B1F7") + #Set the title of the color legend and define the lower and upper color for the gradient used.
  labs(title="Average Number of Pesticides by Variety",x="Variety",y="Average Number of Pesticides", caption="Graph displays data for the top 10 varieties based on and ordered by the number of samples in the 2014 data. \nAll remaining varieties are grouped together with samples of unknown variety as \"Others\" to improve readability.") + #Set the title of the plot and the axis labels.
  theme(plot.title=element_text(face="bold", size="20", hjust=0.5, margin=margin(0,0,10,0)), axis.title.x=element_text(face="bold", size="14", margin=margin(10,0,0,0)), axis.title.y=element_text(face="bold", size="14", margin=margin(0,10,0,0)), plot.caption = element_text(face="italic", hjust=0, size="8", margin=margin(10,0,0,0))) #Set the font size, weight, and margins to improve readability.

print(plot_variety_avgPestcode) #Output the above graph when the code is sourced.

##ggplot2 code for plotting the average concentration by variety, with a color gradient to show the number of apple samples in the data for that variety. 
plot_variety_avgCONCEN <- ggplot(data=stat_14_varieties_top10, aes(x=factor(rownames(stat_14_varieties_top10), levels=unique(rownames(stat_14_varieties_top10))),y=stat_14_varieties_top10$`Avg Concentration`, fill=stat_14_varieties_top10$Frequency)) + #Using ggplot() to start so different layers can be added to the graph moving down. Plotting data in the top 10 variety data set from above with the varieties on x and avg pesticide # on y. Fill the graph according to the number of samples that exist for that variety.
  geom_bar(stat="identity") + #Instruct the plot to use a bar graph with y values exactly as they are in the data set.
  scale_fill_gradient("Samples\nin Variety",low = "#132B43", high = "#56B1F7") + #Set the title of the color legend and define the lower and upper color for the gradient used.
  labs(title="Average Residue Concentration by Variety",x="Variety",y="Average Concentration (ppm)", caption="Graph displays data for the top 10 varieties based on and ordered by the number of samples in the 2014 data. \nAll remaining varieties are grouped together with samples of unknown variety as \"Others\"  to improve readability.") + #Set the title of the plot and the axis labels.
  theme(plot.title=element_text(face="bold", size="20", hjust=0.5, margin=margin(0,0,10,0)), axis.title.x=element_text(face="bold", size="14", margin=margin(10,0,0,0)), axis.title.y=element_text(face="bold", size="14", margin=margin(0,10,0,0)), plot.caption = element_text(face="italic", hjust=0, size="8", margin=margin(10,0,0,0))) #Set the font size, weight, and margins to improve readability.

print(plot_variety_avgCONCEN) #Output the above graph when the code is sourced.



#------------------
#Interpretation: Average Number of Pesticides and average residue concentration by Variety: These are two separate bar graphs showing the average number of types of pesticide found on varieties with the most samples in the 2014 conventional apple data and a second graph for the average residue concentration detected for those varieties. There were a total of 22 different varieties, with some additional samples of unknown varieties. In order to improve readability of the graph, only the top 10 varieties are shown (on the x axis), with the remaining lower frequency and unknown varieties combined into an 11th group labeled as "Others" after obtaining a weighted mean from their data. The varieties are displayed on these graphs in order of their sample frequency from left to right in decreasing order, with the "Others" category added to the end. A color gradient is used to fill the bars in order to provide viewers with approximate sample frequency information on the graph as well. The average number of pesticides and average concentration (unit: parts per million), are put on the y axis of their respective graphs.

# The most common apple varieties seem to have an average of around 4 types of pesticide per sample, while Honeycrisp appear to have  more per sample compared to the other varieties. Due to the wide range of concentration amounts, no conclusion could be drawn from the average concentration when divided by variety (this point will be mentioned in the presentation if the graph is to be included). However, it is interesting that the residue concentration average for honeycrisp appears to be on the low end. So, they appear to have more types of pesticide but of low concentration in the batches tested in 2014.
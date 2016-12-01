##======================================================================================
## This is the script file with the codes that generated the graphs in the DOCX file for the R Plot deliverable.
## This file is divided into the following sections:
## - A setup section to call the previous "INFM600_0101_KeenKoalas_RScript.R" file and any additional necessary libraries.
## - The graphs for pesticide number and concentration by apple variety.
## - The graphs for pesticide number and concentration by state and apple grade.
## - The graph for pesticide comparison between 2004 and 2014.
## - The graph for pesticide comparison between conventional and organic apples.
##======================================================================================

#Set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the "INFM600_0101_KeenKoalas_RScript.R" script to perform data importing, setup, and basic stat preps.
source("INFM600_0101_KeenKoalas_RScript.R")

##Load ggplot2 for plotting. Put inside an if (!require()) condition to install the package if it is not already installed, then run library() to load the package again afterwards to make sure it is installed and loaded successfully.
if (suppressWarnings(!require("ggplot2"))) {
  install.packages("ggplot2")
}
library(ggplot2)

##======================================================================================

#Reorganize and plot average concentration by variety. For readability reasons, the 23 rows (22 varieties + 1 row for "unknown" varieties) of data on pesticide number of average concentration by variety will be restructured to the top 10 most frequent varieties plus a group called "Others" for all other remaining and unknown varieties.
stat_14_varieties_top10 <- stat_14_varieties[c(1:5,7:11),] #Create a new subset of the average pesticide numbers and concentration for the top 10 varieties by frequency by storing rows 1-5 and 7-11 (bypassing row 6 which is not an actual variety but sum of all samples with unknown variety).

variety_14_others_avgPestcode <- round(weighted.mean(variety_14_avgPestcode[c(6,12:23)],stat_14_varieties$Frequency[c(6,12:23)]),3) #Calculate the combined weighted average pesticide number per sample for the new "Others" group with all lower frequency varieties (including "unknown" varieties), and round to 3 decimal places.

variety_14_others_avgCONCEN <- round(weighted.mean(variety_14_avgCONCEN[c(6,12:23)], variety_14_CountCONCEN[c(6,12:23)]),3) #Calculate the combined weighted average concentration amount for the new "Others" group with all lower frequency varieties (including "unknown" varieties), and round to 3 decimal places.

stat_14_varieties_others <- data.frame(sum(stat_14_varieties$Frequency[c(6,12:23)]), round(sum(stat_14_varieties$Frequency[c(6,12:23)])/sum(stat_14_varieties$Frequency)*100,2), variety_14_others_avgPestcode, variety_14_others_avgCONCEN, sum(variety_14_CountCONCEN[c(6,12:23)])) #Combine the sum of low frequency variety samples, percentage these samples make up of the total, the 2 weighted averages for low frequency varieties from above, and the combined number of residue concentrations detected into a new data frame.

colnames(stat_14_varieties_others) <- c("Frequency", "Percentage", "Avg # of Pesticides","Avg Concentration", "Concentration Count") #Update the headers for the data frame columns for clarification.
rownames(stat_14_varieties_others) <- c("Others") #Update the name for the row of data to the new "Others" variety group.
stat_14_varieties_top10 <- rbind(stat_14_varieties_top10, stat_14_varieties_others) #Append the row for "Others" data to the top 10 list for plotting.

##--------------------------------------------------------------------------------------

##ggplot2 code for plotting the average number of pesticides by variety, with a color gradient to show the number of apple samples in the data for that variety. 
plot_variety_avgPestcode <- ggplot(data=stat_14_varieties_top10, aes(x=factor(rownames(stat_14_varieties_top10), levels=unique(rownames(stat_14_varieties_top10))),y=stat_14_varieties_top10$`Avg # of Pesticides`, fill=stat_14_varieties_top10$Frequency)) + #Using ggplot() to start so different layers can be added to the graph moving down. Plotting data in the top 10 variety data set from above with the varieties on x and avg pesticide # on y. Fill the graph according to the number of samples that exist for that variety.
  geom_bar(stat="identity") + #using a bar graph with y values exactly as they are in the data set.
  scale_fill_gradient("Samples\nin Variety",low = "#132B43", high = "#56B1F7") + #Set the title of the color legend and define the lower and upper color for the gradient used.
  labs(title="Average Number of Pesticides by Variety",x="Apple Variety",y="Average Number of Pesticides", caption="Graph displays data for the top 10 varieties based on and ordered by the number of samples in the 2014 data. \nAll remaining varieties are grouped together with samples of unknown variety as \"Others\" to improve readability.") + #Set the title of the plot and the axis labels.
  theme(plot.title=element_text(face="bold", size="18", hjust=0.5, margin=margin(0,0,10,0)), axis.title.x=element_text(face="bold", size="12", margin=margin(10,0,0,0)), axis.title.y=element_text(face="bold", size="12", margin=margin(0,10,0,0)), plot.caption = element_text(face="italic", hjust=0, size="10", margin=margin(10,0,0,0))) #Set the font size, weight, and margins to improve readability.

print(plot_variety_avgPestcode) #Output the above graph when the code is sourced.

##--------------------------------------------------------------------------------------

##ggplot2 code for plotting the average concentration by variety, with a color gradient to show the number of apple samples in the data for that variety. 
plot_variety_avgCONCEN <- ggplot(data=stat_14_varieties_top10, aes(x=factor(rownames(stat_14_varieties_top10), levels=unique(rownames(stat_14_varieties_top10))),y=stat_14_varieties_top10$`Avg Concentration`, fill=stat_14_varieties_top10$Frequency)) + #Using ggplot() to start so different layers can be added to the graph moving down. Plotting data in the top 10 variety data set from above with the varieties on x and avg pesticide # on y. Fill the graph according to the number of samples that exist for that variety.
  geom_bar(stat="identity") + #Instruct the plot to use a bar graph with y values exactly as they are in the data set.
  scale_fill_gradient("Samples\nin Variety",low = "#132B43", high = "#56B1F7") + #Set the title of the color legend and define the lower and upper color for the gradient used.
  labs(title="Average Residue Concentration by Variety",x="Apple Variety",y="Average Concentration (ppm)", caption="Graph displays data for the top 10 varieties based on and ordered by the number of samples in the 2014 data. \nAll remaining varieties are grouped together with samples of unknown variety as \"Others\"  to improve readability.") + #Set the title of the plot and the axis labels.
  theme(plot.title=element_text(face="bold", size="18", hjust=0.5, margin=margin(0,0,10,0)), axis.title.x=element_text(face="bold", size="12", margin=margin(10,0,0,0)), axis.title.y=element_text(face="bold", size="12", margin=margin(0,10,0,0)), plot.caption = element_text(face="italic", hjust=0, size="10", margin=margin(10,0,0,0))) #Set the font size, weight, and margins to improve readability.

print(plot_variety_avgCONCEN) #Output the above graph when the code is sourced.

##======================================================================================

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

#Print the 4 graphs above.
print(Avg_Conc_State_Plot)
print(Avg_Conc_Grade_Plot)
print(Avg_No_State_Plot)
print(Avg_No_Grade_Plot)

##======================================================================================

## Pesticide comparison between 2004 and 2014.

#Selecting the common pesticides which were used for regular and organic apples.
pest_data_04_plot<-pest_data_04[c(1,4,6,7,13,17,22,24,25,28,29,30,31,32,33,36,37,38,39),]
pest_data_14_plot<-pest_data_14[c(1,3,4,5,8,9,11,12,13,15,16,17,18,19,21,25,26,33,43),]

#Adding a column called Year for each of the Pestcodes and give the year for each pesticide.
pest_data_04_plot["Year"]<- '2004'
pest_data_14_plot["Year"]<- '2014'

#Vertically merging the common samples which were selected above to use for plotting.
reg_org_combined_que1<-rbind(pest_data_14_plot,pest_data_04_plot)

#Adding a column called Pesticide Name for each of the Pestcodes and give the appropriate name for each pesticide.
reg_org_combined_que1["Pesticide_Name"]<-NA

reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='125' ] <- "Diphenylamine(DPA)"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='157' ] <- "Thiabendazole"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='666' ] <- "Carbendazim(MBC)"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='ABC' ] <- "Spinosad A"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='102' ] <-"Carbaryl"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='159' ] <-"Methomyl"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='24' ] <-"Diazinon"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='382' ] <-"1-Napthol"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='624' ] <-"Tetrahydrophthalimide(THPI)"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='679' ] <-"Miclobutanyl"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='808' ] <-"Fenpropathrin"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='83' ] <-"O-Phenylphenol"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='900' ] <-"Endosulfan I"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='901' ] <-"Endosulfan II"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='902' ] <-"Endosulan Sulphate"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='967' ] <-"Imidacloprid"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='ADE' ] <-"Esfenvalerate+Fenvalerate Total"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='AEL' ] <-"Cyhalothrin"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='B22' ] <-"Cyprodinil"
reg_org_combined_que1$Pesticide_Name[reg_org_combined_que1$Pestcode =='B80' ] <-"Acetamiprid"

# Plotting the comparison of apple samples of 2004 and 2014 to plot the changes in the average concentrations found in the samples over the years.
print(ggplot(data=reg_org_combined_que1,aes(x=reorder(Pesticide_Name,-freq),y=CONCEN)) + geom_bar(aes(fill=Year),stat="identity",position = "dodge")  + ggtitle("Pesticide Residue Comparison: 2014 vs 2004") + labs(x="Pesticide Name",y="Average Concentration (ppm)") + theme(axis.text.x=element_text(size=8,angle = 20)))

##======================================================================================

## Pesticide comparison between conventional and organic apples for 2014.

#Selecting the common pesticides which were detected on both regular and organic apples.
pest_data_reg_14_plot<-  pest_data_reg_14[c(3,4,12),]
pest_data_reg_14_plot["Type"]<- 'Regular'

pest_data_org_14_plot<-  pest_data_org_14[c(1,2,3),]
pest_data_org_14_plot["Type"]<- 'Organic'


#Vertically merging the common pesticides which were selected above to use for plotting.
reg_org_combined_que2<-rbind(pest_data_org_14_plot,pest_data_reg_14_plot)

#Adding a column called Pesticide Name for each of the Pestcodes and giving the appropriate name.
reg_org_combined_que2["Pesticide_Name"]<-NA
reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='125' ] <- "Diphenylamine(DPA)"
reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='157' ] <- "Thiabendazole"
reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='666' ] <- "Carbendazim(MBC)"
reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='ABC' ] <- "Spinosad A"

# Plotting the comparison of organic vs regular apples to show the average concentration found in various pesticides in the sample selected above.
print(ggplot(data=reg_org_combined_que2,aes(x=reorder(Pesticide_Name,-freq),y=CONCEN)) + geom_bar(aes(fill=Type),stat="identity",position = "dodge")  + ggtitle("Pesticide Residue Comparison: Organic vs Regular - 2014") + labs(x="Pesticide Name",y="Average Concentration (ppm)") + theme(axis.text.x=element_text(size=8)))
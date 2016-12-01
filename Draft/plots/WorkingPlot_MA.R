##--------------------------------------------------------------------------------------
# This is the working R plot coding file for Mayuresh.

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

##
#Selecting the common pesticides which were used for regular and organic apples.
  pest_data_reg_14_plot<-  pest_data_reg_14[c(3,4,12),]
  pest_data_reg_14_plot["Type"]<- 'Regular'
  
  pest_data_org_14_plot<-  pest_data_org_14[c(1,2,3),]
  pest_data_org_14_plot["Type"]<- 'Organic'
  
  
  #Vertically merging the common samples which were selected above to use for plotting.
  reg_org_combined_que2<-rbind(pest_data_org_14_plot,pest_data_reg_14_plot)
  
  #Adding a column called Pesticide Name for each of the Pestcodes and giving the appropriate name.
  reg_org_combined_que2["Pesticide_Name"]<-NA
  reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='125' ] <- "Diphenylamine(DPA)"
  reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='157' ] <- "Thiabendazole"
  reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='666' ] <- "Carbendazim(MBC)"
  reg_org_combined_que2$Pesticide_Name[reg_org_combined_que2$Pestcode =='ABC' ] <- "Spinosad A"
  
  # Plotting the comparison of organic vs regular apples to show the average concentration found in various pesticides in the sample selected above.
  ggplot(data=reg_org_combined_que2,aes(x=reorder(Pesticide_Name,-freq),y=CONCEN)) + geom_bar(aes(fill=Type),stat="identity",position = "dodge")  + ggtitle("Organic vs Regular - 2014") + labs(x="Pesticide Name",y="Average Concentration") + theme(axis.text.x=element_text(size=8,angle = 20))
  
  # Interpretation: The group bar chart plots the average concentrations of the pesticides found common in the regular and the organic samples of apples. 
  # The avg concentrations of these pesticides has been plotted in the decreasing order of frequency of the samples. From the grouped bar chart it is evident 
  # that the regular samples of apples in 2014 have a significantly more average concentration of the pesticides than their organic counterparts. It can also
  # be interpreted that there are only 3 kinds of pesticides that are actually used in organic apples whereas in the regular apples, the number of varieties of
  # pesticides found is 43. It can be interpreted that organic apples are definitely a healthier alternative to the regular apples.
  
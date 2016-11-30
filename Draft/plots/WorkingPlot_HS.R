##--------------------------------------------------------------------------------------
# This is the working R plot coding file for Himanshu.

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

#Selecting the common pesticides which were used for regular and organic apples.
pest_data_04_plot<-pest_data_04[c(1,4,6,7,13,17,22,24,25,28,29,30,31,32,33,36,37,38,39),]
pest_data_14_plot<-pest_data_14[c(1,3,4,5,8,9,11,12,13,15,16,17,18,19,21,25,26,33,43),]

#Adding a column called Year for each of the Pestcodes and give the year for each sample.
pest_data_04_plot["Year"]<- '2004'
pest_data_14_plot["Year"]<- '2014'


#Vertically merging the common samples which were selected above to use for plotting.
reg_org_combined_que1<-rbind(pest_data_14_plot,pest_data_04_plot)

#Adding a column called Pesticide Name for each of the Pestcodes and give the appropriate name for each sample.
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

# Plotting the comparison of organic vs regular apples to show the average concentration found in various pesticides in the sample selected above.
ggplot(data=reg_org_combined_que1,aes(x=Pesticide_Name,y=CONCEN)) + geom_bar(aes(fill=Year),stat="identity",position = "dodge")  + ggtitle("2014 vs 2004") + labs(x="Pesticide Name",y="Average Concentration")

#Interpretation: From the grouped bar chart which is plotted above, only 5 out of 19 pesticides (Cyhalothrin, Cyphrodinil, Esfenvalerate+Fenvalerate Total, O-Phenylphenol, Thiabendazole) have shown a decline in average concentration from 2004 to 2014. However, all the other pesticides have an average concentration which has increased from 2004 to 2014.

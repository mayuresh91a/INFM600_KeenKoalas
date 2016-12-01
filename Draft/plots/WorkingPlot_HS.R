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

# Plotting the comparison of apple samples of 2004 and 2014 to plot the trend of the average concentration found in the samples over the years.
ggplot(data=reg_org_combined_que1,aes(x=reorder(Pesticide_Name,-freq),y=CONCEN)) + geom_bar(aes(fill=Year),stat="identity",position = "dodge")  + ggtitle("2014 vs 2004") + labs(x="Pesticide Name",y="Average Concentration") + theme(axis.text.x=element_text(size=8,angle = 20))

#Interpretation: The ggplot command plots the grouped bar chart. On the X-axis, we have the names of the various Pesticides which were found in the samples for the years of 2004 and 2014. The pesticides are arranged by decreasing order of number of the samples tested in 2004. On the Y-axis we have the average concentration of the pesticides.The grouped bar chart shows that only 5 out of 19 pesticides (Cyhalothrin, Cyphrodinil, Esfenvalerate+Fenvalerate Total, O-Phenylphenol, Thiabendazole) have shown a decline in average concentration from 2004 to 2014. However, all the other pesticides have an average concentration which has increased from 2004 to 2014. This can be seen from the height of the individual bars in the grouped bar chart where red colour stands for 2004 samples and blue for 2014 samples. The increase or decrease in the height of the bars represent the increase or decrease in the amount of average concentration of the pesticide found in those samples respectively and thus we can observe the trend from 2004 to 2014.  

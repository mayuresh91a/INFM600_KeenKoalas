##This script calls the Data_Cleaning.R script to import the data for this project and do initial data setup, then make preparations for analysis by creating subsets of the data with various conditions.
##To be merged with other analysis scripts near ending of the scripting phase.

##--------------------------------------------------------------------------------------

# set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the Data_Cleaning.R script to perform data importing and setup.
source("Data_Cleaning.R")

##--------------------------------------------------------------------------------------

##Preparation: Creating different subsets of data in preparation of running analysis.

#Create data subset of only organic samples by excluding samples with no pesticide related claims (i.e., conventional) from the CLAIM variable for both 2014 and 2004, respectively.
Samples_2014_Organic <- subset(Samples_2014, Samples_2014$CLAIM != "NC") #2014 data
Samples_2004_Organic <- subset(Samples_2004, Samples_2004$CLAIM != "NC") #2004 data

#Create data subset of only conventional samples by only including samples with no pesticide related claims (i.e., conventional) from the CLAIM for both 2014 and 2004, respectively.
Samples_2014_Regular <- subset(Samples_2014, Samples_2014$CLAIM == "NC") #2014 data
Samples_2004_Regular <- subset(Samples_2004, Samples_2004$CLAIM == "NC") #2004 data

#Create data subset of only results where a residue was detected by excluding rows with null for the CONCEN variable (residue concentration).
Results_2014_Detected <- subset(Results_2014, !is.na(Results_2014$CONCEN)) #2014 data
Results_2004_Detected <- subset(Results_2004, !is.na(Results_2004$CONCEN)) #2004 data

#Create data subset of all residue test results (both detected and none detected) for only organic samples by including rows from Results where the SAMPLE_PK matches SAMPLE_PK values from the organic samples subset created above.
Results_2014_Organic <- subset(Results_2014,!is.na(match(Results_2014$SAMPLE_PK,Samples_2014_Organic$SAMPLE_PK))) #2014 data
Results_2004_Organic <- subset(Results_2004,!is.na(match(Results_2004$SAMPLE_PK,Samples_2004_Organic$SAMPLE_PK))) #2004 data

#Create data subset of all residue test results (both detected and none detected) for only conventional samples by including rows from Results where the SAMPLE_PK matches SAMPLE_PK values from the conventional samples subset created above.
Results_2014_Regular <- subset(Results_2014,!is.na(match(Results_2014$SAMPLE_PK,Samples_2014_Regular$SAMPLE_PK))) #2014 data
Results_2004_Regular <- subset(Results_2004,!is.na(match(Results_2004$SAMPLE_PK,Samples_2004_Regular$SAMPLE_PK))) #2004 data

#Create data subset of only detected residue test results for organic samples by excluding rows with null for the CONCEN variable (residue concentration) from the previously created organic results subsets.
Results_2014_Organic_Detected <- subset(Results_2014_Organic, !is.na(Results_2014_Organic$CONCEN)) #2014 data
Results_2004_Organic_Detected <- subset(Results_2004_Organic, !is.na(Results_2004_Organic$CONCEN)) #2004 data

#Create data subset of only detected residue test results for conventional samples by excluding rows with null for CONCEN (residue concentration) from the previously created conventional results subsets.
Results_2014_Regular_Detected <- subset(Results_2014_Regular, !is.na(Results_2014_Regular$CONCEN)) #2014 data
Results_2004_Regular_Detected <- subset(Results_2004_Regular, !is.na(Results_2004_Regular$CONCEN)) #2004 data

##--------------------------------------------------------------------------------------

#Total Statistics, pesticides for 2014, 2004
#Total Statistics, concentrations for 2014, 2004
#number of pesticides per sample, conv vs org
#sd of CONCEN?
#range of CONCEN (min and max)
#quantile of CONCEN
#average of how many pesticides are tested per sample?


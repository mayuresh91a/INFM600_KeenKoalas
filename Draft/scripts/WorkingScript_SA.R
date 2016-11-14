##This is a work-in-progress script for Saba
##To be merged with other sections near the end of the scripting phase.

##--------------------------------------------------------------------------------------

# set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the AnalysisSetup.R script to perform data importing and setup, and prep for running the analysis scripts below. May be removed during script merge later in the phase.
source("AnalysisSetup.R")

##--------------------------------------------------------------------------------------
##Note to Saba: please put the codes for your analysis below ^_^v

# 1) Find the most frequently appearing pesticides in the 2014 data with corresponding average concentrations.

# 1)a. Find the pesticide statistics for all 2014 samples with detected pesticides. The resulting data frame "pest_summary_14"
# shows all pesticides in the 2014 data in decreasing order of frequency and their average concentrations.

attach(Results_2014_Detected)

pest_data_14 <- data.frame(subset(Results_2014_Detected, select = c(Pestcode, CONCEN))) #Create a subset of the 2014 data with only the columns with pesticide code and concentration.
pest_data_14 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_14)) #Group the pestecide data by Pestcode and find the average concentration for each pesticide.
library(plyr) #To enable count function.
pest_data_14 <- data.frame(pest_data_14, count(Pestcode)) #Add a column with the frequency of each pestecide.
pest_data_14$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_14 <- pest_data_14[order(-pest_data_14$freq),] #Create a dataframe with pesticide data in decreasing order of frequency.
colnames(pest_summary_14) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2014_Detected)

# 1)b. Repeat the process for organic 2014 samples - find the most frequently appearing pesticides and corresponding average concentrations.
# and store the results in the data frame "pest_summary_org_14".

attach(Results_2014_Organic_Detected)

pest_data_org_14 <- data.frame(subset(Results_2014_Organic_Detected, select = c(Pestcode, CONCEN))) #Create a subset with only pesticide and concentration data.
pest_data_org_14 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_org_14)) #Find the average concentration for each pesticide.
pest_data_org_14 <- data.frame(pest_data_org_14, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_org_14$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_org_14 <- pest_data_org_14[order(-pest_data_org_14$freq),] #Create dataframe with samples appearing in decreasing order of frequency.
colnames(pest_summary_org_14) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2014_Organic_Detected)

# 1)c. Repeat the process for regular 2014 samples - find the most frequently appearing pesticides and corresponding average concentrations
# and store the result in the data frame "pest_summary_reg_14".

attach(Results_2014_Regular_Detected)

pest_data_reg_14 <- data.frame(subset(Results_2014_Regular_Detected, select = c(Pestcode, CONCEN))) #Create a subset with only pesticide and concentration data.
pest_data_reg_14 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_reg_14)) #Find the average concentration for each pesticide.
pest_data_reg_14 <- data.frame(pest_data_reg_14, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_reg_14$x <-  NULL #Remove redundant "Pestcode" column.
pest_summary_reg_14 <- pest_data_reg_14[order(-pest_data_reg_14$freq),] #Create dataframe with samples appearing in decreasing order of frequency.
colnames(pest_summary_reg_14) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2014_Regular_Detected)

# 2) Repeat the process for the 2004 data - find the most frequently appearing pesticides and their corresponding average concentrations.

# 2)a. Find most most frequently appearing pesticides and average concentrations for all 2004 samples with detected pesticides 
# and store the results in the data frame "pest_summary_04".

attach(Results_2004_Detected)

pest_data_04 <- data.frame(subset(Results_2004_Detected, select = c(Pestcode, CONCEN))) #Create a subset with only pesticide and concentration data.
pest_data_04 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_04)) #Find the average concentration for each pesticide.
pest_data_04 <- data.frame(pest_data_04, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_04$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_04 <- pest_data_04[order(-pest_data_04$freq),]
colnames(pest_summary_04) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2004_Detected)

# 2)b. Repeat the process for organic 2004 samples - find the most frequently appearing pestecides and their average concentrations
#and store the results in the data frame "pest_summary_org_04".

attach(Results_2004_Organic_Detected)

pest_data_org_04 <- data.frame(subset(Results_2004_Organic_Detected, select = c(Pestcode, CONCEN)))
pest_data_org_04 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_org_04))
pest_data_org_04 <- data.frame(pest_data_org_04, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_org_04$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_org_04 <- pest_data_org_04[order(-pest_data_org_04$freq),] #Create dataframe with samples appearing in decreasing order of frequency.
colnames(pest_summary_org_04) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2004_Organic_Detected)

# 2) c. Repeat the process for regular 2004 samples - find the most frequently appearing pestecides and their average concentrations.
# Store the results in the data frame "pest_summary_reg_04".

attach(Results_2004_Regular_Detected)

pest_data_reg_04 <- data.frame(subset(Results_2004_Regular_Detected, select = c(Pestcode, CONCEN)))
pest_data_reg_04 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_04))
pest_data_reg_04 <- data.frame(pest_data_reg_04, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_reg_04$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_reg_04 <- pest_data_reg_04[order(-pest_data_reg_04$freq),] #Create dataframe with samples appearing in decreasing order of frequency.
colnames(pest_summary_reg_04) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2004_Regular_Detected)

# 3. Find percentage of all 2004 and 2014 samples with detected pesticides; 
# Repeat the process for regular samples and organic samples.

# 3)a. Find the number of samples with detected pesticides for each year. 

#Number of samples with detected pesticides for all 2004 and 2014 data:

x <- count(unique(Results_2014_Detected$SAMPLE_PK)) #Returns a data frame with a row for each 2014 sample with detected pestecides.
detected_samples_14 <- sum(x$freq) #Returns the number of 2014 samples with detected pesticides.

y <- count(unique(Results_2004_Detected$SAMPLE_PK)) #Returns a data frame with a row for each 2004 sample with detected pesticides.
detected_samples_04 <- sum(y$freq) #Returns the number of 2014 samples with detected pesticides.

#Number of samples with detected pesticides for organic data:

org_detected_samples_14 <- sum(count(unique(Results_2014_Organic_Detected$SAMPLE_PK))$freq)
org_detected_samples_04 <- sum(count(unique(Results_2004_Organic_Detected$SAMPLE_PK))$freq)

#Number of samples with detected pesticides for regular data:

reg_detected_samples_14 <- sum(count(unique(Results_2014_Regular_Detected$SAMPLE_PK))$freq)
reg_detected_samples_04 <- sum(count(unique(Results_2004_Regular_Detected$SAMPLE_PK))$freq)

# 3)b. Find the total number of samples for each year.

#All 2014 and 2004 data:
num_samples_14 <- sum(count(Samples_2014$SAMPLE_PK)$freq) #Gives the total number of 2014 samples.
num_samples_04 <- sum(count(Samples_2004$SAMPLE_PK)$freq) #Gives the total number of 2004 samples.

#Organic 2014 and 2004 data:
num_org_samples_14 <- sum(count(Samples_2014_Organic$SAMPLE_PK)$freq) #Gives the total number of 2014 organic samples.
num_org_samples_04 <- sum(count(Samples_2004_Organic$SAMPLE_PK)$freq) #Gives the total number of 2004 organic samples.

#Regular 2014 and 2004 data:
num_reg_samples_14 <- sum(count(Samples_2014_Regular$SAMPLE_PK)$freq)
num_reg_samples_04 <- sum(count(Samples_2004_Regular$SAMPLE_PK)$freq)

# 3)c. Find the percentage of samples with detected pesticides for each year.

#Percent detected - all samples:
percent_detected_14 <- round((detected_samples_14/num_samples_14)*100, 2) #Percentage of all 2014 samples with detected pesticides.
percent_detected_04 <- round((detected_samples_04/num_samples_04)*100, 2) #Percentage of all 2004 samples with detected pesticides.

#Percent detected - organic samples:
percent_detected_org_14 <- round((org_detected_samples_14/num_org_samples_14)*100, 2) #Percentage of organic 2014 samples.
percent_detected_org_04 <- round((org_detected_samples_04/num_org_samples_04)*100, 2) #Percentage of organic 2004 samples.

#Percent detected - regular samples.
percent_detected_reg_14 <- round((reg_detected_samples_14/num_reg_samples_14)*100, 2) #Percentage of regular 2014 samples.
percent_detected_reg_04 <- round((reg_detected_samples_04/num_reg_samples_04)*100, 2) #Percentage of regular 2004 samples

# 4) Create the table "Percent_Detected_Samples" showing the percentage of samples with detected pesticides for each year.

Percent_Organic = c(percent_detected_org_14, percent_detected_org_04) 
Percent_Regular = c(percent_detected_reg_14, percent_detected_reg_04)
Percent_All = c(percent_detected_14, percent_detected_04)

Percent_Detected_Samples <- data.frame(Year = c(2014, 2004), Percent_All, Percent_Regular, Percent_Organic)
##KeenKoalas - R Script Draft

##This script is made up of the following sections:
## - Set working directory and Call the "Data_Cleaning.R" script (from the data cleaning portion of the project) to import the data for this project and do basic initial data setup.
## - Make preparations for analysis by creating subsets of the data with various conditions and printing the basic statistics for the relevant variables in the subsets. 
## - Create further subsets for use in research on possible differences in pesticide residues by variety, state, and grade labeling. Basic statistics for relevant variables in the new subsets are printed where appropriate.
## - Create data frames with the frequency and average concentrations of pesticides for research on residue related changes between 2004 and 2014, as well as differences between conventional versus organic samples. Basic statistics for relevant variables in the new subsets are printed for the final resulting data frames.

##======================================================================================

#Set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the Data_Cleaning.R script to perform data importing and setup.
source("Data_Cleaning.R")

##======================================================================================

##Preparation: Creating different subsets of data in preparation of running analysis and print the summary statistics for columns relevant to our research questions.

#Create data subset of only organic samples by excluding samples with no pesticide related claims (i.e., conventional) from the CLAIM variable for both 2014 and 2004, respectively.
Samples_2014_Organic <- subset(Samples_2014, Samples_2014$CLAIM != "NC") #2014 data
Samples_2004_Organic <- subset(Samples_2004, Samples_2004$CLAIM != "NC") #2004 data

#Create data subset of only conventional samples by only including samples with no pesticide related claims (i.e., conventional) from the CLAIM for both 2014 and 2004, respectively.
Samples_2014_Regular <- subset(Samples_2014, Samples_2014$CLAIM == "NC") #2014 data
Samples_2004_Regular <- subset(Samples_2004, Samples_2004$CLAIM == "NC") #2004 data

#Create data subset of only results where a residue was detected by excluding rows with null for the CONCEN variable (residue concentration).
Results_2014_Detected <- subset(Results_2014, !is.na(Results_2014$CONCEN)) #2014 data
Results_2004_Detected <- subset(Results_2004, !is.na(Results_2004$CONCEN)) #2004 data

#Print basic statistics of the 2 variables relevant to our research (pesticide code and concentration amount) from the two results data subsets above, along with the standard deviation of the concentration data.
cat("Statistics - 2014 Results with Detected Residue\n")
print(summary(Results_2014_Detected[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Detected$CONCEN), "\n\n")
cat("Statistics - 2004 Results with Detected Residue\n")
print(summary(Results_2004_Detected[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2004_Detected$CONCEN), "\n\n")

#Create data subset of all residue test results (both detected and none detected) for only organic samples by including rows from Results where the SAMPLE_PK matches SAMPLE_PK values from the organic samples subset created above.
Results_2014_Organic <- subset(Results_2014,!is.na(match(Results_2014$SAMPLE_PK,Samples_2014_Organic$SAMPLE_PK))) #2014 data
Results_2004_Organic <- subset(Results_2004,!is.na(match(Results_2004$SAMPLE_PK,Samples_2004_Organic$SAMPLE_PK))) #2004 data

#Print basic statistics of the 2 variables relevant to our research (pesticide code and concentration amount) from the two results data subsets above, along with the standard deviation of the concentration data.
cat("Statistics - 2014 Results from Organic Samples\n")
print(summary(Results_2014_Organic[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Organic$CONCEN), "\n\n")
cat("Statistics - 2004 Results from Organic Samples\n")
print(summary(Results_2004_Organic[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Organic$CONCEN), "\n\n")

#Create data subset of all residue test results (both detected and none detected) for only conventional samples by including rows from Results where the SAMPLE_PK matches SAMPLE_PK values from the conventional samples subset created above.
Results_2014_Regular <- subset(Results_2014,!is.na(match(Results_2014$SAMPLE_PK,Samples_2014_Regular$SAMPLE_PK))) #2014 data
Results_2004_Regular <- subset(Results_2004,!is.na(match(Results_2004$SAMPLE_PK,Samples_2004_Regular$SAMPLE_PK))) #2004 data

#Print basic statistics of the 2 variables relevant to our research (pesticide code and concentration amount) from the two results data subsets above, along with the standard deviation of the concentration data.
cat("Statistics - 2014 Results from Conventional Samples\n")
print(summary(Results_2014_Regular[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Regular$CONCEN), "\n\n")
cat("Statistics - 2004 Results from Conventional Samples\n")
print(summary(Results_2004_Regular[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Regular$CONCEN), "\n\n")

#Create data subset of only detected residue test results for organic samples by excluding rows with null for the CONCEN variable (residue concentration) from the previously created organic results subsets.
Results_2014_Organic_Detected <- subset(Results_2014_Organic, !is.na(Results_2014_Organic$CONCEN)) #2014 data
Results_2004_Organic_Detected <- subset(Results_2004_Organic, !is.na(Results_2004_Organic$CONCEN)) #2004 data

#Print basic statistics of the 2 variables relevant to our research (pesticide code and concentration amount) from the two results data subsets above, along with the standard deviation of the concentration data.
cat("Statistics - 2014 Detected Residue Results from Organic Samples\n")
print(summary(Results_2014_Organic_Detected[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Organic_Detected$CONCEN), "\n\n")
cat("Statistics - 2004 Detected Residue Results from Organic Samples\n")
print(summary(Results_2004_Organic_Detected[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Organic_Detected$CONCEN), "\n\n")

#Create data subset of only detected residue test results for conventional samples by excluding rows with null for CONCEN (residue concentration) from the previously created conventional results subsets.
Results_2014_Regular_Detected <- subset(Results_2014_Regular, !is.na(Results_2014_Regular$CONCEN)) #2014 data
Results_2004_Regular_Detected <- subset(Results_2004_Regular, !is.na(Results_2004_Regular$CONCEN)) #2004 data

#Print basic statistics of the 2 variables relevant to our research (pesticide code and concentration amount) from the two results data subsets above, along with the standard deviation of the concentration data.
cat("Statistics - 2014 Detected Residue Results from Conventional Samples\n")
print(summary(Results_2014_Regular_Detected[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Regular_Detected$CONCEN), "\n\n")
cat("Statistics - 2004 Detected Residue Results from Conventional Samples\n")
print(summary(Results_2004_Regular_Detected[c("Pestcode","CONCEN")]))
cat("Std Dev:",sd(Results_2014_Regular_Detected$CONCEN), "\n\n")

##--------------------------------------------------------------------------------------

#Print average # of pesticides detected per sample for conventional and organic apples for general overview of differences between the two that may be helpful for the part of our analysis where a comparison between conventional and organic is made. Further detailed analysis on the topic will be further down in the script.

#2014 conventional:
cat("Statistics - 2014 Number of Pesticides per Conventional Sample\n")
print(round(length(Results_2014_Regular_Detected$SAMPLE_PK)/length(Samples_2014_Regular$SAMPLE_PK),2)) #Divide the total number of pesticide traces detected on conventional samples in 2014 by the total number of conventional samples, and round to 2 decimal places, to find the average. Then, print it.

#2014 Organic:
cat("Statistics - 2014 Number of Pesticides per Organic Sample\n")
print(round(length(Results_2014_Organic_Detected$SAMPLE_PK)/length(Samples_2014_Organic$SAMPLE_PK),2)) #Divide the total number of pesticide traces detected on organic samples in 2014 by the total number of organic samples, and round to 2 decimal places, to find the average. Then, print it.

#2004 conventional:
cat("Statistics - 2004 Number of Pesticides per Conventional Sample\n")
print(round(length(Results_2004_Regular_Detected$SAMPLE_PK)/length(Samples_2004_Regular$SAMPLE_PK),2)) #Perform the same calculation as above for 2004 conventional samples.

#2004 Organic:
cat("Statistics - 2004 Number of Pesticides per Organic Sample\n")
print(round(length(Results_2004_Organic_Detected$SAMPLE_PK)/length(Samples_2004_Organic$SAMPLE_PK),2)) #Perform the same calculation as above for 2004 organic samples.

##======================================================================================

## This section of the script creates subsets is for looking into possible differences in pesticide residues by variety, state, and grade labeling.

##Run stats (frequency, percentage) to prepare for pesticide comparison by variety for conventional apples.
stat_14_varieties <- data.frame(sort(summary(Samples_2014_Regular$VARIETY), decreasing=T)) #Count the number of apples in each variety for 2014's conventional samples and sort by frequency in descending order to find the varieties with the most samples. Store the result in a data frame.
stat_14_varieties <- data.frame(stat_14_varieties, round(stat_14_varieties[1]/sum(stat_14_varieties)*100,2)) #Calculate the percentage each variety makes up of the total number of samples for 2014, round to 2 decimal places, and add the results as a column to the data frame.
colnames(stat_14_varieties) <- c("Frequency", "Percentage") #Set the headers of the columns as "Frequency" and "Percentage" for clarification.

##Run stats (frequency, percentage) to prepare for pesticide comparison by state for conventional apples.
stat_14_states <- data.frame(sort(summary(Samples_2014_Regular$STATE), decreasing=T)) #Count the number of apples in each variety for 2014's conventional samples and sort by frequency in descending order to find the states with the most samples. Store the result in a data frame.
stat_14_states <- data.frame(stat_14_states, round(stat_14_states[1]/sum(stat_14_states)*100,2)) #Calculate the percentage each state makes up of the total number of samples for 2014, round to 2 decimal places, and add the results as a column to the data frame.
colnames(stat_14_states) <- c("Frequency", "Percentage") #Set the headers of the columns as "Frequency" and "Percentage" for clarification.

##Setup the variables for storing the average number of pesticides per sample and average residue concentration in preparation for storing the results from the 'for' loops below.
variety_14_avgPestcode <-c() #Variable for average number of pesticides per sample for the variety.
variety_14_avgCONCEN <- c() #Variable for average concentration amount for the variety.
state_14_avgPestcode <- c() #Variable for average number of pesticides per sample for the state.
state_14_avgCONCEN <- c() #Variable for average concentration amount for the state.

##--------------------------------------------------------------------------------------

##By variety filtering & calculations:
##Create subsets of pesticide data by variety via matching variety names from the frequency list previously created (stored as rownames) with Samples_2014_Regular$VARIETY, getting a list of primary key values for samples of that variety, then match those primary key values to Results_2014_Regular_Detected$SAMPLE_PK so the corresponding pesticide codes and concentrations can be pulled from the test results of detected residues for 2014.

for(i in 1:length(stat_14_varieties$Frequency)) #Go through the same process below for all varieties using a 'for' loop that matches the number of different varieties (23 in total).
{ 
  namePK <- paste0("variety_14_PK_", i) #Generate a string for naming the variable that will store primary keys matching the variety.
  nameResidue <- paste0("variety_14_Res_", i) #Generate a string for naming the variable to hold pesticide and concentration results data that match the variety.
  
  assign(namePK, subset(Samples_2014_Regular$SAMPLE_PK, Samples_2014_Regular$VARIETY == rownames(stat_14_varieties)[i])) #Get and store the primary keys for samples matching the variety,
  assign(nameResidue, subset(Results_2014_Regular_Detected, !is.na(match(Results_2014_Regular_Detected$SAMPLE_PK,eval(as.name(namePK)))))) #Get and store the subset of detected residue results matching the primary keys for the variety.
  
  assign(nameResidue, eval(as.name(nameResidue))[c("SAMPLE_PK","Pestcode","CONCEN")]) #Only retain the primary key, pesticide code, and residue concentration columns in the data frame as they are the only ones relevant for this part of the analysis.
  
  cat(i, rownames(stat_14_varieties)[i],"\n") #Print the current iteration number and name of variety.
  print(summary(eval(as.name(nameResidue))[c("Pestcode","CONCEN")])) #Print summary statistics of pesticides and concentration values for the variety.
  cat("Std Dev:",sd(eval(as.name(nameResidue))$CONCEN), "\n\n") #Print standard deviation of concentration for this variety.
  
  variety_14_avgPestcode <- c(variety_14_avgPestcode, round(length(eval(as.name(nameResidue))$Pestcode)/length(eval(as.name(namePK))), 3)) #calculate average number of pesticides per sample for the variety (rounding to 3 decimal places), and store it in a variable to be later appended to the stat_14_varieties data frame.
  variety_14_avgCONCEN <- c(variety_14_avgCONCEN, round(mean(eval(as.name(nameResidue))$CONCEN), 3)) #calculate average concentration amount for the variety (rounding to 3 decimal places), and store it in a variable to be later appended to the stat_14_varieties data frame.
}

stat_14_varieties <- data.frame(stat_14_varieties, variety_14_avgPestcode, variety_14_avgCONCEN) #appending the vectors for average # of pesticides and average concentration to the stat_14_varieties data frame.
colnames(stat_14_varieties) <- c("Frequency", "Percentage", "Avg # of Pesticides","Avg Concentration") #Update the headers for the data frame columns for clarification.

##--------------------------------------------------------------------------------------

##By state filtering & calculations:
##Create subsets of pesticide data by state via matching state names from the frequency list previously created (stored as rownames) with Samples_2014_Regular$STATE, getting a list of primary key values for samples produced in that state, then match those primary key values to Results_2014_Regular_Detected$SAMPLE_PK so the corresponding pesticide codes and concentrations can be pulled from the test results of detected residues for 2014.

for(i in 1:length(stat_14_states$Frequency)) #Go through the same process below for all states using a 'for' loop that matches the number of different states (9 in total).
{ 
  namePK <- paste0("state_14_PK_", i) #Generate a string for naming the variable that will store primary keys matching the state.
  nameResidue <- paste0("state_14_Res_", i) #Generate a string for naming the variable to hold pesticide and concentration results data that match the state.
  
  assign(namePK, subset(Samples_2014_Regular$SAMPLE_PK, Samples_2014_Regular$STATE == rownames(stat_14_states)[i])) #Get and store the primary keys for samples matching the state,
  assign(nameResidue, subset(Results_2014_Regular_Detected, !is.na(match(Results_2014_Regular_Detected$SAMPLE_PK,eval(as.name(namePK)))))) #Get and store the subset of detected residue results matching the primary keys for the state.
  
  assign(nameResidue, eval(as.name(nameResidue))[c("SAMPLE_PK","Pestcode","CONCEN")]) #Only retain the primary key, pesticide code, and residue concentration columns in the data frame as they are the only ones relevant for this part of the analysis.
  
  cat(i, rownames(stat_14_states)[i],"\n") #Print the current iteration number and state.
  print(summary(eval(as.name(nameResidue))[c("Pestcode","CONCEN")]))  #Print summary statistics of pesticides and concentration values for the state.
  cat("Std Dev:",sd(eval(as.name(nameResidue))$CONCEN), "\n\n") #Print standard deviation of concentration for this state.
  
  state_14_avgPestcode <- c(state_14_avgPestcode, round(length(eval(as.name(nameResidue))$Pestcode)/length(eval(as.name(namePK))), 3)) #calculate average number of pesticides per sample for the state (rounding to 3 decimal places), and store it in a variable to be later appended to the stat_14_states data frame.
  state_14_avgCONCEN <- c(state_14_avgCONCEN, round(mean(eval(as.name(nameResidue))$CONCEN), 3)) #calculate average concentration amount for the state (rounding to 3 decimal places), and store it in a variable to be later appended to the stat_14_states data frame.
}

stat_14_states <- data.frame(stat_14_states, state_14_avgPestcode, state_14_avgCONCEN) #appending the vectors for average # of pesticides and average concentration to the stat_14_state data frame.
colnames(stat_14_states) <- c("Frequency", "Percentage", "Avg # of Pesticides","Avg Concentration") #Update the headers for the data frame columns for clarification.

##--------------------------------------------------------------------------------------

##By grade label filtering & calculations:
##Separate samples with or without high grade labels and calculate the corresponding average pesticide numbers and concentration amounts. 

highGrade_14_PK <- subset(Samples_2014_Regular$SAMPLE_PK, Samples_2014_Regular$GRADE != "") #Find and store the primary keys of samples with high grade labels (where they don't have an empty GRADE value).
highGrade_14_Pestcode <- subset(Results_2014_Regular_Detected$Pestcode, !is.na(match(Results_2014_Regular_Detected$SAMPLE_PK,highGrade_14_PK))) #Pesticide results matching sample primary keys with high grade labels.
highGrade_14_CONCEN <- subset(Results_2014_Regular_Detected$CONCEN, !is.na(match(Results_2014_Regular_Detected$SAMPLE_PK,highGrade_14_PK))) #concentration results matching sample primary keys with high grade labels.

lowGrade_14_PK <- subset(Samples_2014_Regular$SAMPLE_PK, Samples_2014_Regular$GRADE == "") #Find and store the primary keys of samples without high grade labels.
lowGrade_14_Pestcode <- subset(Results_2014_Regular_Detected$Pestcode, !is.na(match(Results_2014_Regular_Detected$SAMPLE_PK,lowGrade_14_PK))) #Pesticide results matching sample primary keys without high grade labels.
lowGrade_14_CONCEN <- subset(Results_2014_Regular_Detected$CONCEN, !is.na(match(Results_2014_Regular_Detected$SAMPLE_PK,lowGrade_14_PK))) #concentration results matching sample primary keys without high grade labels.

##Print the statistics of the concentration amount for samples with and without high grade labels, respectively.

cat("Statistics - Residue Concentration in Fancy Grade Samples\n") #Print label for the statistics below.
print(summary(highGrade_14_CONCEN)) #Print basic statistics for concentration found in high grade samples.
cat("Std Dev:",sd(highGrade_14_CONCEN),"\n\n") #Print the standard deviation for these samples.

cat("Statistics - Residue Concentration in Normal Grade Samples\n") #Print label for the statistics below.
print(summary(lowGrade_14_CONCEN)) #Print basic statistics for concentration found in normal grade samples.
cat("Std Dev:",sd(lowGrade_14_CONCEN), "\n\n") #Print the standard deviation for these samples.

stat_14_grade <- data.frame(length(highGrade_14_PK), round(length(highGrade_14_Pestcode)/length(highGrade_14_PK),3), round(mean(highGrade_14_CONCEN),3)) #Create data frame with # of samples with high grade labels, average number of pesticides found per such sample (rounded to 3 decimal places), and the average residue concentration amount (rounded to 3 decimal places) for those samples.
colnames(stat_14_grade) <- c("# of Samples", "Avg # of Pesticides", "Avg Concentration") #Rename column headers for clarification.

tempStat_14_lowGrade <- data.frame(length(lowGrade_14_PK), round(length(lowGrade_14_Pestcode)/length(lowGrade_14_PK), 3), round(mean(lowGrade_14_CONCEN), 3)) #store the same type of data as above for samples without high grade labels in a temporary data frame.
colnames(tempStat_14_lowGrade) <- c("# of Samples", "Avg # of Pesticides", "Avg Concentration")  #Rename column headers for clarification.

stat_14_grade <- rbind(stat_14_grade, tempStat_14_lowGrade ) #Merge the normal grade stats vertically as a new row into the data frame with the high grade stats.
rownames(stat_14_grade) <- c("High Grade", "Normal Grade") #Rename row labels for clarification.

##======================================================================================

##This section of the code is for looking into residue differences between 2014 and 2004, and conventional versus organic.

#Load plyr to enable count function. Put inside an if (!require()) condition to install the package if it is not already installed, then run library() to load the package again afterwards to make sure it is installed and loaded successfully.
if (suppressWarnings(!require("plyr"))) {
  install.packages("plyr")
}
library(plyr)

# 1) Find the most frequently appearing pesticides in the 2014 data with corresponding average concentrations.

# 1)a. Find the pesticide statistics for all 2014 samples with detected pesticides. The resulting data frame "pest_summary_14"
# shows all pesticides in the 2014 data in decreasing order of frequency and their average concentrations.

attach(Results_2014_Detected)

pest_data_14 <- data.frame(subset(Results_2014_Detected, select = c(Pestcode, CONCEN))) #Create a subset of the 2014 data with only the columns with pesticide code and concentration.
pest_data_14 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_14)) #Group the pesticide data by Pestcode and find the average concentration for each pesticide.
pest_data_14$CONCEN <- round(pest_data_14$CONCEN,3) #Round the average concentration to 3 decimal places.
pest_data_14 <- data.frame(pest_data_14, count(Pestcode)) #Add a column with the frequency of each pesticide.
pest_data_14$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_14 <- pest_data_14[order(-pest_data_14$freq),] #Create a dataframe with pesticide data in decreasing order of frequency.
colnames(pest_summary_14) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2014_Detected)

# 1)b. Repeat the process for organic 2014 samples - find the most frequently appearing pesticides and corresponding average concentrations.
# and store the results in the data frame "pest_summary_org_14".

attach(Results_2014_Organic_Detected)

pest_data_org_14 <- data.frame(subset(Results_2014_Organic_Detected, select = c(Pestcode, CONCEN))) #Create a subset with only pesticide and concentration data.
pest_data_org_14 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_org_14)) #Find the average concentration for each pesticide.
pest_data_org_14$CONCEN <- round(pest_data_org_14$CONCEN,3) #Round the average concentration to 3 decimal places.
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
pest_data_reg_14$CONCEN <- round(pest_data_reg_14$CONCEN,3) #Round the average concentration to 3 decimal places.
pest_data_reg_14 <- data.frame(pest_data_reg_14, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_reg_14$x <-  NULL #Remove redundant "Pestcode" column.
pest_summary_reg_14 <- pest_data_reg_14[order(-pest_data_reg_14$freq),] #Create dataframe with samples appearing in decreasing order of frequency.
colnames(pest_summary_reg_14) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2014_Regular_Detected)

# 2) Repeat the process for the 2004 data - find the most frequently appearing pesticides and their corresponding average concentrations.

# 2)a. Find most frequently appearing pesticides and average concentrations for all 2004 samples with detected pesticides 
# and store the results in the data frame "pest_summary_04".

attach(Results_2004_Detected)

pest_data_04 <- data.frame(subset(Results_2004_Detected, select = c(Pestcode, CONCEN))) #Create a subset with only pesticide and concentration data.
pest_data_04 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_04)) #Find the average concentration for each pesticide.
pest_data_04$CONCEN <- round(pest_data_04$CONCEN,3) #round the average concentration to 3 decimal places.
pest_data_04 <- data.frame(pest_data_04, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_04$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_04 <- pest_data_04[order(-pest_data_04$freq),]
colnames(pest_summary_04) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2004_Detected)

# 2)b. Repeat the process for organic 2004 samples - find the most frequently appearing pesticide and their average concentrations
#and store the results in the data frame "pest_summary_org_04".

attach(Results_2004_Organic_Detected)

pest_data_org_04 <- data.frame(subset(Results_2004_Organic_Detected, select = c(Pestcode, CONCEN))) #Create a subset with only pesticide and concentration data.
pest_data_org_04 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_org_04)) #Find the average concentration for each pesticide.
pest_data_org_04$CONCEN <- round(pest_data_org_04$CONCEN,3) #round the average concentration to 3 decimal places.
pest_data_org_04 <- data.frame(pest_data_org_04, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_org_04$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_org_04 <- pest_data_org_04[order(-pest_data_org_04$freq),] #Create dataframe with samples appearing in decreasing order of frequency.
colnames(pest_summary_org_04) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2004_Organic_Detected)

# 2) c. Repeat the process for regular 2004 samples - find the most frequently appearing pesticide and their average concentrations.
# Store the results in the data frame "pest_summary_reg_04".

attach(Results_2004_Regular_Detected)

pest_data_reg_04 <- data.frame(subset(Results_2004_Regular_Detected, select = c(Pestcode, CONCEN))) #Create a subset with only pesticide and concentration data.
pest_data_reg_04 <- as.data.frame(aggregate(CONCEN ~ Pestcode, FUN = mean, data = pest_data_04)) #Find the average concentration for each pesticide.
pest_data_reg_04$CONCEN <- round(pest_data_reg_04$CONCEN,3) #round the average concentration to 3 decimal places.
pest_data_reg_04 <- data.frame(pest_data_reg_04, count(Pestcode)) #Add a column for pesticide frequency.
pest_data_reg_04$x <- NULL #Remove redundant "Pestcode" column.
pest_summary_reg_04 <- pest_data_reg_04[order(-pest_data_reg_04$freq),] #Create dataframe with samples appearing in decreasing order of frequency.
colnames(pest_summary_reg_04) <- c("Pestcode", "Average Concentration", "Frequency")

detach(Results_2004_Regular_Detected)

# 3. Find percentage of all 2004 and 2014 samples with detected pesticides; 
# Repeat the process for regular samples and organic samples.

# 3)a. Find the number of samples with detected pesticides for each year. 

#Number of samples with detected pesticides for all 2004 and 2014 data:

x <- count(unique(Results_2014_Detected$SAMPLE_PK)) #Returns a data frame with a row for each 2014 sample with detected pesticide.
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
num_reg_samples_14 <- sum(count(Samples_2014_Regular$SAMPLE_PK)$freq) #Gives the total number of 2014 regular samples.
num_reg_samples_04 <- sum(count(Samples_2004_Regular$SAMPLE_PK)$freq) #Gives the total number of 2014 regular samples.

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

Percent_Organic <- c(percent_detected_org_14, percent_detected_org_04) #Organic samples.
Percent_Regular <- c(percent_detected_reg_14, percent_detected_reg_04) #Regular samples.
Percent_All <- c(percent_detected_14, percent_detected_04) #All samples regardless of pesticide claims.

Percent_Detected_Samples <- data.frame(Year = c(2014, 2004), Percent_All, Percent_Regular, Percent_Organic) #Combine the 3 vectors above into a data frame.

##--------------------------------------------------------------------------------------

##Basic statistics for this section - print summary statistics for the 6 pesticide frequency and average concentration data subsets created above, with the corresponding standard deviation for average concentration.

# basic statistics for the 2014 pesticide frequency and average concentration data subset.
cat("Statistics - 2014 Pesticide Frequency and Average Concentration\n") #Print title for the statistics below.
print(summary(pest_summary_14)) #Print summary statistics.
cat("Std Dev:",sd(pest_summary_14$`Average Concentration`),"\n\n") #Print the standard deviation for the average concentration.

# basic statistics for the 2004 pesticide frequency and average concentration data subset.
cat("Statistics - 2004 Pesticide Frequency and Average Concentration\n") #Print title for the statistics below.
print(summary(pest_summary_04)) #Print basic statistics for the 2004 pesticide frequency and average concentration data subset.
cat("Std Dev:",sd(pest_summary_04$`Average Concentration`),"\n\n") #Print the standard deviation for the average concentration.

# basic statistics for the 2014 organic sample pesticide frequency and average concentration data subset.
cat("Statistics - 2014 Organic Pesticide Frequency and Average Concentration\n") #Print title for the statistics below.
print(summary(pest_summary_org_14)) #Print summary statistics.
cat("Std Dev:",sd(pest_summary_org_14$`Average Concentration`),"\n\n") #Print the standard deviation for the average concentration.

# basic statistics for the 2004 organic sample pesticide frequency and average concentration data subset.
cat("Statistics - 2004 Organic Pesticide Frequency and Average Concentration\n") #Print title for the statistics below.
print(summary(pest_summary_org_04)) #Print basic statistics for the 2004 pesticide frequency and average concentration data subset.
cat("Std Dev:",sd(pest_summary_org_04$`Average Concentration`),"\n\n") #Print the standard deviation for the average concentration.

# basic statistics for the 2014 conventional sample pesticide frequency and average concentration data subset.
cat("Statistics - 2014 Conventional Pesticide Frequency and Average Concentration\n") #Print title for the statistics below.
print(summary(pest_summary_reg_14)) #Print summary statistics.
cat("Std Dev:",sd(pest_summary_reg_14$`Average Concentration`),"\n\n") #Print the standard deviation for the average concentration.

# basic statistics for the 2004 conventional sample pesticide frequency and average concentration data subset.
cat("Statistics - 2004 Conventional Pesticide Frequency and Average Concentration\n") #Print title for the statistics below.
print(summary(pest_summary_reg_04)) #Print basic statistics for the 2004 pesticide frequency and average concentration data subset.
cat("Std Dev:",sd(pest_summary_reg_04$`Average Concentration`),"\n\n") #Print the standard deviation for the average concentration.
##This is a work-in-progress script for Eris
##To be merged with other sections near the end of the scripting phase.

##--------------------------------------------------------------------------------------

#Set working directory to the directory of this R script, which also contains all the required csv data files and all other R scripts for this project (placed inside "if" condition in case this script is called from another R script where the working directory had already been set).
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

#Source the AnalysisSetup.R script to perform data importing and setup, and prep for running the analysis scripts below. May be removed during script merge later in the phase.
source("AnalysisSetup.R")

##--------------------------------------------------------------------------------------

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

highGrade_14_PK <- subset(Samples_2014_Regular$SAMPLE_PK, Samples_2014_Regular$GRADE != "") #Find and store the primary keys of samples with high grade labels.
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
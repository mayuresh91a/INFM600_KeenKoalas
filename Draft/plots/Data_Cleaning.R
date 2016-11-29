## This script is for cleaning the data for pesticide concentration information of apples. 
## This will clean the data present in the CSV files converted from the excel sheets for the years 2014 and 2004.

# set working directory to the directory of this R script, which also contains all the required csv files (placed inside "if" condition in case this script is called from another R script where the working directory had already been set)
if (!exists("wd")) {
  wd <- dirname(parent.frame(2)$ofile)
  setwd(wd)
}

Samples_2014 <- read.csv("Datasets/Apples_Sample14.csv")   # Read the csv file containing the Samples data for apples from the year 2014

Samples_2004 <- read.csv("Datasets/Sampleapples04.csv")    # Read the csv file containing the Samples data for apples from the year 2004

Results_2014 <- read.csv("Datasets/Apples_Results14.csv")   # Read the csv file containing the Results data for apples from the year 2014

Results_2004 <- read.csv("Datasets/ResultsApples04.csv")    # Read the csv file containing the Results data for apples from the year 2004

## Replace the country codes in 'ORIGIN' attribute with actual country names in preparation for removing the COUNTRY attribute.
#For 2014 Samples data
Samples_2014$ORIGIN[ is.na(Samples_2014$COUNTRY)] <- "United States"
Samples_2014$ORIGIN[ Samples_2014$COUNTRY == '660'] <- "New Zealand"

#For 2004 Samples data
Samples_2004$ORIGIN[ Samples_2004$ORIGIN == '1'] <- "United States"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == '660'] <- "New Zealand"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == '275'] <- "Chile"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == '260'] <- "Canada"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == 'UNK'] <- "Unknown"
Samples_2004$ORIGIN[ Samples_2004$ORIGIN == '3'] <- "Unknown"

## Dropping the COUNTRY attribute as well as the variables SOURCE_ID, DISTST, PACKST, and GROWST due to lack of relevance to research question and incompleteness of values.
#For 2014 Samples data
Samples_2014$SOURCE_ID<- NULL
Samples_2014$COUNTRY<- NULL
Samples_2014$DISTST<- NULL
Samples_2014$PACKST<- NULL
Samples_2014$GROWST<- NULL

#For 2004 Samples data
Samples_2004$SOURCE_ID<- NULL
Samples_2004$COUNTRY<- NULL
Samples_2004$DISTST<- NULL
Samples_2004$PACKST<- NULL
Samples_2004$GROWST<- NULL

## For Results data, remove the columns CONFMETHOD2, ANNOTATE, QUANTITATE as these 3 attributes are blank for all 38792 rows

#For 2004 Results data
Results_2004$CONFMETHOD2<-NULL
Results_2004$ANNOTATE<-NULL
Results_2004$QUANTITATE<-NULL

#For 2014 Results data
Results_2014$CONFMETHOD2<-NULL
Results_2014$ANNOTATE<-NULL
Results_2014$QUANTITATE<-NULL




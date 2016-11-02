## This script is for cleaning the data for pesticide concentration information of apples. 
## This while will clean the data present in the two excel sheets ApplesResults_2014.xsls and ApplesSamples_2014.xsls

setwd("C:/D/INFM600") # set working directory to the directory with all the required csv files.

Samples_2014 <- read.csv("Apples_Sample14.csv")   # Read the csv file containing the Samples data for apples from the year 2014

Samples_2004 <- read.csv("Sampleapples04.csv")    # Read the csv file containing the Samples data for apples from the year 2004

Results_2014 <- read.csv("Apples_Results14.csv")   # Read the csv file containing the Results data for apples from the year 2014

Results_2004 <- read.csv("ResultsApples04.csv")    # Read the csv file containing the Results data for apples from the year 2004

## As we are removing attribute Country, Replace the country codes in 'Origin' attribute with actual country names.

#For 2014 Samples data
Samples_2014$ORIGIN[ is.na(Samples_2014$COUNTRY)] <- "United States"
Samples_2014$ORIGIN[ Samples_2014$COUNTRY == '660'] <- "New Zealand"

#For 2004 Samples data
Samples_2004$ORIGIN[ Samples_2004$ORIGIN == '1'] <- "United States"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == '660'] <- "New Zealand"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == '275'] <- "Chile"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == '260'] <- "Canada"
Samples_2004$ORIGIN[ Samples_2004$COUNTRY == 'UNK'] <- "Unkown"

Samples_2014$SOURCE_ID<- NULL
Samples_2014$COUNTRY<- NULL
Samples_2014$DISTST<- NULL
Samples_2014$PACKST<- NULL
Samples_2014$GROWST<- NULL

Samples_2004$SOURCE_ID<- NULL
Samples_2004$COUNTRY<- NULL
Samples_2004$DISTST<- NULL
Samples_2004$PACKST<- NULL
Samples_2004$GROWST<- NULL

## For Results data, remove the columns CONFMETHOD2, ANNOTATE, QUANTITATE as the values for these 3 attributes is blank for all 38792 rows

#For 2004 Results data

Results_2004$CONFMETHOD2<-NULL
Results_2004$ANNOTATE<-NULL
Results_2004$QUANTITATE<-NULL

#For 2014 Results data
Results_2014$CONFMETHOD2<-NULL
Results_2014$ANNOTATE<-NULL
Results_2014$QUANTITATE<-NULL




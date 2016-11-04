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

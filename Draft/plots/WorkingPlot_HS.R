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

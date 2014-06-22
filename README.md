RunAnalysis
===========

ThisRepository is for the Run Analysis Project which is a part of the "Getting and Cleaning Data" course from the Data Science specialization in Coursera

This file describes how run_analysis.R script works.

1. First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and copy all the 8 files required for the script into the working directory of R. Make sure all the below mentioned files and the run_analysis.R script are both in the present working directory.
  1. subject_train.txt
  2. subject_test.txt
  3. activity_labels.txt
  4. features.txt
  5. X_train.txt
  6. y_train.txt
  7. X_test.txt
  8. y_test.txt
2. Second, use source("run_analysis.R") command in RStudio.
3. Third, you will find two output files are generated in the current working directory:
  1. run_analysis_merged_output.txt (7.89 Mb): it contains the data from a data frame with 10299*68 dimension.
  2. run_analysis_final_output.txt (220 Kb): it contains the data from a data frame with 180*68 dimension.
4. Finally, use data <- read.table("run_analysis_final_output.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.

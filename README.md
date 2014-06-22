Get_Clean_Data_Project
======================

## Course project for Getting and Cleaning data course offered on coursera.

### To run the run_analysis.R script:

* Download the data folder from the link on the course website, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

* Change the setwd() line of code at the beginning of the R script to match your working directory.

* When you source the code, it will automatically place the tidy dataset in your working directory.

### What run_analysis.R actually does:

* Pulls in the test and training datasets (X_test.txt and X_train.txt)

* Adds descriptive variable names to both datasets (features.txt)

* Pulls in and adds columns for subject and test name (subject_test.txt, y_test.txt, subject_train.txt, y_train.txt)

* Converts the test numbers into descriptive labels (activity_labels.txt)

* Consolidates the test and training datasets into 1 dataset

* Limits to columns that only contain "mean()" or "std()"

* Finds the average of the remaining variables for each subject/activity combination
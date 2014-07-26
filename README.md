## Read me for run_analysis.R code 
=========

This code file assumes that "getdata_projectfiles_UCI HAR Dataset.zip" has been downloaded and unzipped in the same directory as run_analysis.R.

The code consists of the following functions:

* run_analysis() - The main function which holds necessary data frames for "train" and "test" data sets, combines them and then extracts only the readings for mean and std deviation, add descriptive names for the activities and labels for all columns and finally calculates the mean of all readings by subject and activity

* msd_index() - Function that creates a index of columns which contain the mean and standard deviation readings for various measures in the data set

* readTrainFiles() - Function that reads the training dataset and adds the activity and subject fields

* readTestFiles() - Function that reads the test dataset and adds the activity and subject fields

* readLabels() - Function that takes the file name as a parameter to read the descriptive labels for activties and column headers

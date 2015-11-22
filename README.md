# Getting-and-Cleaning-Data-Course-Project
Purpose of this Project - creating tidy datasets of measurements with using raw data sets.
Raw data sources:
1. ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/ - readme, description of features and activity labels
2. ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/ - raw data for train
3. ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/ - raw data for test

You can use run_analysis.R for transform raw datasets to the target tidy dataset.
For using the script you should to do the next steps:
1. Create special folder for work with this data
2. Copy raw datasets (folder "getdata_projectfiles_UCI HAR Dataset") from this repo to your directory (with saving of structure of folders)
3. Copy run_analysis.R to your folder
4. Run run_analysis.R with using R or RStudio
5. Result of work of the script is two tidy datasets:
*. data_summary - a dataset with the measurements on the mean and standard deviation for each measurement for all subject, all activities and all types of data (test and train)
*. data_mean - a tidy dataset with the average of each variable for each activity and each subject from the dataset data_summary. 

Description of target datasets you can find in codebook.md in this repo.

Main steps of the script (you can finв more detail comments in the text of the script):
1. Checking libraries (data.table, dplyr) that are required for work of the script.
2. Uploading raw data:
*. 
3. 




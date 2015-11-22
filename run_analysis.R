## Checking and loading of R packages data.table and dplyr
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}

pkgTest("data.table")
pkgTest("dplyr")

library(data.table)
library(dplyr)

## Defining path to file with raw data for train data set
fp_X_train <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
fp_Y_train <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"
fp_Subject_train <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"

## uploading raw data for train data set
data_X_train <- fread(fp_X_train, sep = " ")
data_Y_train <- read.table(fp_Y_train, sep = " ")
data_Subject_train <- read.table(fp_Subject_train, sep = " ")

## Defining path to file with row data for test data set
fp_X_test <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
fp_Y_test <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"
fp_Subject_test <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"

## uploading raw data for test data set
data_X_test <- fread(fp_X_test, sep = " ")
data_Y_test <- read.table(fp_Y_test, sep = " ")
data_Subject_test <- read.table(fp_Subject_test, sep = " ")

## uploading column names
fp_features <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"
data_features <- read.table(fp_features, sep = " ", stringsAsFactors = FALSE)

## defining of variable names for measurements (train and test data sets)
colnames(data_X_train) <- data_features$V2
colnames(data_X_test) <- data_features$V2

## selecting column with mean and std. I excluded variables like *meanFreq*.
data_X_train_filtered <- subset(data_X_train, select = grep("*mean*[/(]|*std*", names(data_X_train)))
data_X_test_filtered <- subset(data_X_test, select = grep("*mean*[/(]|*std*", names(data_X_test)))

## defining of variable names for activities and subjects (train and test data sets)
colnames(data_Y_train) <- "Activity"
colnames(data_Y_test) <- "Activity"
colnames(data_Subject_train) <- "Subject"
colnames(data_Subject_test) <- "Subject"

## defining new column with variables "Dataset". This variable matches type of measurement (test or train)
data_X_train <- as.data.frame(append(data_X_train, "train", after = 0))
data_X_test <- as.data.frame(append(data_X_test, "test", after = 0))
names(data_X_train)[1] <- "Dataset"
names(data_X_test)[1] <- "Dataset"

## Creating combined datasets for train and for test data separately
data_train <- cbind(data_Subject_train, data_Y_train, data_X_train)
data_test <- cbind(data_Subject_test, data_Y_test, data_X_test)

## Creating combined dataset with data from test and train datasets
data_summary <- rbind(data_train, data_test)

## Uploading data set with ID and labels of activities. Changing class for variable ID
data_summary$Activity <- as.character(data_summary$Activity)
fp_activity_labels <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
data_activity_levels <- read.table(fp_activity_labels, sep = " ", stringsAsFactors = FALSE)
data_activity_levels$V1 <- as.character(data_activity_levels$V1)

## Changing ID of activities to label of activities. 
for (i in 1:length(data_summary$Activity)) {
  for (j in 1:length(data_activity_levels$V1)) {
    if (data_summary$Activity[i] == data_activity_levels$V1[j]) data_summary$Activity[i] <- data_activity_levels$V2[j]}
}

## The result of the code above is the result of tasks 1-4 (Course Project)
## data_summary is the resulting dataset for this tasks.

## Creating a dataset for the task 5 of the Course Project. I select only columns with subject, activity and measurements. 
## Then I group the dataset by Subject and By Activity.
## Then I use the function summarise_each for calculation of the average of each variable for each activity and each subject
## data_mean is the resulting dataset for the task 5.
data_mean <- select(data_summary, -Dataset)
data_mean <- group_by(data_mean, Subject, Activity)
data_mean <- summarise_each(data_mean, funs(mean))
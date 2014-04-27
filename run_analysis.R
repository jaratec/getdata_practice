# 0. Assumptions/Preparations:
# The zip file containing the training and test data has been extracted.
# The R working directory is the folder containing the unzipped data. "UCI HAR Dataset" is thus a subfolder in the working directory
# This script (run_analysis.R) should be copied to the working directory and run.

# 1. Merges the training and the test sets to create one data set.
# Reads files. Along the way it:
# - filters data in order to retain only means and standard deviations.
# - gives proper names to dataframe columns.
# - transforms activity codes to activity names
#
# Files needed:
# activity_labels.txt is the mapping between activity codes (1-6) and activity names
# (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
# features.txt contains the names/labels of measurements (561-feature vector);
# the measurements (see below) have the same order as the measurements names;
# the mapping between the names and the measurements is:
# number of row for names - number of column for measurements
# X_train.txt and X_test.txt are the files containing the measurements; each row has 561 columns
# subject_train.txt and subject_test.txt are the files identifying the subjects (1-30)
# y_train.txt and y_test.txt are the files indentifying the activities (codes 1-6)

# Reads common files
features <- read.table("./UCI HAR Dataset/features.txt")
colnames(features) <- c("code", "name") # adds column names to dataframes
standards_and_means <- c(grep("mean\\(\\)", features$name), grep("std\\(\\)", features$name)) # selects codes for *mean()* and *std()* features
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("code", "name")

# Reads training files
training_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(training_subjects) <- c("subject")
training_activities_raw <- read.table("./UCI HAR Dataset/train/y_train.txt")
colnames(training_activities_raw) <- c("code")
training_activities <- data.frame(activity=sapply(training_activities_raw$code, function(x) activities[activities$code == x,]$name)) # maps activity codes to activity names
training_measurements <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(training_measurements) <- features$name
training_measurements <- training_measurements[,standards_and_means] # filters (retains) columns with *mean()* and *std()*
training_data <- cbind(training_subjects, training_activities, training_measurements) # creates new dataframe

# Reads test files (same as for training)
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(test_subjects) <- c("subject")
test_activities_raw <- read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(test_activities_raw) <- c("code")
test_activities <- data.frame(activity=sapply(test_activities_raw$code, function(x) activities[activities$code == x,]$name))
test_measurements <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test_measurements) <- features$name
test_measurements <- test_measurements[,standards_and_means]
test_data <- cbind(test_subjects, test_activities, test_measurements)

# Merges training and test datasets
merged_data <- rbind(training_data, test_data)
column_names <- names(merged_data)
write.csv(merged_data, file="./merged_data.csv", row.names=F) # saves intermediary dataset
 
# 2. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# In other words, it groups the dataset on subject and activity and averages each variable in the group.
tidy_data <- aggregate(merged_data[,3:68], list(merged_data$subject, merged_data$activity), mean)
colnames(tidy_data) <- column_names # rename the first two columns (used as grouping factor) back to initial names (subject, activity)
write.csv(tidy_data, file="./tidy_data.csv", row.names=F)


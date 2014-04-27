Getting and Cleaning Data - R practice
---

This project works on a public dataset [1]. The dataset can be downloaded from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A description of the original project can be found at this [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The data contains smartphone measurements from 30 subjects. 6 activities were considered for the subjects. The goal of the original study is to use (supervised) machine learning techniques in order to categorize the subject activity from the smartphone measurements.

This project has a more modest goal. It merges the training and test dataset. It keeps only mean and standard deviation variables of the measurement data. It then averages on groups of subjects and activities. The script run_analysis.R achieves these data manipulations. It is assumed that the original dataset has been downloaded and unzipped in a suitable location. The R script should be placed in the same folder as the dataset and the working directory for R should be set to this folder. Running the script will produce 2 csv files, one for the merged data and one for the grouping and averaging data. All the processing steps are documented in the comments of the script. Accompanying the R script, there is a mini-codebook: CodeBook.md, which describes the variables in the final dataset.


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

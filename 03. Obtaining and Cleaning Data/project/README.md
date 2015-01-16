##Getting and Cleaning Data - Course Project
###Data reading
Setting Working Directory

```r
setwd("~/coursera/03. Obtaining and Cleaning Data/project")
```
  
reading test files

```r
x_test <- read.table(".//UCI HAR Dataset//test//X_test.txt", header=FALSE, sep="")
y_test <- read.table(".//UCI HAR Dataset//test//y_test.txt", header=FALSE, sep="")
subject_test <- read.table(".//UCI HAR Dataset//test//subject_test.txt", header=FALSE, sep="")
```
  
reading train files

```r
x_train <- read.table(".//UCI HAR Dataset//train//X_train.txt", header=FALSE, sep="")
y_train <- read.table(".//UCI HAR Dataset//train//y_train.txt", header=FALSE, sep="")
subject_train <- read.table(".//UCI HAR Dataset//train//subject_train.txt", header=FALSE, sep="")
```
  
###Merges the training and the test sets to create one data set. (Step 1)
column binding test and train files

```r
df_test <- cbind(subject_test, y_test, x_test)
df_train <- cbind(subject_train, y_train, x_train)
```
  
row binding test and train files

```r
df <- rbind(df_train, df_test)
```
  
reading feature file

```r
features <- read.table(".//UCI HAR Dataset//features.txt", header=FALSE, sep="", stringsAsFactors=F)[,2]
```
  
assigning names to data frame

```r
names(df) <- c("Subject", "Activity", features)
```
  
###selecting columns which have mean or std (Step 2)
\\ escape to get the subsequent character for matching. \\(\\) will look for () in strings. This chunk of code is trying to get the column number of column names containing mean() or std(). They are then combined with column 1 and 2 as those are Subject and Activity markers.

```r
colID <- grep("(mean|std)\\(\\)", names(df))
colID <- c(1:2, colID)
df <- df[, colID]
```
  
reading activity label files

```r
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=F)
names(activity_labels) <- c("id", "label")
```
  
###Uses descriptive activity names to name the activities in the data set (Step 3)
As activity number is sequenced the same as row number, we can use the activity number as row_num for the activity_labels data frame. 

```r
df$Activity <- activity_labels[df$Activity, 2]
```
  
###Appropriately labels the data set with descriptive variable names.  (Step 4)

```r
col_names <- names(df)
col_names <- gsub("\\(\\)", "", col_names)
col_names <- gsub("-", "", col_names)
col_names <- gsub("BodyBody", "Body", col_names)
col_names <- gsub("^t", "Time", col_names)
col_names <- gsub("^f", "Frequency", col_names)
col_names <- gsub("Acc", "Accelerometer", col_names)
col_names <- gsub("Gyro", "Gyroscope", col_names)
col_names <- gsub("Mag", "Magnitude", col_names)
col_names <- gsub("mean", "Mean", col_names)
col_names <- gsub("std", "StandardDeviation", col_names)
```
  
reassigning names

```r
names(df) <- col_names
```
  
###calculating average of each variable for each activity and each subject (Step 5)
aggregate all other columns by Subject and Activity on the dataset df and perform mean function.

```r
agg_df <- aggregate(.~Subject+Activity, df, mean)
```
  
writing to txt file for future processing

```r
write.table(agg_df, ".//tidy_data.txt", row.names=F)
```

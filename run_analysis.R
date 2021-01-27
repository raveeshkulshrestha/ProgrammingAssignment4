## Getting and cleaning data - week 4 assignment

## get the activity label
activity_labels <- read.table(file="./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity.id", "activity")

## get column names of the set
col_names <- read.table(file="./UCI HAR Dataset/features.txt") ## this file contains the name of 561 columns

## Test Set
subject_test <- read.table(file="./UCI HAR Dataset/test/subject_test.txt") ## dim 2947 1
x_test <- read.table(file="./UCI HAR Dataset/test/X_test.txt") ## dim 2947 561
y_test <- read.table(file="./UCI HAR Dataset/test/y_test.txt") ## dim 2947 1
## unique(subject_test[,1]) ## this gives the unique number of participants who performed the test
## unique testers were with ids - 2  4  9 10 12 13 18 20 24. This is 30% of 30 which is 9.

## create identifier columns - activity and subject
test_identifier_columns <- cbind(y_test, subject_test)
##colnames(test_identifier_columns) <- c("activity", "subject")

#combine the three test data frame
test_combo <- cbind(x_test,test_identifier_columns)  ## dim 2947 563

## the below script covers #3 and #4 of naming the columns
colnames(test_combo) <- c(col_names[,2], "activity", "subject")

# Train Set
subject_train <- read.table(file="./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table(file="./UCI HAR Dataset/train/X_train.txt") ## dim 7352 561
y_train <- read.table(file="./UCI HAR Dataset/train/y_train.txt") ## dim 7352 1
## unique(subject_train[,1]) ## this gives the unique number of participants who performed the training
## unique testers were with ids - 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30. 
## This is 70% of 30 which is 21.

## create identifier columns
train_identifier_columns <- cbind(y_train, subject_train)
##colnames(train_identifier_columns) <- c("activity", "subject")

## combine the three train data frame
train_combo <- cbind(x_train, train_identifier_columns) ## dim 7352 563

## the below script covers #3 and #4 of naming the columns
colnames(train_combo) <- c(col_names[,2], "activity", "subject")

## 1. Merge the test and train sets
merge_test_train <- rbind(test_combo, train_combo)

## 3 and 4. put detailed activity name in the above data set
merge_test_train[["activity"]] <- activity_labels[match(merge_test_train[['activity']], 
                                                        activity_labels[['activity.id']]), 'activity']

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## use the select function to pull out only the columns where name contain mean() and sd() in column name
merge_test_train_mean_sd <- select(merge_test_train, contains("mean()") | contains("std()") | 
                                     contains("activity") | contains('subject'))

## 5. Extract average of each column group by activity, subject
## below is used to summarize all columns except the group by columns
summarize_merge <- merge_test_train_mean_sd %>% group_by(activity, subject) %>% summarise(across(everything(), mean))

# write the output into a file if file not present
if(!file.exists("TidyDataOutput.txt")){
  write.table(summarize_merge, file = "TidyDataOutput.txt", row.names = FALSE)  
}


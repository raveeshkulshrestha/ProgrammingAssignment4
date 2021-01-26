##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##body_acc_x_test <- read.table(file="./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",
##                   header = TRUE)
## Test Set
subject_test <- read.table(file="./UCI HAR Dataset/test/subject_test.txt") ## dim 2947 1
x_test <- read.table(file="./UCI HAR Dataset/test/X_test.txt") ## dim 2947 561
y_test <- read.table(file="./UCI HAR Dataset/test/y_test.txt") ## dim 2947 1
## unique(subject_test[,1]) ## this gives the unique number of participants who performed the test
## unique testers were with ids - 2  4  9 10 12 13 18 20 24. This is 30% of 30 which is 9.

## get column names of the set
col_names <- read.table(file="./UCI HAR Dataset/features.txt")

## create identified columns
test_identifier_columns <- cbind(y_test, subject_test)
##colnames(test_identifier_columns) <- c("activity", "volunteer")

#combine the three test data frame
test_combo <- cbind(x_test,test_identifier_columns)  ## dim 2947 563
colnames(test_combo) <- c(col_names[,2], "activity", "volunteer")

# Train Set
subject_train <- read.table(file="./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table(file="./UCI HAR Dataset/train/X_train.txt") ## dim 7352 561
y_train <- read.table(file="./UCI HAR Dataset/train/y_train.txt") ## dim 7352 1
## unique(subject_train[,1]) ## this gives the unique number of participants who performed the training
## unique testers were with ids - 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30. 
## This is 70% of 30 which is 21.

## create identified columns
train_identifier_columns <- cbind(y_train, subject_train)
##colnames(train_identifier_columns) <- c("activity", "volunteer")

## combine the three train data frame
train_combo <- cbind(x_train, train_identifier_columns) ## dim 7352 563
colnames(train_combo) <- c(col_names[,2], "activity", "volunteer")

## 1. Merge the test and train sets
merge_test_train <- rbind(test_combo, train_combo)



# ProgrammingAssignment4
Codebook for week 4 assignment: Getting and Cleaning Data Assignment

Common Variables
==================
activity_labels: is a data frame loaded from the activity_labels.txt file. 
This data frame is used to include descriptive active name in the final
data set. 

col_names: is a data frame loaded from the features.txt file. This data
frame is used to include the feature names for all the columns in the train
and test data sets. In total there are 561 variables. Dimension of this data
frame is 561, 2

Test Set Variables
===================

subject_test: is a data frame loaded from the subject_test.txt file. This 
contains the list of subjects who performed the tests. The distinct count of 
these testers should be 30% of 30 which is 9. Dimension of this data frame
is 2947 1

x_test: is a data frame loaded from the x_test.txt file. This contains all
the measurements across 561 variables (columns). Dimension of this data frame
is 2947 561

y_test: is a data frame loaded from the y_test.txt file. This contains the 
activity short code against each measurement of x_test. Dimension of this data
frame is 2947 1

test_identifier_columns: in this data frame both the y_test and subject_test
data frames are merged. The purpose of creating this data frame is to later
merge this into the final data set over which group by activity and subject
is performed

test_combo: is a data frame where both x_test data frame is merged with 
test_identifier_columns data frame. Hence this is the final test set data
frame. Dimension of this data frame are 2947 563. Actual column count was 561
to which we add two more columns - activity and subject


Train Set Variables
=======================

subject_train: is a data frame loaded from the subject_train.txt file. This 
contains the list of subjects who performed the trainig. The distinct count of 
these testers should be 70% of 30 which is 21. Dimension of this data frame
is 7352 1

x_train: is a data frame loaded from the x_train.txt file. This contains all
the measurements across 561 variables (columns). Dimension of this data frame
is 7352 561

y_train: is a data frame loaded from the y_test.txt file. This contains the 
activity short code against each measurement of x_train. Dimension of this data
frame is 7352 1

train_identifier_columns: in this data frame both the y_train and subject_train
data frames are merged. The purpose of creating this data frame is to later
merge this into the final data set over which group by activity and subject
is performed

train_combo: is a data frame where both x_train data frame is merged with 
train_identifier_columns data frame. Hence this is the final train set data
frame. Dimension of this data frame are 7352 563. Actual column count was 561
to which we add two more columns - activity and subject

Output variables
================

merge_test_train: this is merged data frame between test_combo and train combo. 
Since both the test and train data frames had the same column names a simple
rbind expression worked. Dimension of this is 10299   563. Row count is 
simple addition of 2947+7352

merge_test_train_mean_sd: this data frame only selects the columns with mean
and standard deviation variables. Of course the identifier columns (activity 
and subject) also need to be present because the group by clause will be 
applied on them in the final step.

summarize_merge: this is the final data frame that groups the above data frame
by activity and then by subject and then for each measurement hold the average
of the mean and standard deviation columns.

Finally the data in the summarize_merge data frame is written into a txt file.


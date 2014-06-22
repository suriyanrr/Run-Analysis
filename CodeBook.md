Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  
* The site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
* The data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
1. It Checks for the existence of all the 8 files Read X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, subject_test.txt, activity_labels.txt and features.txt from the present working directory and store them as Data Frames in R respectively.
2. It then combines all of the test data files using the cbind command into an R data frame test_data. Similary it combines the data from all the training data files into train_data.
3. Then, it concatenates test_data to train_data to generate a 10299x561 data frame, dataset1.  
4. After that, it reads the features.txt file and stores the data in an R variable called data_colnames. This also includes the subjectID and the activityID which is not present in the features.txt. It then updates the column names of the dataset1 data frame with the values in the data_colnames vector.
5. We only need the measurements on the mean and standard deviation. This result which consists of 66 indices list is stored in a variable mean_std_features. Then this is used to subset the data with the corresponding 66 columns and the additional subjectID and activityID columns.
6. Then, it replaces all the activityID values in the dataset1 with the correspondin activity description from the activity_labels.txt. Finally this gives us the 10299x68 data frame which is our tidy dataset called dataset1.   
7. The Dataset1 data frame has the first two columns, "subjectID" and "activityDesc". The "subjectID" column contains integers that range from 1 to 30 inclusive; the "activityDesc" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.  
8. Write the dataset1 out to "run_analysis_merged_output.txt" file in current working directory.  
9. Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. In the end, we get a 180x68 data frame called dataset2.
10. Write the dataset2 data frame out to "run_analysis_final_output.txt" file in current working directory.

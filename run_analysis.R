run_analysis <- function() {

## The function does the following steps.
## 1. Merges the training and the test sets to create one data set.
## 2. Appropriately labels the data set with descriptive variable names. 
## 3. Extracts only the measurements on the mean and standard deviation 
##    for each measurement.
## 4. Uses descriptive activity names to name the activities in the data set
## 5. Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject. 

## Usage: output <- run_analysis(); View(output); 
       
## Loading all dependent packages

library(reshape2)

## Initializing all the required files

base_dir <- getwd()

subject_train <- paste(base_dir, "/subject_train.txt", sep = "")
subject_test <- paste(base_dir, "/subject_test.txt", sep = "")
activity_labels <- paste(base_dir, "/activity_labels.txt", sep = "")
features <- paste(base_dir, "/features.txt", sep = "")
X_train <- paste(base_dir, "/X_train.txt", sep = "")
Y_train <- paste(base_dir, "/y_train.txt", sep = "")
X_test <- paste(base_dir, "/X_test.txt", sep = "")
Y_test <- paste(base_dir, "/y_test.txt", sep = "")

## Validating the availability of all the necessary files

if(! file.exists(subject_train) |
   ! file.exists(subject_test) |
   ! file.exists(activity_labels) |
   ! file.exists(features) |
   ! file.exists(X_train) |
   ! file.exists(Y_train) |
   ! file.exists(X_test) |
   ! file.exists(Y_test)) {
        print("The working directory does not have all the required files.") 
        print("Please make sure all the below mentioned files are available:")
        print("")
        print("1. subject_train.txt")
        print("2. subject_test.txt")
        print("3. activity_labels.txt")
        print("4. features.txt")
        print("5. X_train.txt")
        print("6. y_train.txt")
        print("7. X_test.txt")
        print("8. y_test.txt")
}

## Loading all the files into Data Frames in R

subject_train_data <- read.table(file = subject_train)
subject_test_data <- read.table(file = subject_test)
activity_labels_data <- read.table(file = activity_labels)
features_data <- read.table(file = features)
X_train_data <- read.table(file = X_train)
Y_train_data <- read.table(file = Y_train)
X_test_data <- read.table(file = X_test)
Y_test_data <- read.table(file = Y_test)

## Combining all the individual files into a single Data Frame and 
## assigning appropriate labels for all the variables in it.

data_colnames <- c("subjectID", as.vector(features_data[, 2]), "activityID")
test_data <- cbind(subject_test_data, X_test_data, Y_test_data)
train_data <- cbind(subject_train_data, X_train_data, Y_train_data)
dataset1 <- rbind(test_data, train_data)
names(dataset1) <- data_colnames

## Extracting only the mean and the standard deviation variables 
## from the combined dataset

mean_std_features <- sort(as.vector(features_data[c(grep("mean\\(\\)", features_data$V2), grep("std\\(\\)", features_data$V2)), "V2"]))
dataset1 <- dataset1[, c("subjectID", mean_std_features, "activityID")]

## Bringing in the descriptive activity names instead of it's ID values

dataset1 <- merge(activity_labels_data, dataset1, by.y = "activityID", by.x = "V1")
names(dataset1) <- c("activityID", "activityDesc", "subjectID", mean_std_features)
dataset1 <- dataset1[, c("subjectID", "activityDesc", mean_std_features)]

## Creating a final dataset with the average values for all variables
## for each subject and it's activities

melt_dataset1 <- melt(dataset1, id = c("subjectID", "activityDesc"))
dataset2 <- dcast(melt_dataset1, subjectID + activityDesc ~ variable, mean)

## Writing the Data Frames into text files

write.table(dataset1, "run_analysis_merged_output.txt", sep = ",", row.names = FALSE)
write.table(dataset2, "run_analysis_final_output.txt", sep = ",", row.names = FALSE)

return(dataset2)
}

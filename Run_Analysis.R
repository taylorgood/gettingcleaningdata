## Run_Analysis.r
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement.
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names.
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Edited 2/5/16 - finished

library(reshape2)

## Read in data descriptors - data in folder "UCI HAR Dataset" within working directory 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

## only want the mean and std data
wanted_features <- grepl("mean|std", features)

## Read in actual data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## based on README.txt, column headers are in features.txt
names(X_train) = features
names(X_test) = features

## filter out unwanted features (2)
X_test = X_test[,wanted_features]
X_train = X_train[,wanted_features]

## naming activities based on the labels provided (3, 4)
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "Subject"

y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "Subject"

## combine data with labels
test_data <- cbind(subject_test, y_test, X_test)
train_data <- cbind(subject_train, y_train, X_train)

## (1)
comb_data = rbind(train_data, test_data)

id_labels   = c("Subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(comb_data, id = id_labels, measure.vars = data_labels)

## (5)
tidied_data   = dcast(melt_data, subject+Activity_Label ~ variable, mean)

write.table(tidied_data, file = "./tidied_data.txt", row.names = FALSE)

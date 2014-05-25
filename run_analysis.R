# Coursera
# Getting and Cleaning Data
# Data Science Specialization Course
# Class Project
# "The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set."

#
# *** add the ability to download and unzip the file from the source
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
print("downloading file...")
download.file(url, destfile = "UCI HAR Dataset.zip",  method = "curl")
print("unzipping file...")
unzip("UCI HAR Dataset.zip")

setwd("./UCI HAR Dataset")

files <- list.files(recursive=TRUE)

readActivityLabels <- read.table(files[1])

print("reading tables into memory...")
readFeatures <- read.table(files[3])  # retain this to later name the columns
XcolumnNames <- readFeatures[,2] # extract the column names

body_acc_x_test <- read.table(files[5])
body_acc_y_test <- read.table(files[6])
body_acc_z_test <- read.table(files[7])
body_gyro_x_test <- read.table(files[8])
body_gyro_y_test <- read.table(files[9])
body_gyro_z_test <- read.table(files[10])
total_acc_x_test <- read.table(files[11])
total_acc_y_test <- read.table(files[12])
total_acc_z_test <- read.table(files[13])
subject_test <- read.table(files[14])
X_test <- read.table(files[15])
y_test <- read.table(files[16])

body_acc_x_train <- read.table(files[17])
body_acc_y_train <- read.table(files[18])
body_acc_z_train <- read.table(files[19])
body_gyro_x_train <- read.table(files[20])
body_gyro_y_train <- read.table(files[21])
body_gyro_z_train <- read.table(files[22])
total_acc_x_train <- read.table(files[23])
total_acc_y_train <- read.table(files[24])
total_acc_z_train <- read.table(files[25])
subject_train <- read.table(files[26])
X_train <- read.table(files[27])
y_train <- read.table(files[28])

body_acc_x <- rbind(body_acc_x_test, body_acc_x_train)
body_acc_y <- rbind(body_acc_y_test, body_acc_y_train)
body_acc_z <- rbind(body_acc_z_test, body_acc_z_train)
body_gyro_x <- rbind(body_gyro_x_test, body_gyro_x_train)
body_gyro_y <- rbind(body_gyro_y_test, body_gyro_y_train)
body_gyro_z <- rbind(body_gyro_z_test, body_gyro_z_train)
total_acc_x <- rbind(total_acc_x_test, total_acc_x_train)
total_acc_y <- rbind(total_acc_y_test, total_acc_y_train)
total_acc_z <- rbind(total_acc_z_test, total_acc_z_train)
subject <- rbind(subject_test, subject_train)
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)

colnames(X) <- XcolumnNames  # this labels the columns with the feature names

require(data.table)  # make sure the data.table package is loaded and convert X to a data.table
Xdt <- data.table(X)

# Step 2 - Extract only mean and Std Dev
meanfeatures <- subset(XcolumnNames, grepl("mean()", XcolumnNames))
stddevfeatures <- subset(XcolumnNames, grepl("std()", XcolumnNames))
vmeanfeatures <- as.vector(meanfeatures)
vstddevfeatures <- as.vector(stddevfeatures)
cols <- append(vmeanfeatures, vstddevfeatures)
cols <- sort(cols)
XmeanAndStd <- X[, colnames(X) %in% cols]

# replace the y data with the names of the activities per activity_labels.txt file
ActivityLabels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
yLabeled <- cut(y$V1, breaks = 6, ActivityLabels)

XySimple <- cbind(yLabeled,XmeanAndStd )  # attached the activity labels to the Samsung data - assumes rows match up!
XySubject <- data.frame(testsubject = subject, XySimple) # add the test subjects to the beginning of the data frame


# Step 3 - Use descriptive activity names to name th activities in the data set
# replace the column headings with simpler and easier to understand labels

colnames(XySubject)[1] <- "TestSubjectId"
colnames(XySubject)[2] <- "TestSubjectActivity"

# Step 4 - Appropriately label the data set with descriptive activity names
# done previously at the end of Step 3

print("cleaning up column names...")
reLabelFCN <- function(x){
  x <- sub("tBody", "TimeDomainSignalBody", x)
  x <- sub("tGravity", "TimeDomainSignalGravity", x)
  x <- sub("fBody", "FrequencyDomainBody", x)
  x <- sub("Acc","Acceleration",x)
  x <- sub("Mag", "Magnitude",x)
  x <- sub(".std.", "StandardDeviation",x)
  x <- sub(".meanFreq.", "MeanFrequency",x)
  x <- sub(".mean.", "Mean", x)
  x <- sub(".std.", "StandardDeviation", x)
  x <- sub("X", "Xaxis", x)
  x <- sub("Y", "Yaxis", x)
  x <- sub("Z", "Zaxis", x)
  x <- sub("..X", "X", x)
  x <- sub("..Y", "Y", x)
  x <- sub("..Z", "Z", x)
  x <- sub("[.]","", x)  # removes . dot characters from string
  return(x)
}

cols <- colnames(XySubject)  # get the names of the columns of the data frame
columnsFixed <- lapply(cols, reLabelFCN)  # apply the reLabelFCN to each to clean up names

colnames(XySubject) <- columnsFixed # replace the column names with the revised names

# Step 5 - create and save a tidy data set with the average of each variable for each activity and each subject

require(plyr)  # this package provides an easy way to group by and apply a common function to columns

GroupBy <- c("TestSubjectId", "TestSubjectActivity")

step5 <- ddply(XySubject, GroupBy, numcolwise(mean)) # found that numcolwise() will apply a function to all numeric columns in the DF subset from the dplyr GroupBy
print("writing tidy data set...")
write.csv("EDA-Project2-Step5-tidy-data-set.csv", x=step5) # write the summarized and cleaned up data frame to an external file

print("finished processing!")

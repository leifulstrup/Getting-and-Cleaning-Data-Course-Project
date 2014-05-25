Getting-and-Cleaning-Data-Course-Project - sumbitted by Leif Ulstrup, 05-24-2014
========================================

Course project files for the Coursera JHU "Getting and Cleaning Data" Class Project Assignment

README.md file

The program run_analysis.R processes the Human Activity Recognition database as described here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The input database includes raw data from a Samsung smartphone accelerometer and gyro sensors as well as filtered and processed data and has been matched up with 30 test subjects performing Walking, Walking_Upstairs, Walking_Downstairs, Sitting, Standing, and Laying.  The intent of the experiment is to link the Samsung smartphone readings to the human activities.

Per the instructions of the course, I have included a program called run_analysis.R to do the following:

(1) Merges the training and the test sets to create one data set.
(2) Extracts only the measurements on the mean and standard deviation for each measurement. 
(3) Uses descriptive activity names to name the activities in the data set
(4) Appropriately label the data set with descriptive activity names
(5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. That set is called: EDA-Project2-Step5-tidy-data-set.csv

The file CodeBook.md contains details on the variables, data, and transformations that were undertaken to prepare the "tidy data set" EDA-Project2-Step5-tidy-data-set.csv.  Please reference that file for more information.

run_analysis.R includes commments describing the processing steps and the transformations performed.

Caution:

Additional testing (including development of automated test scripts) is needed to confirm that the program is processing the information correclty.  I have taken several steps along the way to unit test the code as well as perform interim checks on calculations to confirm that the tidy data set summaries are being calculated correctly.  
Getting-and-Cleaning-Data-Course-Project  - sumbitted by Leif Ulstrup, 05-24-2014
========================================

Course project files for the Coursera JHU "Getting and Cleaning Data" Class Project Assignment

CodeBook.md file

(A) Source Data:

url for data (zip format) - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

detailed explanation of the experiment and data sources and previous transformations are here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

(B) Transformations Performed:

B.1 The first step was inspecting the .txt files accompanying the UCI data set after unzipping the downloaded file.  There I learned more about the experiment, the variables, the post-processing already performed, and the structure of the folders with the data.  I discovered through some research that I would not need to process the "Inertial Signals" folders for this project (this required research on the class forums).  This was not obvious.  It took effort to inspect the nrow length of the various files to be read in and to confirm they were intended to be joined so that each row represented the readings of a TestSubject + TestSubjectActivity + SamsungReadings...

B.2  I followed the explicit instructions of the project guide and combined all the data between the TEST data set and the TRAIN data set.  I only needed the Subject, X, and y.txt files for the later exercises and the output tidy data set but I included the complete processesing in run_analysis.R per the instructions.

B.3  I then used the regular expression features of R's grepl() function to pull out those readings that were "mean" (average measures) or "std" (standard deviation measures) and create a smaller data frame with that subset of columns per the project instructions.

B.4 I then appended the Subject and the Activity Labels to the Samsung phone measurement data in file X_test.txt and X_train.txt combined.  I previously factored the Activity codes [1-6] using the activity_labels.txt key and replaced the numeric codes with the text : Walking, Walking_Upstairs, Walking_Downstairs, Sitting, Standing, Laying.

B.5 The next was to replace the data frame column labels with complete titles that did not rely on abbreviations or other shorthand.  I referenced the experimental design notes on what the original labels meant and used the sub() function to replace abbreviated terms with the full terms and also cleaned up the visual look of the label text (e.g., removed dots etc).

B.6  The next step was the most challenging to research, experiment with, and test the results.  I used the plyr package (per the video lectures and course forum discussions) to summarize the the data by TestSubjectId and by TestSubjectActivity to compute the mean for each of the measured values in the data frame.  With some research on stackoverflow and other R source via google searches, I found the numcolwise() function option for ddply which worked well computing the mean for each of the columns of the original data frame as they were summarized by subject and activity.  I then did additional testing by extracting those same subsets manually and computing a sampling of the intersection of subject, activity, and sample numeric columns.

B.7 The final step was to write out the tidy dats set via write.csv().  I then read that data into Excel to confirm that it exported correctly and that the numbers matched those in the RStudio data.

(C) Testing and Validation:

- Unit testing was performed at each step working in RStudio.  The unit testing included both calculation and validation of interim results but also use of View() to inspect the data frame contents as well as use of Excel to do outside analysis and validate results.  I set up subsets of data frame data for individual test subjects and activities and calculated the mean values to confirm they match those in the tidy data set output.

- System testing has been performed by running a clean version of RStudio loading run_analysis.R from the working directory with that code and then confirming the tidy data set output : EDA-Project2-Step5-tidy-data-set.csv is readable in Excel and the fields and values match.

(D) Variables:

 [1] "TestSubjectId"                                                    
 [2] "TestSubjectActivity"                                              
 [3] "TimeDomainSignalBodyAccelerationMeanXaxis"                        
 [4] "TimeDomainSignalBodyAccelerationMeanYaxis"                        
 [5] "TimeDomainSignalBodyAccelerationMeanZaxis"                        
 [6] "TimeDomainSignalBodyAccelerationStandardDeviationXaxis"           
 [7] "TimeDomainSignalBodyAccelerationStandardDeviationYaxis"           
 [8] "TimeDomainSignalBodyAccelerationStandardDeviationZaxis"           
 [9] "TimeDomainSignalGravityAccelerationMeanXaxis"                     
[10] "TimeDomainSignalGravityAccelerationMeanYaxis"                     
[11] "TimeDomainSignalGravityAccelerationMeanZaxis"                     
[12] "TimeDomainSignalGravityAccelerationStandardDeviationXaxis"        
[13] "TimeDomainSignalGravityAccelerationStandardDeviationYaxis"        
[14] "TimeDomainSignalGravityAccelerationStandardDeviationZaxis"        
[15] "TimeDomainSignalBodyAccelerationJerkMeanXaxis"                    
[16] "TimeDomainSignalBodyAccelerationJerkMeanYaxis"                    
[17] "TimeDomainSignalBodyAccelerationJerkMeanZaxis"                    
[18] "TimeDomainSignalBodyAccelerationJerkStandardDeviationXaxis"       
[19] "TimeDomainSignalBodyAccelerationJerkStandardDeviationYaxis"       
[20] "TimeDomainSignalBodyAccelerationJerkStandardDeviationZaxis"       
[21] "TimeDomainSignalBodyGyroMeanXaxis"                                
[22] "TimeDomainSignalBodyGyroMeanYaxis"                                
[23] "TimeDomainSignalBodyGyroMeanZaxis"                                
[24] "TimeDomainSignalBodyGyroStandardDeviationXaxis"                   
[25] "TimeDomainSignalBodyGyroStandardDeviationYaxis"                   
[26] "TimeDomainSignalBodyGyroStandardDeviationZaxis"                   
[27] "TimeDomainSignalBodyGyroJerkMeanXaxis"                            
[28] "TimeDomainSignalBodyGyroJerkMeanYaxis"                            
[29] "TimeDomainSignalBodyGyroJerkMeanZaxis"                            
[30] "TimeDomainSignalBodyGyroJerkStandardDeviationXaxis"               
[31] "TimeDomainSignalBodyGyroJerkStandardDeviationYaxis"               
[32] "TimeDomainSignalBodyGyroJerkStandardDeviationZaxis"               
[33] "TimeDomainSignalBodyAccelerationMagnitudeMean"                    
[34] "TimeDomainSignalBodyAccelerationMagnitudeStandardDeviation"       
[35] "TimeDomainSignalGravityAccelerationMagnitudeMean"                 
[36] "TimeDomainSignalGravityAccelerationMagnitudeStandardDeviation"    
[37] "TimeDomainSignalBodyAccelerationJerkMagnitudeMean"                
[38] "TimeDomainSignalBodyAccelerationJerkMagnitudeStandardDeviation"   
[39] "TimeDomainSignalBodyGyroMagnitudeMean"                            
[40] "TimeDomainSignalBodyGyroMagnitudeStandardDeviation"               
[41] "TimeDomainSignalBodyGyroJerkMagnitudeMean"                        
[42] "TimeDomainSignalBodyGyroJerkMagnitudeStandardDeviation"           
[43] "FrequencyDomainBodyAccelerationMeanXaxis"                         
[44] "FrequencyDomainBodyAccelerationMeanYaxis"                         
[45] "FrequencyDomainBodyAccelerationMeanZaxis"                         
[46] "FrequencyDomainBodyAccelerationStandardDeviationXaxis"            
[47] "FrequencyDomainBodyAccelerationStandardDeviationYaxis"            
[48] "FrequencyDomainBodyAccelerationStandardDeviationZaxis"            
[49] "FrequencyDomainBodyAccelerationMeanFrequencyXaxis"                
[50] "FrequencyDomainBodyAccelerationMeanFrequencyYaxis"                
[51] "FrequencyDomainBodyAccelerationMeanFrequencyZaxis"                
[52] "FrequencyDomainBodyAccelerationJerkMeanXaxis"                     
[53] "FrequencyDomainBodyAccelerationJerkMeanYaxis"                     
[54] "FrequencyDomainBodyAccelerationJerkMeanZaxis"                     
[55] "FrequencyDomainBodyAccelerationJerkStandardDeviationXaxis"        
[56] "FrequencyDomainBodyAccelerationJerkStandardDeviationYaxis"        
[57] "FrequencyDomainBodyAccelerationJerkStandardDeviationZaxis"        
[58] "FrequencyDomainBodyAccelerationJerkMeanFrequencyXaxis"            
[59] "FrequencyDomainBodyAccelerationJerkMeanFrequencyYaxis"            
[60] "FrequencyDomainBodyAccelerationJerkMeanFrequencyZaxis"            
[61] "FrequencyDomainBodyGyroMeanXaxis"                                 
[62] "FrequencyDomainBodyGyroMeanYaxis"                                 
[63] "FrequencyDomainBodyGyroMeanZaxis"                                 
[64] "FrequencyDomainBodyGyroStandardDeviationXaxis"                    
[65] "FrequencyDomainBodyGyroStandardDeviationYaxis"                    
[66] "FrequencyDomainBodyGyroStandardDeviationZaxis"                    
[67] "FrequencyDomainBodyGyroMeanFrequencyXaxis"                        
[68] "FrequencyDomainBodyGyroMeanFrequencyYaxis"                        
[69] "FrequencyDomainBodyGyroMeanFrequencyZaxis"                        
[70] "FrequencyDomainBodyAccelerationMagnitudeMean"                     
[71] "FrequencyDomainBodyAccelerationMagnitudeStandardDeviation"        
[72] "FrequencyDomainBodyAccelerationMagnitudeMeanFrequency"            
[73] "FrequencyDomainBodyBodyAccelerationJerkMagnitudeMean"             
[74] "FrequencyDomainBodyBodyAccelerationJerkMagnitudeStandardDeviation"
[75] "FrequencyDomainBodyBodyAccelerationJerkMagnitudeMeanFrequency"    
[76] "FrequencyDomainBodyBodyGyroMagnitudeMean"                         
[77] "FrequencyDomainBodyBodyGyroMagnitudeStandardDeviation"            
[78] "FrequencyDomainBodyBodyGyroMagnitudeMeanFrequency"                
[79] "FrequencyDomainBodyBodyGyroJerkMagnitudeMean"                     
[80] "FrequencyDomainBodyBodyGyroJerkMagnitudeStandardDeviation"        
[81] "FrequencyDomainBodyBodyGyroJerkMagnitudeMeanFrequency" 

(E)  Assumptions <Caution>

I have assumed that the order of the subject_test.txt, X_test.txt, and y_test.txt (same for the *train@ set equivalents) records all match up between the files.  The number of records match but there is not clear comon key field between these to confirm they match up in the way I matched them.  It makes logical sense, but further research with the team that put this data together is needed to confirm this has been processed correctly.  The data lacks any form of checksums or keys to cross link the three file types.  

Action Item:  confirm this assumption is correct.
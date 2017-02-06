CODE BOOK
=========================================

This code book describes the content of the data set HARmeanByPair, as well as the steps taken to create and tidy the data.  HarmeanByPair contains 180 rows and 88 variables. The file can be read using the following command:
HARmeanByPair <- read.table(file_path, header = TRUE), where file_path is the path to the downloaded file on the user’s computer.


Background
==========
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The experimental data used in generating the data set HARmeanByPair was collected and preserved in the Human Activity Recognition (HAR) database from recordings of subjects performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.

Experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (Walking, Walking upstairs, Walking downstairs, Sitting, Standing, Lying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity data was captured at a constant rate of 50Hz. The experiments were video-recorded and the data was labeled manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 

A full description of the experiment is available at URL “http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones”


Experimental Data Set
=====================

The experimental data is found at the following URL:
“https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip” 

The smartphone's accelerometer and gyroscope sensors provided 3-axial raw signals tAcc-XYZ and tGyro-XYZ that were captured at a constant rate of 50 Hz. These time domain signals (prefix 't' to denote time) were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter, one with a corner frequency of 0.3 Hz because the gravitational force is assumed to have only low frequency components.  The signals were then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors were obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean


For each record the following is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

Note that:

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.
 

Steps Taken to Subset and Tidy the Data
=======================================

From the complete set of experimental data described in the preceding section, the following steps were taken to subset and tidy the data. For the code implementing these steps, please see the script “run_analysis.R” in this repository.

The zip data file, found at URL "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip”, was downloaded and the date and time at which the download occurred was recorded.

The following files were unzipped and read into a data table:

* XTest: 2947 observations of 561 numeric experimental features (source: X_test.txt)

* yTest: 2947 rows with the activity code (1-6) for each XTest observation (source: y_test.txt)

* SubjectTest: 2947 rows with the subject code (1-30) for each XTest observation (source: subject_test.txt)

* XTrain: 7352 observations of 561 numeric experimental features (source: X_train.txt)

* yTrain: 7352 rows with the activity code (1-6) for each XTrain observation (source: y_train.txt)

* SubjectTrain: 7352 rows with the subject code (1-30) for each XTrain observation (source: subject_train.txt)

* Features: 561 rows containing the names of the features in XTest and XTrain (source:features.txt)
	
* ActivityLabels: 6 rows containing a code/activity_name pair for each activity (source:activity_labels.txt)



The Features data set was used to create column names (variable names) for each of the 561 features. Next, a “Subject” column containing the subject code (integer 1-30) for each observation was added, as was an “Activity” column containing the activity code (integer 1-6) for each observation and a "DataType" column containing the word “Test” or “Training” to indicate whether the observation originated in the test or training data.

The test and training data sets were then combined (by row) and the resulting merged data set was checked for duplicates. No duplicate rows were detected.

Subsequently, ALL columns with column names that contain the words “mean” or “std” (for standard deviation) or that were named "Subject", "Activity", or "DataType”, were selected, forming a smaller data set with 10,299 observations and 89 columns.  Although there is some ambiguity as to whether variables with names like “angle(X,gravityMean)” should be considered a mean, the decision was made to retain these variables.  The factor columns (Subject, Activity, DataType) were moved to the left side of the data set and the rows were sorted by subject, activity, and datatype. The data was then checked for duplicate columns; no duplicates were detected.

Next, column names were expanded to eliminate the abbreviations below. The decision was made to keep all parts of the original variable names so as not to lose information. Because this makes the names quite long and because the inclusion of additional spaces might interfere with future processing of the data using non-R software, the decision was made to not insert spaces into the variable names. However, the string “()” in some variable names was removed because it can interfere with R processing.

String | Replacement
-------|------------
* ^t | Time
       
* ^f | Frequency
       
* Acc | Acceleration
       
* Gyro | AngularVelocity
       
* Mag | Magnitude
       
* angle(t | angle(Time
       
* () | removed

Lastly, the activity code number was changed to an activity name using the ActivityLabels data set, and underscores were removed. [Example: “2” -> "Walking upstairs”].  In addition, the subject code number was changed to a subject name. [Example: “1” -> "Subject 1”.]


Intermediate Data Set "HARmean"
==============================

The resulting intermediate data set, called HARmean, contains 10,299 observations of 89 variables, including a “DataType” factor variable. See the section below for a list of these variables. Each row consists of one observation containing processed data collected from the embedded accelerometer and gyroscope in a single subject’s Samsung Galaxy S II smartphone.  

The "run_analysis.R" script provides optional (commented out) code to write the intermediate data set HARmean to file if desired.


Data Set "HARmeanByPair"
============================

From the intermediate data set HARmean, a final independent data set called HARmeanByPair was then created. The HARmeanByPair data set contains 88 variables whereas the HARmean data set contains 89 variables. The only difference in the variables between these two data sets is that the “DataType” variable in HARmean has been removed from HARmeanByPair because it is a factor variable and cannot be averaged.  

The variables in each column of HARmeanByPair (one variable per column) are listed below. Variables beginning with the word “Time” are measured in seconds, variables beginning with “Frequency” are measured in Hertz, and variables beginning with “angle” are measured in radians.

 [1] "Subject"  (factor)                                             
 [2] "Activity" (factor)                                            
 [3] "TimeBodyAcceleration-mean-X"                           
 [4] "TimeBodyAcceleration-mean-Y"                           
 [5] "TimeBodyAcceleration-mean-Z"                           
 [6] "TimeBodyAcceleration-std-X"                            
 [7] "TimeBodyAcceleration-std-Y"                            
 [8] "TimeBodyAcceleration-std-Z"                            
 [9] "TimeGravityAcceleration-mean-X"                        
[10] "TimeGravityAcceleration-mean-Y"                        
[11] "TimeGravityAcceleration-mean-Z"                        
[12] "TimeGravityAcceleration-std-X"                         
[13] "TimeGravityAcceleration-std-Y"                         
[14] "TimeGravityAcceleration-std-Z"                         
[15] "TimeBodyAccelerationJerk-mean-X"                       
[16] "TimeBodyAccelerationJerk-mean-Y"                       
[17] "TimeBodyAccelerationJerk-mean-Z"                       
[18] "TimeBodyAccelerationJerk-std-X"                        
[19] "TimeBodyAccelerationJerk-std-Y"                        
[20] "TimeBodyAccelerationJerk-std-Z"                        
[21] "TimeBodyAngularVelocity-mean-X"                        
[22] "TimeBodyAngularVelocity-mean-Y"                        
[23] "TimeBodyAngularVelocity-mean-Z"                        
[24] "TimeBodyAngularVelocity-std-X"                         
[25] "TimeBodyAngularVelocity-std-Y"                         
[26] "TimeBodyAngularVelocity-std-Z"                         
[27] "TimeBodyAngularVelocityJerk-mean-X"                    
[28] "TimeBodyAngularVelocityJerk-mean-Y"                    
[29] "TimeBodyAngularVelocityJerk-mean-Z"                    
[30] "TimeBodyAngularVelocityJerk-std-X"                     
[31] "TimeBodyAngularVelocityJerk-std-Y"                     
[32] "TimeBodyAngularVelocityJerk-std-Z"                     
[33] "TimeBodyAccelerationMagnitude-mean"                    
[34] "TimeBodyAccelerationMagnitude-std"                     
[35] "TimeGravityAccelerationMagnitude-mean"                 
[36] "TimeGravityAccelerationMagnitude-std"                  
[37] "TimeBodyAccelerationJerkMagnitude-mean"                
[38] "TimeBodyAccelerationJerkMagnitude-std"                 
[39] "TimeBodyAngularVelocityMagnitude-mean"                 
[40] "TimeBodyAngularVelocityMagnitude-std"                  
[41] "TimeBodyAngularVelocityJerkMagnitude-mean"             
[42] "TimeBodyAngularVelocityJerkMagnitude-std"              
[43] "FrequencyBodyAcceleration-mean-X"                      
[44] "FrequencyBodyAcceleration-mean-Y"                      
[45] "FrequencyBodyAcceleration-mean-Z"                      
[46] "FrequencyBodyAcceleration-std-X"                       
[47] "FrequencyBodyAcceleration-std-Y"                       
[48] "FrequencyBodyAcceleration-std-Z"                       
[49] "FrequencyBodyAcceleration-meanFreq-X"                  
[50] "FrequencyBodyAcceleration-meanFreq-Y"                  
[51] "FrequencyBodyAcceleration-meanFreq-Z"                  
[52] "FrequencyBodyAccelerationJerk-mean-X"                  
[53] "FrequencyBodyAccelerationJerk-mean-Y"                  
[54] "FrequencyBodyAccelerationJerk-mean-Z"                  
[55] "FrequencyBodyAccelerationJerk-std-X"                   
[56] "FrequencyBodyAccelerationJerk-std-Y"                   
[57] "FrequencyBodyAccelerationJerk-std-Z"                   
[58] "FrequencyBodyAccelerationJerk-meanFreq-X"              
[59] "FrequencyBodyAccelerationJerk-meanFreq-Y"              
[60] "FrequencyBodyAccelerationJerk-meanFreq-Z"              
[61] "FrequencyBodyAngularVelocity-mean-X"                   
[62] "FrequencyBodyAngularVelocity-mean-Y"                   
[63] "FrequencyBodyAngularVelocity-mean-Z"                   
[64] "FrequencyBodyAngularVelocity-std-X"                    
[65] "FrequencyBodyAngularVelocity-std-Y"                    
[66] "FrequencyBodyAngularVelocity-std-Z"                    
[67] "FrequencyBodyAngularVelocity-meanFreq-X"               
[68] "FrequencyBodyAngularVelocity-meanFreq-Y"               
[69] "FrequencyBodyAngularVelocity-meanFreq-Z"               
[70] "FrequencyBodyAccelerationMagnitude-mean"               
[71] "FrequencyBodyAccelerationMagnitude-std"                
[72] "FrequencyBodyAccelerationMagnitude-meanFreq"           
[73] "FrequencyBodyBodyAccelerationJerkMagnitude-mean"       
[74] "FrequencyBodyBodyAccelerationJerkMagnitude-std"        
[75] "FrequencyBodyBodyAccelerationJerkMagnitude-meanFreq"   
[76] "FrequencyBodyBodyAngularVelocityMagnitude-mean"        
[77] "FrequencyBodyBodyAngularVelocityMagnitude-std"         
[78] "FrequencyBodyBodyAngularVelocityMagnitude-meanFreq"    
[79] "FrequencyBodyBodyAngularVelocityJerkMagnitude-mean"    
[80] "FrequencyBodyBodyAngularVelocityJerkMagnitude-std"     
[81] "FrequencyBodyBodyAngularVelocityJerkMagnitude-meanFreq"
[82] "angle(TimeBodyAccelerationMean,gravity)"               
[83] "angle(TimeBodyAccelerationJerkMean),gravityMean)"      
[84] "angle(TimeBodyAngularVelocityMean,gravityMean)"        
[85] "angle(TimeBodyAngularVelocityJerkMean,gravityMean)"    
[86] "angle(X,gravityMean)"                                  
[87] "angle(Y,gravityMean)"                                  
[88] "angle(Z,gravityMean)"


Instead of rows containing individual data observations, each row of HARmeanByPair contains the AVERAGE of the data in each non-factor column for a single subject/activity pair.  Because there are 30 subjects and 6 activities, there are a total of 30 x 6 or 180 rows in HARmeanByPair, one row for each subject/activity pair.

The data set HARmeanByPair is written by the script "run_analysis.R" to the file directory HARdata.  It meets the principles of tidy data as explicated by Hadley Wickham, with one variable per column, one observation per row, descriptive variable names, factor column entries that are character names (“Subject 1”, “Walking upstairs”) instead of codes, no duplicate columns and no duplicate rows, and variables stored only in columns and not in rows.


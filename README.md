# Getting-and-Cleaning-Data-Course-Project


README
============================================

This repository contains the R script “run_analysis.R” and the code book “CodeBook.md” to complete the course project for the “Getting and Cleaning Data” course in the “Data Scientist Specialization” at coursera. The purpose of the project is to demonstrate one’s ability to collect, work with, and clean a data set. 

Overview
========

This repo contains the run_analysis.R script to download and tidy the data collected from accelerometers in the Samsung Galaxy S smartphone. 

A full description of the project and the data is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  
In addition, a README file describing the experiments and the raw data can be found in the zip file available at URL "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip”.

The run_analysis.R script first creates an intermediate internal tidy data set, called HARmean, containing all data measurements that involve mean and standard deviation. From this intermediate data set, a second tidy data set, called HARmeanByPair, is created that summarizes the first data set.  HARmeanByPair contains the average, by subject/activity pair, of each variable in the first data set.  The run_analysis.R script writes to the current directory a textfile containing the HARmeanByPair tidy data set. The intermediate HARmean tidy data set is not written to file, although a commented-out line of code has been provided to do so should the user wish it.

The run_analysis.R script for tidying the downloaded data is extensively documented within the code itself. In addition, a description of each step undertaken to transform and clean up the data is provided below. A description of the resulting variables and data can be found in the CodeBook.md document in this repository. 

Data Tidying Steps in "run_analysis.R"
=====================================================

For the code implementing these steps, please see the script run_analysis.R in this repository.

1. Load packages dplyr, data.table, and stringr.

2. Clean the environment and set the working directory.

3. Create a directory named HARdata into which to download the data if one does not yet exist.

4. Download the zip data file (found at the URL "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip”) into a temporary file.

5. Record the date and time at which the download occurred.

6. Retrieve a list of the names of the files within the downloaded zip file.

7. Use the list of file names to unzip the following files and read them into a data table. See the experiment README file for a more detailed description of the experimental data.
	* XTest: 2947 observations of 561 numeric experimental features
	
	* yTest: 2947 rows containing the integer activity code (1-6) for each XTest observation
	
	* SubjectTest: 2947 rows containing the integer subject code (1-30) for each XTest observation
	
	* XTrain: 7352 observations of 561 numeric experimental features
	
	* yTrain: 7352 rows containing the integer activity code (1-6) for each XTrain observation
	
	* SubjectTrain: 7352 rows containing the integer subject code (1-30) for each XTrain observation
	
	* Features: 561 rows containing the names of the features in XTest and XTrain.
	
	* ActivityLabels: 6 rows containing a code/activity_name pair for each activity.

8. Unlink the temporary file.

9. Check that the number of columns of XTest and XTrain equal the number of rows in the Features data set.

10. Create column names using the feature names provided.  Column names are needed for the upcoming rbind and grep commands.

11. Add a “Subject” column containing the subject code (integer 1-30) for each record.

12. Add an “Activity” column containing the activity code (integer 1-6) for each record.

13. Add a "DataType" column containing “Test” or “Training” to indicate whether the record originated from the test or training data.

14. Check that the test and the training data sets have the same column names and record the number of rows in each data set in preparation for combining them.

15. Combine the test and training data sets using rbind, naming the merged data set HARcomplete.

16. Using nrow, check that all rows were retained during the merge.

17. Remove duplicate rows, if any.

18. Use grepl to identify and select ALL columns with column names that contain the words “mean” or “std” (for standard deviation) or that are named "Subject", "Activity", or "DataType". Do not differentiate between upper and lower case.  Name the selected data set HARmean. Note that there is some ambiguity in whether variables with names like “angle(X,gravityMean)” can be considered a mean measurement.  I decided to be conservative and keep these variables; they can always be removed later if need be.

19. Move the factor columns to the left side of the data set and sort the rows by subject, activity, and datatype.

20. Use gsub on the column names to expand or remove the abbreviations listed below. I decided to keep all the parts of the original variable names so as not to lose information. Because this made the names quite long and because the inclusion of additional spaces might interfere with future processing of the data using non-R software, I decided not to insert spaces into the variable names. I removed the “()” in some variable names because it can interfere with R processing (because R interprets the parentheses as indicating an argument list).

       * ^t -> Time
       
       * ^f -> Frequency
       
       * Acc -> Acceleration
       
       * Gyro -> AngularVelocity
       
       * Mag -> Magnitude
       
       * angle(t -> angle(Time
       
       * () -> removed

21. Change the activity code number to an activity name and remove underscores. Example: “2” -> "Walking upstairs”.

22. Change the subject code number to a subject name. Example: “1” -> "Subject 1”.

23. Create an independent tidy data set called HARmeanByPair containing, according to the project instructions, the “average of each non-factor variable for each activity and each subject”. I interpreted these instructions to be asking for the average for each activity/subject pair.

24. Write the final tidy data set HARmeanByPair to directory HARdata.

25. Provide optional (commented out) code to write the tidy data set HARmean to directory HARdata if so desired.


Description of Tidy Data Set
============================

HARmeanByPair contains the average, computed by subject/activity pair, of each variable containing mean or standard deviation information found in the online data at URL http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. See the CodeBook.md document for a detailed description of the data in the HARmeanByPair tidy data set.







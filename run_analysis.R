#Getting and Cleaning Data - Course Project

# Load packages
library(dplyr)
library(data.table)
library(stringr)

#Clean the environment.
remove(list=ls())

#Check which directory you are in and use setwd() and dir() as needed to 
# navigate to the directory you wish to work in.
getwd()
setwd()

#Create a directory into which to download the data and change to that directory
if(!file.exists("HARdata")) {dir.create("HARdata")}
setwd("HARdata")

# The data is located at the following URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the zip file
temp <- tempfile()            # Create a temporary file into which to download
download.file(fileUrl, temp)  # Download the zip file into the temporary file
dateDownloaded <- date()      # Record the date and time at which the download occurred
unzip(temp, list = TRUE)      # Return a list of file names from which to select

# Unzip the zip file and extract the relevant files into tbl_df dataframes
XTest <- read.table(unzip(temp,"UCI HAR Dataset/test/X_test.txt"))
yTest <- read.table(unzip(temp,"UCI HAR Dataset/test/y_test.txt"))
SubjectTest <- read.table(unzip(temp,"UCI HAR Dataset/test/subject_test.txt"))
XTrain <- read.table(unzip(temp,"UCI HAR Dataset/train/X_train.txt"))
yTrain <- read.table(unzip(temp,"UCI HAR Dataset/train/y_train.txt"))
SubjectTrain <- read.table(unzip(temp,"UCI HAR Dataset/train/subject_train.txt"))
Features <- read.table(unzip(temp,"UCI HAR Dataset/features.txt"))
ActivityLabels <- read.table(unzip(temp,"UCI HAR Dataset/activity_labels.txt"))

# Remove the downloaded zip file after the relevant data files are extracted
unlink(temp)

# Check that the number of columns of XTest and XTrain equal the number of feature names.
if (nrow(Features) != ncol(XTest)) {stop ("Features and XTest have different length")}
if (nrow(Features) != ncol(XTrain)) {stop ("Features and XTrain have different length")}
 
# Create column names using the feature names provided.  Column names are needed
# for the upcoming rbind command.
colnames(XTest) <- t(Features[, 2])
colnames(XTrain) <- t(Features[, 2])

# Add a column containing the subject code (integer 1-30) for each record.
XTest$Subject <- SubjectTest[, 1]
XTrain$Subject <- SubjectTrain[, 1]

# Add a column containing the activity code (integer 1-6) for each record.
XTest$Activity <- yTest[, 1]
XTrain$Activity <- yTrain[, 1]

# Add a "DataType" column showing whether a record is from test or training data.
XTest$DataType <- rep("Test",nrow(XTest))
XTrain$DataType <- rep("Training",nrow(XTrain))

# Check that the test and the training data have the same column names before
# combining them.  Store the number of rows in each dataframe for validation.
if (!all(colnames(XTest) == colnames(XTrain))) {stop("colnames XTest/XTrain don't match")}
rowsXTest <- nrow(XTest)
rowsXTrain <- nrow(XTrain)

# Merge the test and training data.
HARcomplete <- rbind(XTest, XTrain)

# Check that all rows were retained during the merge.
if (nrow(HARcomplete) != (rowsXTest + rowsXTrain)) {stop ("nrow error during rbind")}   

#Remove duplicate rows if any.
HARcomplete <- HARcomplete[!duplicated(HARcomplete), ]

# Use grep to identify and select the columns that contain mean or standard
# deviation data or are named "Subject", "Activity", or "DataType". Do not 
# differentiate between upper and lower case.
HARmean<- HARcomplete[,grepl("Subject|Activity|DataType|mean|std", colnames(HARcomplete), ignore.case=TRUE)]

# Move the factor columns to the left side of the data set and sort the rows by
# subject, activity, and datatype.
HARmean <- HARmean %>% select(Subject, Activity, DataType, everything()) %>%
           arrange(Subject, Activity, DataType)

# Expand column names to remove abbreviations: ^t, ^f, Acc, Gyro, Mag, angle(t*, ()
colnames(HARmean) <- gsub("^t", "Time", colnames(HARmean), ignore.case = TRUE)
colnames(HARmean) <- gsub("^f", "Frequency", colnames(HARmean), ignore.case = TRUE)
colnames(HARmean) <- gsub("Acc", "Acceleration", colnames(HARmean), ignore.case = TRUE)
colnames(HARmean) <- gsub("Gyro", "AngularVelocity", colnames(HARmean), ignore.case = TRUE)
colnames(HARmean) <- gsub("Mag", "Magnitude", colnames(HARmean), ignore.case = TRUE)
colnames(HARmean) <- gsub("angle\\(t", "angle\\(Time", colnames(HARmean), ignore.case = TRUE)
colnames(HARmean) <- gsub("\\(\\)", "", colnames(HARmean), ignore.case = TRUE)

# Change the activity code number to an activity name. Example: "1" -> "Walking"
HARmean$Activity <- str_to_title(ActivityLabels[match(HARmean$Activity, ActivityLabels[,1]),2])
HARmean$Activity <- gsub("_", " ", HARmean$Activity)  #remove underscores

# Change the subject code number to a subject name. Example: "1" -> "Subject 1"
HARmean$Subject <- paste("Subject", HARmean$Subject, sep=" ")

# Create a second, independent tidy data set with the average of each non-factor
# variable for each activity and each subject. The project instructions are 
# unclear; I will compute the average for each activity/subject pair.
HARmeanByPair <- HARmean %>% select(-DataType) %>% 
                  group_by(Subject,Activity) %>% 
                  summarize_all(.funs = (Mean="mean")) %>%
                  arrange(Subject,Activity)

# Write the final tidy data set to directory HARdata
write.table (HARmeanByPair, file="HARmeanByPair.txt", row.names = FALSE)

# Optional code to write tidy data set HARmean to directory HARdata if desired.
# write.table (HARmean, file="HARmean.txt", row.names = FALSE)

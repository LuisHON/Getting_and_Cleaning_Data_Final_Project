# loading the needed libraries

library(dplyr)
library(readr)

# downloading the CourseProject Dataset (zip)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile = "./UCI_HAR_Dataset.zip", method = "curl")

# Extracting the files
unzip(zipfile = "UCI_HAR_Dataset.zip", exdir = ".")
file.rename(from = "UCI HAR Dataset", to = "UCI_HAR_Dataset")

# reference for files
directory = "UCI_HAR_Dataset"
files = list.files(directory, recursive = TRUE)


# reference files paths
FilesPath = paste(directory, files, sep = "/")


# preparing to make the dataset, reading the files.

features = read.table(file = FilesPath[2], col.names = c("id", "functions"))

activity_labels = read.table(file = FilesPath[1], col.names = c("id", "activity"))

X_train = read.table(file = FilesPath[27], col.names = features$functions)

y_train = read.table(file = FilesPath[28], col.names = "id")

X_test = read.table(file = FilesPath[15], col.names = features$functions)

y_test = read.table(file = FilesPath[16], col.names = "id")

subject_train = read.table(file = FilesPath[26], col.names = "subject")

subject_test = read.table(file = FilesPath[14], col.names = "subject")

################################################################################

# 1. Merges the training and the test sets to create one data set.

Xdf = rbind(X_test, X_train)

Ydf = rbind(y_test, y_train)

subjectCombined = rbind(subject_test, subject_train)

FirstDataSet = cbind(subjectCombined, Xdf, Ydf)

################################################################################

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# dataSTDMean receive only the data regarding to subject, id and labeled with "mean" and "std".
dataSTDMean = FirstDataSet %>% select(subject, id, contains("mean"), contains("std"))

################################################################################
# 3. Uses descriptive activity names to name the activities in the data set

# replacing the id numbers by the correspondent activities
dataSTDMean$id <- activity_labels[dataSTDMean$id, "activity"]

# renaming the id field to activity, because now it will contain the 
# performed test activities
dataSTDMean = rename(dataSTDMean, activity = id)


################################################################################
# 4. Appropriately labels the data set with descriptive variable names.

# In the featuresinfo.txt we can see the explanation for the prefixes used in 
# the dataset. Now we'll change for more understandable and easy reading names.
     
# "prefix 't' to denote time"
# "Note the 'f' to indicate frequency domain signals"
# "acc for accelerometer"
# "Gyro for gyroscope"
# "m for magnitude"

names(dataSTDMean)<-gsub("Acc", "Accelerometer", names(dataSTDMean))
names(dataSTDMean)<-gsub("Gyro", "Gyroscope", names(dataSTDMean))
names(dataSTDMean)<-gsub("Mag", "Magnitude", names(dataSTDMean))
names(dataSTDMean)<-gsub("angle", "Angle", names(dataSTDMean))
names(dataSTDMean)<-gsub("^t", "Time", names(dataSTDMean))
names(dataSTDMean)<-gsub("^f", "Frequency", names(dataSTDMean))
names(dataSTDMean)<-gsub("-mean()", "Mean", names(dataSTDMean), ignore.case = TRUE)
names(dataSTDMean)<-gsub("-std()", "StandardDeviation", names(dataSTDMean), ignore.case = TRUE)
names(dataSTDMean)<-gsub("-freq()", "Frequency", names(dataSTDMean), ignore.case = TRUE)
names(dataSTDMean)<-gsub("BodyBody", "Body", names(dataSTDMean))
names(dataSTDMean)<-gsub("gravity", "Gravity", names(dataSTDMean))

################################################################################
# 5.From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity 
# and each subject.

# The TidyDataset will receive a data.frame with the average of each variable
# grouped by subject and activity.
TidyDataset <- dataSTDMean %>%
     group_by(subject, activity) %>%
          summarise_all(lst(mean))

# Making the TidyDataset txt file in the project working directory.
write.table(TidyDataset, file = "TidyDataset.txt", row.names = FALSE)

################################################################################

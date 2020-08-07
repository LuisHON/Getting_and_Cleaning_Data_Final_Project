### TidyDataset Codebook

This repository contains a `run_analysis.R` script that performs a data preparation on
the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) **Dataset**.

_____

#### The program

The `run_analysis.R` firstly load two packages for easy data manipulation **dplyr** and **readr**, then download and extract the dataset in a folder named UCI_HAR_Dataset.

After that, begins to collect the needed information to store in each variable and build the right _dataframe_ to work with, as required by the CourseProject definitions.

1. **Variables**<p>
     These are the transformations i've made with the original variables.
     
   * ```features``` <- features.txt : [561 rows, 2 columns] _("id" and "functions")_   
     This are the data collected from the accelerometer and gyroscope equipment.
   
   * ```activity_labels``` <- activity_labels.txt : [6 rows, 2 columns] _("id" and "activity")_   
     List of all activities collected visually when the tests were being performed (labels)

   - ```subject_test``` <- test/subject_test.txt : [2947 rows, 1 column] _("subject")_   
     Contains test data of 9/30 volunteer test subjects who performed the activity for each window sample.

   - ```subject_train``` <- train/subject_train.txt : [7352 rows, 1 column] _("subject")_   
     Contains the training data of 21/30 volunteer subjects who performed the activity for each window sample.

   - ```X_test``` <- test/X_test.txt : [2947 rows, 561 columns] _(referenced by "features functions")_   
     Contains recorded features test data

   - ```y_test``` <- test/y_test.txt : [2947 rows, 1 columns] _("id")_   
     Contains test data of activities code labels

   - ```X_train``` <- train/X_train.txt : [7352 rows, 561 columns] _(referenced by "features functions")_   
     Contains recorded features training data

   - ```y_train``` <- train/y_train.txt : [7352 rows, 1 columns] _("id")_   
     Contains the training data activities code labels

_____

2. **Gathering the colected data and Making the first complete Dataset**

   Merges the training and the test sets to create one Dataset
      
   - `Xdf` is created by merging x_train and x_test using **rbind()** function [10299 rows, 561 columns]
   
   - `Ydf` is created by merging y_train and y_test using **rbind()** function [10299 rows, 1 column]
   
   - `SubjectCombined` is created by merging subject_train and subject_test using **rbind()**, a function that gather the rows/observations [10299 rows, 1 column]
   
   - `FirstDataSet` is created by merging `SubjectCombined`, `Ydf` and `Xdf` using **cbind()** function [10299 rows, 563 column]

_____

3. **Extracting only the Average and Standard Deviation for each measurement**

   - `dataSTDMean` is created by subsetting `FirstDataSet`, selecting only the following columns: _**subject**_, _**id**_, the **_mean_** and the **_standard deviation_** data for each measurement [10299 rows, 88 columns]

   - Appropriately replacing the _**id**_ numbers label by _**activities**_

_____
   
4. **Using the descriptive activity names to label the performed activities**

   - The Entire numbers previously in "id" and now in the activities column of the `dataSTDMean` are referenced and replaced with corresponding activity from second column of the `activity_labels` variable
   
      For easy reading, better understanding and good practices, some prefixes or abbreviated words that appears in column's name must be replaced:
   
   - *`Acc`* will be replaced by **Accelerometer**;
   - *`Angle`* will be replaced by **Angle**
   - *`BodyBody`* in column’s name will be replaced by **Body**
   - *`Gyro`* in column’s name will be replaced by **Gyroscope**
   - Start with character *`f`* in column’s name or have the *freq()* in some part, will be replaced by **Frequency**
   - *`Gravity`* will be replaced by **Gravity**
   - *`Mag`* in column’s name will be replaced by **Magnitude**
   - *`Mean()`* in some part of column’s name will be replaced by Mean
   - Start with character *``t``* in column’s name will be replaced by **Time**
   - *`std()`* in some part of column’s name will be replaced by **StandardDeviation**
   
_____ 

5. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**

   `TidyDataset`  is created by sumarizing `dataSTDMean`, grouping by subject and activity, then taking the average of each variable for each activity and each subject. [180 rows, 88 columns]
   
   At the end, the R script make a new file, exporting `TidyDataset` into `TidyDataset.txt` file, using the **write.file()** function.

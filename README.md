### Getting and Cleaning Data Course Project

This is the **Coursera final project** repository for the **Luis Henrique O. do N.** Assignment submission in the course *Getting and Cleaning Data*. 

```{r}
     The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
     You will be graded by your peers on a series of yes/no questions related to the project. 
You will be required to submit: 
     1) a tidy data set as described below, 
     2) a link to a Github repository with your script for performing the analysis, and 
     3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
     You should also include a README.md in the repo with your scripts.
     This repo explains how all of the scripts work and how they are connected.
```
-------

#### The repository dataset includes the following files:

- `README.txt`.

- `TidyData.txt`: The Tidy and finished Dataset.

- `run_analysis.R`: The R Script that manipulates the previous dataset to make the new Tidy Dataset. *with comments.*

- `CodeBook.md`: An updated file with the description of all the variables, any transformations or performed work to clean up the data and make the TidyDataset.

-------

#### The R Script does the following:

1. Merges the training and the test sets collected to create a new one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set *(good practices of tidy)* with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


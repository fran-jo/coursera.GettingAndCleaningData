### coursera.GettingAndCleaningData
The repository contains the files:
- run_analysis.R - with the code for cleaning and creating the tidy data set
- tidyAverageData.txt - the resuling tidy data set of the assigment
- CodeBook.md - description of the variables
- ReadMe.md - description of the code (the code file contain comments with explantion of the steps)

-------

To run the .R file, the source files with raw data should be in the same folder. The run_analysis.R is devided in 4 main parts: 
- 1) Read the names of all the measurements, from the features.txt. I select the features that contain either mean and std in their names, total of names= 79
- 2) Read the test data sets (X_test.txt) and select the columns according to the names selected before (I use their index). Modify the column names to be unique an remove the dots (I guess is more readable like this). To the resuling dataset, add a column with the subjects and the activity labels. Change the labels by the activity name. (In the code this correspondes to steps #2 to #7)(tidy test set with 79 + 3 column)
- 3) Repeat step 2 with training data (tidy train set with 79 + 3 column)
- Note: I have added add third column to identify the sets, it contains test/train values. this is why the resulting tidy sets have 79 + 3 columns.
- 4) Merge the two sets (actually, I bind the sets). With the resulting "big" dataset, I grouped the data by activity and subject and perform average to all the 79 colums with measurements. Added the prefix "avg_" to the measurement columns. (resulting tidy grouped set with 79 + 2 column). The resulting set is stored into the tidyAverageData.txt file

Cheers!

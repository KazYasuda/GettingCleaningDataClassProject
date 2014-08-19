Smartphone Sensor Data Analysis
========================
"run_analysis.R" file will produce tidy data file ("TidyData2.txt") that contains table that shows averages of mean and standard deviation of measurements for each subject/person for each activity.

It is assumed that data.table package is installed.

It is further assumed that the following files are saved in the working directory:

* X_train.txt
* X_test.txt
* y_train.txt
* y_test.txt
* features.txt
* activity_labels.txt

"TidyData2.txt" will contain table of 180 x 81 with headings for each column. The first two columns will indicate identifiers for subject and activities. The remaining 79 columns are for each variables which will be calculated by the code. The details can be found in the Code Book.
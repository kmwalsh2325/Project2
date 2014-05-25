CodeBook for Project 2
========================================================

## Data description

* In the Inertial Signals directories for both test and train contains the raw signals without any transformations done. The data selected is the data not contained in this directory but rather the X_train.txt and X_test.txt files. (Note the capital 'X' to indicate the file is not an atomic vector but of data frame structure unlike the y_test.txt and y_train.txt files.) As described in the features_info.txt file, these files contain variables with some pre-processing such as Fast Fourier Transformations, etc. We use this data to construct a tidy data set.

* Between both test and train data, there are 10299 entries. train data is roughtly 70% of these entries leaving test data as roughly 30% of the overall observations.

* Per the README file description of these files, the files pertaining to X contain transformed inertial signals while the y file contains the activity of measure. Similarly the subject files contain the subject id indicating the subject that performed the activity. Naturally this lead to a column structure that followed subject, activity, features.

* Thus masterset is a data frame of train and test data with train data stacked on test data. The columns are partitioned in the following order: subject, activity, features where features are the measurements of each variable.


## Data transformations

* testdata and traindata are constructed from cbind'ing subject_data, y_data, and X_data.

* mastersetraw is an rbind to stack traindata on testdata.

* colnames for mastersetraw are subject, activity, and the features contained in the features.txt file. Function layout (parentheses) was stripped from the variable names, hyphons were changed to dots, and camel casing was left in place to support readability. 

* For readability and convenience, activity numeric ids were converted to English labels by factoring the activity column with labels.

* Per the instructions request, any column containing the functions mean and std were gathered along with the subject and activity column. This was accomplished using the grep function. All columns containing mean and std (not case sensitive) were included as the description of the meaning of these variables in the features_info.txt file verified the necessity of said variables. 

* Using the data.table package for convenience, the master set was keyed by both subject and activity to produce every combination between these two columns and then produced the mean for each feature column of those combinations.


## Variable descriptions

* subject is a numeric id indicating which subject performed the indicated activity.

* activity is a character description of the activity performed under measurement.

* every feature there after is described by the features_info.txt file also provided in the following points.

* The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

* Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

* variables beginning with 'f' indicate those with a Fast Fourier Transform applied to the signal.


These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


#  You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Good luck!


# I'm pretty sure test+train = full data set as described in read me. reading. it helps.

# read in the datas
trainXraw <- read.table("train/X_train.txt", header = FALSE, stringsAsFactors=FALSE)
trainYraw <- read.table("train/y_train.txt", header = FALSE, sep = "\t", stringsAsFactors=FALSE)
trainsubject <- read.table("train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE, sep="\t")
testXraw <- read.table("test/X_test.txt", header = FALSE, stringsAsFactors=FALSE)
testYraw <- read.table("test/y_test.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
testsubject <- read.table("test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE, sep="\t")
# names(testYraw) <- "activity"
# names(trainYraw) <- "activity"
# names(testsubject) <- "subject"
# names(trainsubject) <- "subject"
testdata <- cbind(testsubject, testYraw, testXraw)
traindata <- cbind(trainsubject, trainYraw, trainXraw)

# read in linking activity codes
links <- read.table("activity_labels.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
names(links)<-"activity"
links$activity <- gsub("^[0-9] ", "", links$activity)

# read in and format the titles to be used as column headers in the above data set
features <- read.table("features.txt", header=FALSE, sep = "\t", stringsAsFactors=FALSE)
names(features) <- "feature"
features$feature[555:561] <- gsub(",", "-", features$feature[555:561])
features$feature[555:561] <- gsub("\\(", "-", features$feature[555:561])
features$feature[555:561] <- gsub("\\)", "", features$feature[555:561])
features$feature <- gsub("\\(\\)", "", features$feature)
features$feature <- gsub("^[0-9]+ ", "", features$feature)

#combine test and train data
masterset <- rbind(traindata, testdata)

# apply feature names to the data columns
names(masterset) <- c("subject", "activity", features$feature)

# relabel activity codes with english name;; do this after the rbind/cbinds??
masterset$activity <- factor(masterset$activity, labels = links$activity)


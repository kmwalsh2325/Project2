run_analysis <- function() {
  ##  writes the tidy data set to file
  ##  returns the tidy data set
  
  require(data.table)

  # Read in train data and cbind to create a traindata data frame containing the subject, the activity,
  # and the features
  trainXraw <- read.table("train/X_train.txt", header = FALSE, stringsAsFactors=FALSE)
  trainYraw <- read.table("train/y_train.txt", header = FALSE, sep = "\t", stringsAsFactors=FALSE)
  trainsubject <- read.table("train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE, sep="\t")
  traindata <- cbind(trainsubject, trainYraw, trainXraw)
  
  # Read in test data and cbind to create a testdata data frame containing the subject, the activity,
  # and the features
  testXraw <- read.table("test/X_test.txt", header = FALSE, stringsAsFactors=FALSE)
  testYraw <- read.table("test/y_test.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
  testsubject <- read.table("test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE, sep="\t")
  testdata <- cbind(testsubject, testYraw, testXraw)
  
  # Create the overall master set of data by stacking train and test data
  mastersetraw <- rbind(traindata, testdata)
  
  # Read in linking activity English labels to be used to convert numeric ids
  links <- read.table("activity_labels.txt", header=FALSE, sep="\t", stringsAsFactors=FALSE)
  names(links)<-"activity"
  links$activity <- gsub("^[0-9] ", "", links$activity)
  
  # Read in and format the features to be used as column headers for mastersetraw
  # Remove parentheses, hyphons, leading numbers, and commas
  features <- read.table("features.txt", header=FALSE, sep = "\t", stringsAsFactors=FALSE)
  names(features) <- "feature"
  features$feature[555:561] <- gsub(",", ".", features$feature[555:561])
  features$feature[555:561] <- gsub("\\(", ".", features$feature[555:561])
  features$feature[555:561] <- gsub("\\)", "", features$feature[555:561])
  features$feature <- gsub("\\(\\)", "", features$feature)
  features$feature <- gsub("-", ".", features$feature)
  features$feature <- gsub(",", ".", features$feature)
  features$feature <- gsub("^[0-9]+ ", "", features$feature)
  
  # Apply column names to the master data frame
  names(mastersetraw) <- c("subject", "activity", features$feature)
  
  # Relabel activity ids with English labels
  mastersetraw$activity <- factor(mastersetraw$activity, labels = links$activity)
  
  # Extract all variables containing mean and std measurements
  # Retain subject and activity columns
  extracted_data <- as.data.table(mastersetraw[, grep("subject|activity|mean|std", ignore.case=TRUE, colnames(mastersetraw))]) 
  # Average each measurement by unique subject and activity combinations
  avg_mastersetDT <- extracted_data[, lapply(.SD, mean), keyby = c("subject", "activity")]
  
  # Write tidy data set to file
  write.table(avg_mastersetDT, "tidydataset.txt", sep = " ", col.names=TRUE)
  
  # Return extracted data set of averages
  as.data.frame(avg_mastersetDT)
  
} ## end run_analysis
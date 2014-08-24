## Run_analysis function does the following
#
## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names. 
## 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

  library(reshape2)
  library(plyr)
  
  testSubjectData<- read.table('UCI HAR Dataset/test/subject_test.txt')
  testActivityData <- read.table('UCI HAR Dataset/test/y_test.txt')
  test <- read.table('UCI HAR Dataset/test/X_test.txt')
  
  train <- read.table('UCI HAR Dataset/train/X_train.txt');
  trainSubjectData<- read.table('UCI HAR Dataset/train/subject_train.txt')
  trainActivityData <- read.table('UCI HAR Dataset/train/y_train.txt')
  
  featNames <- read.table("UCI HAR Dataset/features.txt")
  activityLabels <-read.table("UCI HAR Dataset/activity_labels.txt")
  numOfActivities <-max(activityLabels[,1])
  activityLabels <- activityLabels[,2]
  activityLabels <- tolower(gsub("_","",activityLabels))
  
  activityData <- rbind(trainActivityData,testActivityData);
  subject <-rbind(trainSubjectData,testSubjectData);
  combinedData <- rbind(train,test);
  
  size <- dim(subject) 
  
  
  # Find and remove duplicate features. Every column in the feature vector must be unique
  feat <- (featNames[,2])
  duplicateBW <- duplicated(feat)
  feat <- feat[!duplicateBW]
  combinedData <- combinedData[,!duplicateBW]
  
 # 4. Appropriately labels the data set with descriptive variable names 
  feat <- gsub("angle","angleOf",feat);
  feat <- gsub("\\(","",feat);
  feat <- gsub(")","",feat);
  feat <- gsub("-","",feat);
  feat <- gsub("fBody","freqBody",feat);
  feat <- gsub("tBody","timeBody",feat);
  feat <- gsub("Acc","accelerometer",feat);
  feat <- gsub("Gyro","gyroscope",feat);
  feat <- gsub(",","_",feat);
  feat <- tolower(feat)
  
  # 3. Uses descriptive activity names to name the activities in the data set
  activity<-character(size[1])
  for(i in 1:numOfActivities) 
    {
      activity[activityData==i] <- activityLabels[i]
    }
  
  # 1. Merges the training and the test sets to create one data set 
  Data<- cbind(activity,subject,combinedData)
  colnames(Data) <- c("activity","subject",feat)
  
  meltData <- melt(Data,id.vars = c("activity","subject"), measure.vars = feat, variable.name = "features",value.name="measure")
  
  # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  tidyData <- dcast(meltData,activity + subject ~features, mean, value.var = "measure");  
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  stddev <- ddply(meltData,.(features),summarize,stddeviation=sd(measure))
  avg <- ddply(meltData,.(features),summarize,mean=mean(measure))
  stdDevMean <-merge(stddev,avg,by = "features")
  print(stdDevMean)  # prints mean and standard deviation for each measurement. 



run_analysis <- function(type = "a")
{  
  ## The Run_analysis.R program here is a function
  ## Includes a switch list to display individual Outputs as in the Assignment questions 1 to 5
  ##
  ##   Usage Example: 
  ##          out <- run_analysis()
  ##          out <- run_analysis("b") 
  ##
  ## The answers to the ASSINGMENT questions 1 to 5 are listed as "a" to "e" here
  ##
  ## Choose a character from "a","b","c","d" or "e" to view ONE of these outputs. 
  ## The default output is the tidy Data set E.g. out<-run_analysis()   
  ##
  ## a)  Returns the merged training and the test sets to create one data set.
  ##    E.g. out<- run_analysis("a")
  ## b) Returns the measurements on the mean and standard deviation for each measurement. 
  ##   E.g. out<- run_analysis("b")
  ## c) Returns a list of descriptive activity names to name the activities in the data set
  ##   E.g. out<- run_analysis("c")
  ## d) Returns the label list in the data set with descriptive variable names. 
  ##    E.g. out<- run_analysis("d")
  ## e) Returns a second, independent tidy data set with the average of each variable for each activity and subject
  ###   E.g. out<- run_analysis("e")  

  
  ##  This program assumes the user has already downloaded the necessary test and train data into their working folder.
  
  library(reshape2) 
  library(plyr)
  
# Read in the test feature vectors, activity data and subject Data   
  testSubjectData<- read.table('UCI HAR Dataset/test/subject_test.txt')
  testActivityData <- read.table('UCI HAR Dataset/test/y_test.txt')
  test <- read.table('UCI HAR Dataset/test/X_test.txt')
  
# Read in the train feature vectors, activity data and subject Data     
  train <- read.table('UCI HAR Dataset/train/X_train.txt');
  trainSubjectData<- read.table('UCI HAR Dataset/train/subject_train.txt')
  trainActivityData <- read.table('UCI HAR Dataset/train/y_train.txt')
  
# Read in the feature vector names, activity lables
  featNames <- read.table("UCI HAR Dataset/features.txt")
  activityLabels <-read.table("UCI HAR Dataset/activity_labels.txt")
  numOfActivities <-max(activityLabels[,1])
  
  activityLabels <- activityLabels[,2]
  activityLabels <- tolower(gsub("_","",activityLabels))
  
 # combine the train and test activity/subbject data
  activityData <- rbind(trainActivityData,testActivityData);
  subject <-rbind(trainSubjectData,testSubjectData);
  combinedData <- rbind(train,test);
  
  size <- dim(subject) 
    
  # Find and remove duplicate features. Every column in the feature vector matrix must be unique
  feat <- (featNames[,2])
  duplicateBW <- duplicated(feat)
  feat <- feat[!duplicateBW]
  combinedData <- combinedData[,!duplicateBW]
  
 # 4. Appropriately labels the data set with descriptive variable names 
 # Remove curly braces, hyphens annd spaces. Expand shortforms and force all characters to lower case.  
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
    { # Relabel the activity data from 1-6 to their labels 
      activity[activityData==i] <- activityLabels[i]
    }
  
  # Merge the subject, activiry and feature training and the test sets to create one data set 
  Data<- cbind(activity,subject,combinedData)
  colnames(Data) <- c("activity","subject",feat) # Assign column names
  
  # Make a narrow melt data set using activity and subject as the id and the feature names as variables
  meltData <- melt(Data,id.vars = c("activity","subject"), measure.vars = feat, variable.name = "features",value.name="measure")
  
  # Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # using the the melt Data set. The condtion applied here is to find the individual mean for every subject and activity combination
  tidyData <- dcast(meltData,activity + subject ~features, mean, value.var = "measure");  
  
  # Extracts only the measurements on the mean and standard deviation for each measurement. 
  # Calculate the standard deviation and mean for every feature name from this data set.
  stddev <- ddply(meltData,.(features),summarize,stddeviation=sd(measure))
  avg <- ddply(meltData,.(features),summarize,mean=mean(measure))
  
 ## The S.D. and mean of the matrix is merged into a single table  
  stdDevMean <-merge(stddev,avg,by = "features")
 # print(stdDevMean)  # prints mean and standard deviation for each measurement. 

## Making a switch list to display individual Outputs as in the Assingment questions 1 to 5
  switch (type,
          a = {
               message("Returning Tidy Data")
               return(tidyData)
               },
          b = {
               message("Returning Combined Data")
               return(combinedData)
              },
          c = {
               message("Returning Std Deviation and Mean")
               return(stdDevMean)
               },
          d = {
               message("List of activities")
               return(unique(activity))
               print(unique(activity))
              },
          e = {
               message("List of feature vector names")
               return(feat)
               print(feat)
              },
          return(tidyData)
          )

  }


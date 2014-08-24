## CodeBook

### Steps from converting the raw training and test data to a combined tidy data set

1. The test feature vector(X_test.txt), activity data(y_test.txt) and subject data(subject_test.txt) text files are copied from the data folder "UCI HAR Dataset/test/' into the variables test, testActivityData and testSubjectData respectively

2. The test feature vector(X_train.txt), activity data(y_train.txt) and subject data(subject_train.txt) text files are copied from the data folder "UCI HAR Dataset/train/' into the variables train, trainActivityData and trainSubjectData respectively
  
3.  Read in the feature_labels and activity_labels. The feature vector list has 561 features with variable names. The testActivityData and trainActivity Data are row bounded. Their values range from 1 to 6 which corresponds to
  * 1 - "walking"  
  * 2 - "walkingupstairs" 
  * 3 - "walkingdownstairs"  
  * 4 - "sitting"     
  * 5 - "standing"           
  * 6 -"laying"

4. The testActivity number labels are replaced with their string names. The hyphens and uppercase characters are also changed into lower case with no spaces in between. This makes it look cleaner.

5. The featue vector list was then scanned for DUPLICATE entries. Out of the 561 feature vectors, there are 84 duplicate vectors. Using the "duplicated" command, these vectors were found and removed from the combined data list and feature list.

E.g. the feature **fBodyAcc-bandsEnergy()-1,8** has 2 duplicate entries






#### 4) The train, trainActivity and testSubject arrays and column bounded. The same is done with the test, 
####     testActivity and testSubject arrays. These two are then row bounded to form a Combined Data test.

#### 5)

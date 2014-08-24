###  GettingAndCleaningData Course Project
###   ====================================

This repo contains 

1. Run_analysis.R program as a function
2. Codebook.md that details how the data was created.

### How to use my Run_analysis program ?

 *. The Run_analysis.R program here is a function
 *. Includes a switch list to display individual Outputs as in the Assignment questions 1 to 5

	   **Usage Example**: 
	   
	      *. out <- run_analysis() # Returns just the Tidy Data Set
	      *. out <- run_analysis("b") 
    
 Choose a character from "a","b","c","d" or "e" to view ONE of these outputs. 
 The default output is the tidy Data set E.g. out<-run_analysis()   

 *. a) Returns the merged training and the test sets to create one data set.
 
       E.g. out<- run_analysis("a")
       
 *. b) Returns the measurements on the mean and standard deviation for each measurement. 
 
       E.g. out<- run_analysis("b")
       
 *. c) Returns a list of descriptive activity names to name the activities in the data set
 
       E.g. out<- run_analysis("c")
       
 *. d) Returns the label list in the data set with descriptive variable names. 
 
        E.g. out<- run_analysis("d")
        
 *. e) Returns a second, independent tidy data set with the average of each variable for each activity and subject
       
       E.g. out<- run_analysis("e")


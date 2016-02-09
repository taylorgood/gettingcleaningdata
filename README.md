# gettingcleaningdata
Project for Course 3 of JHU Coursera Data Science specialization 

## Files included

* CodeBook.Md - The codebook describing the variables, the data, and any transformations or work performed to clean up the data 
* Run_Analysis.R - The r script that cleans and transforms the testing and training data in order to make tidied_data.txt
* Tidied_data.txt - The output from Run_Analysis.R. This contains the means per subject and activity of the combined testing and training datasets
* License - Standard GNU license
* Readme.md - This file


## Explanation of Run_Analysis.R

Run_Analysis.R has several simple steps:

1. Call reshape2 - program requires reshape2 to melt and cast
2. Reads in features (variables) and activity labels, then filters out all features that do not have mean or std in the name
3. Reads in testing and training data
4. Properly names the activities based off of the activity labels file.
5. Merges test and training data
6. Melts and casts data to make a tidy dataset
7. Writes data to tidied_data.txt

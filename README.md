# TidyData

######This is a repo for the final course project for the "Getting and Cleaning Data" offering from Coursera.

The following is the process that was used to generate the refined data set of smartphone data measuring 30 volunteers performing six activities:

##Data Load
The script first checks to see if the 'UCI HAR Dataset' folder is present in the current working directory on the local machine. If not, the zip file is downloaded and unzipped into the current working directory.

The script *requires the plyr and dplyr packages to be installed* on the local machine. If not, these packages must be added via the install.packages() method. Both are loaded via the library() method in the script.

The subject, activity, and sensor data for both test and training sets are then loaded into data frames. Next, the column names in the subject and activity data frames are renamed to avoid confusion since all six tables originally used a V1 column.

##Data Merge
Orginally, the data was stored as a set of three text files representing 70% of volunteers from the training data and a second set of three text files representing 30% of volunteers from the test data. In both the test and training sets, the primary sensor data set consisted of 561 variables representing a combined 10,299 observations. 

Both test and training sets also contained two smaller data sets with activity and subject values that corresponded to each observation. The script first combines the activity and subject variables to the larger training and test data sets via the cbind() function, resulting in two data sets: 1) a test set with 2,947 observations and 563 variables and 2) a training set with 7,352 observations and 563 variables. Next, the rbind() function is used to combine the two data sets into a single data set with 10,299 observations and 563 variables. Finally, the arrange() function is called to order the data set first by the subject, then by the activity.

##Data Filter

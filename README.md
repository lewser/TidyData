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
The final data set should only contain variables that represent the mean value and standard deviation representing signal estimates from subjects and their activities. The decision was made to *only include the 33 variables with mean()* for the mean values and excludes the 20 variables representing the meanFreq() or angle pattern.

The column ranges related to the mean value and standard deviation were passed to the select() function. The resulting data set consists of 10,299 observations and 68 variables. The first two variables represent the subject and activity and the remaining 66 variables represent the mean value and standard deviations estimates.

At this point, the script also replaces all the V[x] column headers with meaningful labels (e.g. 'Time_BodyAcc_Mean_X') via the rename() function and replaces the numeric codes in the activity column with meaningful labels (e.g. 'Walking') via simple subsetting on the data frame.

##Data Aggregation
The final data set should feature one row per each subject/activity combination and the values in the remaining 66 variables should represent the mean/average across the individual observation per each subject/activity pairing. In other words, there should be 180 observations (30 subjects X 6 activities) in the final data sets. The first two variables in the data frame should represent the subject/activity pairing and the remaining 66 variables should represent the aggregate mean value for all the individual observations for each subject/activity pairing.

To achieve this aggregation, the script uses the ddply() function against the data set. The subject and activity variables are passed to the function to determine how to partition each subset and the summarize function is called collapse the individual observations down to a single observation. Finally, the mean function() is passed in for each of the 66 variables so that the mean value is returned for each aggregate observation.

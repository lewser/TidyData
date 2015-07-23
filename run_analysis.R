#verify whether the data already exists in the current working directory.
if(!file.exists("./UCI HAR Dataset"))
{
    zipFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(zipFile, destfile = "uci_data.zip")
    unzip("uci_data.zip") 
}

#load the plyr and dply packages
library(plyr)
library(dplyr)

#load test data.
fp_x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
fp_s_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
fp_y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

#load training data.
fp_x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
fp_s_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
fp_y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

#rename test data columns.
fp_y_test <- rename(fp_y_test, activity = V1) 
fp_s_test <- rename(fp_s_test, subject = V1)

#rename training data columns.
fp_y_train <- rename(fp_y_train, activity = V1) 
fp_s_train <- rename(fp_s_train, subject = V1)

#build single test data set from different files.
fp_x_test <- cbind(fp_y_test, fp_x_test) # add activity column to base data table.
fp_x_test <- cbind(fp_s_test, fp_x_test) # add subject column to base data table.

#build single training data set from different files.
fp_x_train <- cbind(fp_y_train, fp_x_train) # add activity column to base data table.
fp_x_train <- cbind(fp_s_train, fp_x_train) # add subject column to base data table.

#combine test and training data.
fp_x_combined <- rbind(fp_x_test, fp_x_train)

#order combined data set.
fp_x_combined <- arrange(fp_x_combined, subject, activity)

#drop all columns that do not pertain to the mean() or std() headings.
fp_x_combined <- select(fp_x_combined, 1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 
    229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)

#rename all remaining mean() and std() columns.
fp_x_combined <- rename(fp_x_combined,
    "Time_BodyAcc_Mean_X" = V1,
    "Time_BodyAcc_Mean_Y" = V2,
    "Time_BodyAcc_Mean_Z" = V3,
    "Time_BodyAcc_STD_X" = V4,
    "Time_BodyAcc_STD_Y" = V5,
    "Time_BodyAcc_STD_Z" = V6,  
    "Time_GravityAcc_Mean_X" = V41,
    "Time_GravityAcc_Mean_Y" = V42,
    "Time_GravityAcc_Mean_Z" = V43,
    "Time_GravityAcc_STD_X" = V44,
    "Time_GravityAcc_STD_Y" = V45,
    "Time_GravityAcc_STD_Z" = V46,
    "Time_BodyAccJerk_Mean_X" = V81,
    "Time_BodyAccJerk_Mean_Y" = V82,
    "Time_BodyAccJerk_Mean_Z" = V83,
    "Time_BodyAccJerk_STD_X" = V84,
    "Time_BodyAccJerk_STD_Y" = V85,
    "Time_BodyAccJerk_STD_Z" = V86,
    "Time_BodyGyro_Mean_X" = V121,
    "Time_BodyGyro_Mean_Y" = V122,
    "Time_BodyGyro_Mean_Z" = V123,
    "Time_BodyGyro_STD_X" = V124,
    "Time_BodyGyro_STD_Y" = V125,
    "Time_BodyGyro_STD_Z" = V126,
    "Time_BodyGyroJerk_Mean_X" = V161,
    "Time_BodyGyroJerk_Mean_Y" = V162,
    "Time_BodyGyroJerk_Mean_Z" = V163,
    "Time_BodyGyroJerk_STD_X" = V164,
    "Time_BodyGyroJerk_STD_Y" = V165,
    "Time_BodyGyroJerk_STD_Z" = V166,
    "Time_BodyAccMag_Mean" = V201,
    "Time_BodyAccMag_STD" = V202,
    "Time_GravityAccMag_Mean" = V214,
    "Time_GravityAccMag_STD" = V215,
    "Time_BodyAccJerkMag_Mean" = V227,
    "Time_BodyAccJerkMag_STD" = V228,
    "Time_BodyGyroMag_Mean" = V240,
    "Time_BodyGyroMag_STD" = V241,
    "Time_BodyGyroJerkMag_Mean" = V253,
    "Time_BodyGyroJerkMag_STD" = V254,
    "Frequency_BodyAcc_Mean_X" = V266,
    "Frequency_BodyAcc_Mean_Y" = V267,
    "Frequency_BodyAcc_Mean_Z" = V268,
    "Frequency_BodyAcc_STD_X" = V269,
    "Frequency_BodyAcc_STD_Y" = V270,
    "Frequency_BodyAcc_STD_Z" = V271,
    "Frequency_BodyAccJerk_Mean_X" = V345,
    "Frequency_BodyAccJerk_Mean_Y" = V346,
    "Frequency_BodyAccJerk_Mean_Z" = V347,
    "Frequency_BodyAccJerk_STD_X" = V348,
    "Frequency_BodyAccJerk_STD_Y" = V349,
    "Frequency_BodyAccJerk_STD_Z" = V350,
    "Frequency_BodyGyro_Mean_X" = V424,
    "Frequency_BodyGyro_Mean_Y" = V425,
    "Frequency_BodyGyro_Mean_Z" = V426,
    "Frequency_BodyGyro_STD_X" = V427,
    "Frequency_BodyGyro_STD_Y" = V428,
    "Frequency_BodyGyro_STD_Z" = V429,
    "Frequency_BodyAccMag_Mean" = V503,
    "Frequency_BodyAccMag_STD" = V504,
    "Frequency_BodyBodyAccJerkMag_Mean" = V516,
    "Frequency_BodyBodyAccJerkMag_STD" = V517,
    "Frequency_BodyBodyGyroMag_Mean" = V529,
    "Frequency_BodyBodyGyroMag_STD" = V530,
    "Frequency_BodyBodyGyroJerkMag_Mean" = V542,
    "Frequency_BodyBodyGyroJerkMag_STD" = V543  
)

#replace the activity codes with meaningful strings.
fp_x_combined$activity[fp_x_combined$activity == 1] <- "Walking" 
fp_x_combined$activity[fp_x_combined$activity == 2] <- "Walking Upstairs" 
fp_x_combined$activity[fp_x_combined$activity == 3] <- "Walking Downstairs" 
fp_x_combined$activity[fp_x_combined$activity == 4] <- "Sitting" 
fp_x_combined$activity[fp_x_combined$activity == 5] <- "Standing" 
fp_x_combined$activity[fp_x_combined$activity == 6] <- "Laying" 

#generate aggregate values based on subject and activity so the 10,299 observations are summarized 
#as 180 obeservations (30 subjects, each with 6 activities)
fp_tidy_data <- ddply(fp_x_combined, c("subject", "activity"), summarize, 
    Time_BodyAcc_Mean_X = mean(Time_BodyAcc_Mean_X), 
    Time_BodyAcc_Mean_Y = mean(Time_BodyAcc_Mean_Y),
    Time_BodyAcc_Mean_Z = mean(Time_BodyAcc_Mean_Z),
    Time_BodyAcc_STD_X = mean(Time_BodyAcc_STD_X),
    Time_BodyAcc_STD_Y = mean(Time_BodyAcc_STD_Y),
    Time_BodyAcc_STD_Z = mean(Time_BodyAcc_STD_Z),
    Time_GravityAcc_Mean_X = mean(Time_GravityAcc_Mean_X),
    Time_GravityAcc_Mean_Y = mean(Time_GravityAcc_Mean_Y),
    Time_GravityAcc_Mean_Z = mean(Time_GravityAcc_Mean_Z),
    Time_GravityAcc_STD_X = mean(Time_GravityAcc_STD_X),
    Time_GravityAcc_STD_Y = mean(Time_GravityAcc_STD_Y),   
    Time_GravityAcc_STD_Z = mean(Time_GravityAcc_STD_Z),
    Time_BodyAccJerk_Mean_X = mean(Time_BodyAccJerk_Mean_X),
    Time_BodyAccJerk_Mean_Y = mean(Time_BodyAccJerk_Mean_Y),
    Time_BodyAccJerk_Mean_Z = mean(Time_BodyAccJerk_Mean_Z),
    Time_BodyAccJerk_STD_X = mean(Time_BodyAccJerk_STD_X), 
    Time_BodyAccJerk_STD_Y = mean(Time_BodyAccJerk_STD_Y),
    Time_BodyAccJerk_STD_Z = mean(Time_BodyAccJerk_STD_Z),
    Time_BodyGyro_Mean_X = mean(Time_BodyGyro_Mean_X),
    Time_BodyGyro_Mean_Y = mean(Time_BodyGyro_Mean_Y),
    Time_BodyGyro_Mean_Z = mean(Time_BodyGyro_Mean_Z), 
    Time_BodyGyro_STD_X = mean(Time_BodyGyro_STD_X),
    Time_BodyGyro_STD_Y = mean(Time_BodyGyro_STD_Y),
    Time_BodyGyro_STD_Z = mean(Time_BodyGyro_STD_Z),
    Time_BodyGyroJerk_Mean_X = mean(Time_BodyGyroJerk_Mean_X),
    Time_BodyGyroJerk_Mean_Y = mean(Time_BodyGyroJerk_Mean_Y), 
    Time_BodyGyroJerk_Mean_Z = mean(Time_BodyGyroJerk_Mean_Z),
    Time_BodyGyroJerk_STD_X = mean(Time_BodyGyroJerk_STD_X),
    Time_BodyGyroJerk_STD_Y = mean(Time_BodyGyroJerk_STD_Y),
    Time_BodyGyroJerk_STD_Z = mean(Time_BodyGyroJerk_STD_Z),
    Time_BodyAccMag_Mean = mean(Time_BodyAccMag_Mean), 
    Time_BodyAccMag_STD = mean(Time_BodyAccMag_STD),
    Time_GravityAccMag_Mean = mean(Time_GravityAccMag_Mean),
    Time_GravityAccMag_STD = mean(Time_GravityAccMag_STD),
    Time_BodyAccJerkMag_Mean = mean(Time_BodyAccJerkMag_Mean),
    Time_BodyAccJerkMag_STD = mean(Time_BodyAccJerkMag_STD), 
    Time_BodyGyroMag_Mean = mean(Time_BodyGyroMag_Mean),
    Time_BodyGyroMag_STD = mean(Time_BodyGyroMag_STD),
    Time_BodyGyroJerkMag_Mean = mean(Time_BodyGyroJerkMag_Mean),
    Time_BodyGyroJerkMag_STD = mean(Time_BodyGyroJerkMag_STD),
    Frequency_BodyAcc_Mean_X = mean(Frequency_BodyAcc_Mean_X), 
    Frequency_BodyAcc_Mean_Y = mean(Frequency_BodyAcc_Mean_Y),
    Frequency_BodyAcc_Mean_Z = mean(Frequency_BodyAcc_Mean_Z),
    Frequency_BodyAcc_STD_X = mean(Frequency_BodyAcc_STD_X),
    Frequency_BodyAcc_STD_Y = mean(Frequency_BodyAcc_STD_Y),
    Frequency_BodyAcc_STD_Z = mean(Frequency_BodyAcc_STD_Z),    
    Frequency_BodyAccJerk_Mean_X = mean(Frequency_BodyAccJerk_Mean_X),
    Frequency_BodyAccJerk_Mean_Y = mean(Frequency_BodyAccJerk_Mean_Y),
    Frequency_BodyAccJerk_Mean_Z = mean(Frequency_BodyAccJerk_Mean_Z),
    Frequency_BodyAccJerk_STD_X = mean(Frequency_BodyAccJerk_STD_X), 
    Frequency_BodyAccJerk_STD_Y = mean(Frequency_BodyAccJerk_STD_Y),
    Frequency_BodyAccJerk_STD_Z = mean(Frequency_BodyAccJerk_STD_Z),
    Frequency_BodyGyro_Mean_X = mean(Frequency_BodyGyro_Mean_X),
    Frequency_BodyGyro_Mean_Y = mean(Frequency_BodyGyro_Mean_Y), 
    Frequency_BodyGyro_Mean_Z = mean(Frequency_BodyGyro_Mean_Z),
    Frequency_BodyGyro_STD_X = mean(Frequency_BodyGyro_STD_X),
    Frequency_BodyGyro_STD_Y = mean(Frequency_BodyGyro_STD_Y),
    Frequency_BodyGyro_STD_Z = mean(Frequency_BodyGyro_STD_Z), 
    Frequency_BodyAccMag_Mean = mean(Frequency_BodyAccMag_Mean),
    Frequency_BodyAccMag_STD = mean(Frequency_BodyAccMag_STD),
    Frequency_BodyBodyAccJerkMag_Mean = mean(Frequency_BodyBodyAccJerkMag_Mean),
    Frequency_BodyBodyAccJerkMag_STD = mean(Frequency_BodyBodyAccJerkMag_STD), 
    Frequency_BodyBodyGyroMag_Mean = mean(Frequency_BodyBodyGyroMag_Mean),
    Frequency_BodyBodyGyroMag_STD = mean(Frequency_BodyBodyGyroMag_STD),
    Frequency_BodyBodyGyroJerkMag_Mean = mean(Frequency_BodyBodyGyroJerkMag_Mean),
    Frequency_BodyBodyGyroJerkMag_STD = mean(Frequency_BodyBodyGyroJerkMag_STD)        
)



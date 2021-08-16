setwd("/Users/modafar.shaker/Google Drive/Modafar/ModWork/DS/Coursera-DSwithR/Course3-CleaningData/W4/Assignement/")
dir()
# Merges the training and the test sets to create one data set.
   # Reading Training data
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

      # Reading Test data
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(xtrain) <- ftr[,2]
colnames(ytrain) <-"activityId"
colnames(subtrain) <- "subjectId"

colnames(xtest) <- ftr[,2] 
colnames(ytest) <- "activityId"
colnames(subtest) <- "subjectId"

colnames(act) <- c('activityId','activityType')
   # Merging
trnmrg <- cbind(xtrain,ytrain,subtrain)
str(trnmrg)  #checking

tstmrg <- cbind(xtest,ytest,subtest)

str(tstmrg) #checking

tsttrnmrg <- rbind(trnmrg,tstmrg)
str(tsttrnmrg) #checking
dim(tsttrnmrg) #checking


# Extract only the measurements on the mean and standard deviation for each measurement. 

     # assigning col names

        # Reading feature vector:
        ftr <- read.table('./UCI HAR Dataset/features.txt')

        # Reading activity labels:
        act <- read.table('./UCI HAR Dataset/activity_labels.txt')

        # Assigning column names:

         colnames(xtrain) <- ftr[,2]
         colnames(ytrain) <-"activityId"
         colnames(subtrain) <- "subjectId"

        colnames(xtest) <- ftr[,2] 
        colnames(ytest) <- "activityId"
        colnames(subtest) <- "subjectId"

        colnames(act) <- c('activityId','activityType')

        mrgcolname <- colnames(tsttrnmrg)

meanstd <- (grepl("activityId" , mrgcolname) | 
                         grepl("subjectId" , mrgcolname) | 
                         grepl("mean.." , mrgcolname) | 
                         grepl("std.." , mrgcolname) 
)
meanstd

meanstddata <- tsttrnmrg[ , meanstd == TRUE]
dim(meanstddata)

# Uses descriptive activity names to name the activities in the data set


actnames <- merge(meanstddata, act, by='activityId',all.x=TRUE)


# Appropriately labels the data set with descriptive variable names. 
# Assigning column names:

colnames(xtrain) <- ftr[,2]
colnames(ytrain) <-"activityId"
colnames(subtrain) <- "subjectId"

colnames(xtest) <- ftr[,2] 
colnames(ytest) <- "activityId"
colnames(subtest) <- "subjectId"

colnames(act) <- c('activityId','activityType')

# creates a second, independent tidy data set with the average of each variable for each activity and each subject:

set2 <- aggregate(. ~subjectId + activityId, actnames, mean)
set2 <- set2[order(set2$subjectId, set2$activityId),]


write.table(set2, "set2.txt", row.name=FALSE)

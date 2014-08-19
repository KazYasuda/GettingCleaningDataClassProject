# The following files are assumed to be in the working directory, 
# "X_train.txt"
# "X_test.txt"
# "y_train.txt"
# "y_test.txt"
# "subject_train.txt"
# "subject_test.txt"
# "activity_labels.txt"
# "features.txt"
# 
# It is further assumed that data.table package is installed

# file called "TidyData2.txt" will be saved in the working directory

# 1. 	Merges the training and the test sets to create one data set.

trX <- read.table("X_train.txt", sep="")
tsX <- read.table("X_test.txt", sep="")
rData <- rbind(trX, tsX) 

# 2. 	Extracts only the measurements on the mean and standard deviation for each measurement. 

# 	load descriptions of statistics
features <- read.table("features.txt", sep="", stringsAsFactors = FALSE)
# 	identify which columns show mean and standard deviation
meanCol = grep("mean", features[,2])
stdCol = grep("std", features[,2])
dataCol = sort(c(meanCol, stdCol))

# select relevant columns
Data <- rData[,dataCol]

# 3. 	Uses descriptive activity names to name the activities in the data set

# load activities of the training and test sets
trY <- read.table("y_train.txt", sep="") #7352 x 1 showing actitivity lablels(1-6)
tsY <- read.table("y_test.txt", sep="") # 2947 x 1 (showing activity lables 1-6)
act <- rbind(trY, tsY)  
actL <- read.table("activity_labels.txt", sep="", stringsAsFactors=FALSE)

for (cnt in 1:6){act[act==cnt]<-actL[actL[,1]==cnt,2]} #change activity number into descriptives

Data <- cbind(act, Data) #combine the activities with the data

# 4. Appropriately labels the data set with descriptive variable names. 

ColNames <- features[dataCol,2]
ColNames <- sub("-mean()", "Mean", ColNames, fixed = T)
ColNames <- sub("-std()", "Std", ColNames, fixed = T)
ColNames <- sub("Freq()", "Freq", ColNames, fixed = T)
ColNames <- sub("-X", "X", ColNames, fixed = T)
ColNames <- sub("-Y", "Y", ColNames, fixed = T)
ColNames <- sub("-Z", "Z", ColNames, fixed = T)
ColNames <- c("Activities", ColNames) # <- this does not work
colnames(Data) <- ColNames
															  	
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# add subject columns to the Data file
trSub <- read.table("subject_train.txt", sep="")
tsSub <- read.table("subject_test.txt", sep="")
Sub <- rbind(trSub, tsSub)

Data <- cbind(Sub, Data)
ColNames <- c("Subject", ColNames)
colnames(Data) <- ColNames

library(data.table)
DT <- as.data.table(Data)

ans <- DT[,lapply(.SD, mean), by=list(Subject, Activities)]

write.table(ans, file = "TidyData2.txt", row.name = FALSE)

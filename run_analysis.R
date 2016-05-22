#1
# extract index of column names with mean and std values
nomsColumna<- read.table("features.txt")
idxNomsColumna<- grep(".mean.|.std.",nomsColumna$V2)
#
### WORKING WITH TEST DATA
#2
# read test data
testSet<- read.table("./test/X_test.txt")
testSubjects<- read.table("./test/subject_test.txt")
testLabels<- read.table("./test/y_test.txt")
#3
# label the test labels with names
testLabels$V1[testLabels$V1 == 1] <- "WALKING" 
testLabels$V1[testLabels$V1 == 2] <- "WALKING_UPSTAIRS" 
testLabels$V1[testLabels$V1 == 3] <- "WALKING_DOWNSTAIRS" 
testLabels$V1[testLabels$V1 == 4] <- "SITTING" 
testLabels$V1[testLabels$V1 == 5] <- "STANDING" 
testLabels$V1[testLabels$V1 == 6] <- "LAYING" 
#4
# change testSet column names with proper names and eliminate duplicates
names(testSet)<- nomsColumna$V2
columnNames <- make.names(names=names(testSet), unique=TRUE, allow_ = TRUE)
names(testSet) <- columnNames
#5
# select only the colunms with mean and std values
testSetMeanStd<- select(testSet, idxNomsColumna)
#6
# make the column names a little bit more readable 
newNames<- sub("\\.","_",names(testSetMeanStd))
names(testSetMeanStd)<- gsub("\\.","",newNames)
#7
# add extra column with subjects, activity and the type of data set
testSetMeanStd$subject<- testSubjects$V1
testSetMeanStd$activity<- testLabels$V1
testSetMeanStd$set<- "test"
rm(testLabels,testSubjects,testSet)
#
### WORKING WITH TRAINING DATA
#2
# read train data
trainSet<- read.table("./train/X_train.txt")
trainSubjects<- read.table("./train/subject_train.txt")
trainLabels<- read.table("./train/y_train.txt")
#3
# label the train labels with names
trainLabels$V1[trainLabels$V1 == 1] <- "WALKING" 
trainLabels$V1[trainLabels$V1 == 2] <- "WALKING_UPSTAIRS" 
trainLabels$V1[trainLabels$V1 == 3] <- "WALKING_DOWNSTAIRS" 
trainLabels$V1[trainLabels$V1 == 4] <- "SITTING" 
trainLabels$V1[trainLabels$V1 == 5] <- "STANDING" 
trainLabels$V1[trainLabels$V1 == 6] <- "LAYING"
#4
# change trainSet column names with proper names and eliminate duplicates
names(trainSet)<- nomsColumna$V2
columnNames <- make.names(names=names(trainSet), unique=TRUE, allow_ = TRUE)
names(trainSet) <- columnNames
#5
# select only the colunms with mean and std values
trainSetMeanStd<- select(trainSet, idxNomsColumna)
#6
# make the column names a little bit more readable 
newNames<- sub("\\.","_",names(trainSetMeanStd))
names(trainSetMeanStd)<- gsub("\\.","",newNames)
#7
# add extra column with subjects, activity and the type of data set
trainSetMeanStd$subject<- trainSubjects$V1
trainSetMeanStd$activity<- trainLabels$V1
trainSetMeanStd$set<- "train"
rm(trainLabels,trainSubjects,trainSet)
#
#8
# bind the two tables together to create only one data set
tidySamsungData<- rbind(testSetMeanStd,trainSetMeanStd)
#
### CREATE THE SECOND DATA SET
#9
# grouping data and calculate average by activity and subject
tidyAverageData<- tidySamsungData %>%
  group_by(activity,subject) %>%
  summarise_each(funs(mean), -(subject:set)) %>%
  setNames(c(names(.)[1:2], paste0("avg_",names(.)[-1:-2]))) 
#10
# store data set into file
write.table(tidyAverageData,file="./tidyAverageData.txt",row.names= FALSE)
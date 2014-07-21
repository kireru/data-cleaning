#assuming that the data set has been downloaded,unzipped in your working directory
 run the code from that process
library(reshape2)
#reading the features of the data provoded
activities <-read.table("activity_labels.txt")
features <-read.table("features.txt")

#reading the first data set as well as binding
stest<-read.table("test/subject_test.txt")
xtest<-read.table("test/X_test.txt")
ytest<-read.table("test/y_test.txt")

#reading the second data set as well as binding
strain<-read.table("train/subject_train.txt")
xtrain<-read.table("train/X_train.txt")
ytrain<-read.table("train/y_train.txt")

#reading the third data set as well as binding
test<-cbind(stest, ytest, xtest)
train<-cbind(strain, ytrain, xtrain)
data<-rbind(test,train)

## import and nameactivity list
names(data)[1]<-"subject"
names(data)[2]<-"activity"
names(data)[3:563]<-features[,2]

## Identify which feature contain mean or std, builds import vector
meanCol<-grep("mean()", features[,2], fixed=TRUE)
stdCol<-grep("std()", features[,2], fixed=TRUE)
colSel<-c(-1, 0, meanCol, stdCol)
dataMerged<-data[,colSel+2]

library(reshape2)
dataMelt<-melt(dataMerged, c("subject","activity"))
dataTidy<-dcast(dataMelt, subject+activity~variable, mean)

## Prints full data set and write outputData table to a csv file
write.table(dataMerged, file="merged_clean_data.csv", sep=",", append=FALSE)
write.table(dataTidy, file="Tidydata.csv", sep=",", append=FALSE)
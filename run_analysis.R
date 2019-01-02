#1 Download dataset

ifelse(!file.exists("project1"),dir.create("project1"),print("directory exists")) 
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"project.zip") 
unzip("project.zip",exdir="project1")
path<-"project1/UCI HAR Dataset"
content<-list.files(path,recursive=T)
content

#2 Read activity and features info:

#2.1 DAT = "dataactivitytest" DATr = "dataactivitytrain"

DATr<-read.table("project1/UCI HAR Dataset/train/Y_train.txt",header = F) 
DAT<-read.table("project1/UCI HAR Dataset/test/Y_test.txt",header = F)

#2.2 DASTr = "datasubjecttrain" DAST = "datasubjecttest"

DASTr<- read.table("project1/UCI HAR Dataset/train/subject_train.txt",header= F)
DAST<-read.table("project1/UCI HAR Dataset/test/subject_test.txt",header = F)

#2.3 Feature files DAFTr = "Datafeaturetrain" DAFT = "Datafeaturetest"

DAFTr<-read.table("project1/UCI HAR Dataset/train/X_train.txt",header = F) 
DAFT<-read.table("project1/UCI HAR Dataset/test/X_test.txt",header = F)

#3 Combine by rows the below datasets DA = "DataActivity" DS = "DataSubject" DF="DataFeatures" 

DA<-rbind(DATr,DAT) 
DS<-rbind(DASTr,DAST)
DF<-rbind(DAFTr,DAFT)

#3.1The variables of the bellow tables don't have names, so, i'll give ones.

names(DA)<-c("activity") 
names(DS)<-c("subject") 

#3.1.1 The names of the features lies in the archive: "features.txt", so,
#I'll create a character variable: 

DFnames<-read.table("project1/UCI HAR Dataset/features.txt",header = F) 
head(DFnames) 
names(DF)<-DFnames$V2

#4 Then I'll go to to combine these data sets by columns: 
  DC1<-cbind(DS,DA) 
D<-cbind(DF,DC1)

#5 Obtain only the mean and standard deviation
SubsetOfDFnames<-DFnames$V2[grep("mean\\(\\)|std\\(\\)",DFnames$V2)]
#with grep i filtered the values of DFnames$V2, that don't have any spaces
#between mean and the character "(" and the other character ")", the same as for 
#std()

D<-subset(D,select = c(as.character(SubsetOfDFnames),"subject","activity"))

#6I'll use the descriptive activity names to name the activities on D$activity, 
#these names lies on "activity_labels.txt"
AL<-read.table("project1/UCI HAR Dataset/activity_labels.txt",header = F)
head(AL) 
D$activity<-factor(D$activity,levels = seq(1,6,1),labels = as.character(AL$V2))

#7Appropriately labels the data set with descriptive variable names.
names(D)<-gsub("^t", "time", names(D))
names(D)<-gsub("Acc", "accelerometer", names(D))
names(D)<-gsub("^f", "frequency", names(D))
names(D)<-gsub("Mag", "magnitude", names(D))
names(D)<-gsub("Gyro", "gyroscope", names(D))
names(D)<-gsub("BodyBody", "body", names(D))

#I'm gonna do and independent tidy dataset
library(dplyr);
D1<- aggregate(D,by = list(subject1 = D$subject,activity1 = D$activity),FUN=mean)
D1<-tbl_df(D1) 
D1<-select(D1,-c(activity,subject)) 
D1<-data.frame(D1)
View(D1) 
write.table(D1, file = "tidydata.txt",row.name=F)

#that is a plus: at the end I'm gonna do a codebook
library(dataMaid)
b<-makeCodebook(D1,file ="codebook.Rmd") 
library(knitr)
knit(file.path("project1","codebook.Rmd"))
file.path("project1","codebook.Rmd")
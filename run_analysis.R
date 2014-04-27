install.packages("plyr")
library(plyr)
features <- read.table(file= "C:\\Users\\kunal.kohli\\Documents\\Coursera\\Getting and Cleaning Data\\Quizzes\\Assignment\\UCI HAR Dataset\\features.txt", header = FALSE,
                       sep = "", stringsAsFactors = FALSE)
X_train <- read.table("~/Coursera/Getting and Cleaning Data/Quizzes/Assignment/UCI HAR Dataset/train/X_train.txt", quote="\"")
names(X_train) <- features[,2]
Y_train <- read.table("~/Coursera/Getting and Cleaning Data/Quizzes/Assignment/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("~/Coursera/Getting and Cleaning Data/Quizzes/Assignment/UCI HAR Dataset/train/subject_train.txt", quote="\"")

train <- cbind(X_train, Y_train, subject_train)
names(train)[[562]] <- "predictor"
names(train)[[563]] <- "subject"

X_test <- read.table("~/Coursera/Getting and Cleaning Data/Quizzes/Assignment/UCI HAR Dataset/test/X_test.txt", quote="\"")
Y_test <- read.table("~/Coursera/Getting and Cleaning Data/Quizzes/Assignment/UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_test <- read.table("~/Coursera/Getting and Cleaning Data/Quizzes/Assignment/UCI HAR Dataset/test/subject_test.txt", quote="\"")

test <- cbind(X_test, Y_test, subject_test)
names(test) <- names(train)

data <- rbind(train,test)

a <-grep("mean\\(\\)|std\\(\\)",names(data), value = FALSE)
data.extract <- data[ ,a]

activity_labels <- read.table("~/Coursera/Getting and Cleaning Data/Quizzes/Assignment/UCI HAR Dataset/activity_labels.txt", quote="\"")

data[,562] <- factor(data[,562], levels= c(1,2,3,4,5,6), labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))


data.extract2 <- cbind(data.extract, data[,c(562,563)])

tidy.dataset <- ddply(data.extract2,.variables= c("subject", "predictor"), numcolwise(mean))

write.table(x=tidy.dataset,"tidy_dataset.txt", sep= "\t", row.names=FALSE)

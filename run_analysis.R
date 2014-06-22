## Coursera - Getting and Cleaning Data - Course Project

setwd("C:/Users/Preston/Desktop/Coursera/Getting and Cleaning Data/Course Project")


##################################################
## Part 1: Merge training and test datasets  #####
##################################################

# main datasets
test <- read.table("Data/test/X_test.txt")
training <- read.table("Data/train/X_train.txt")

##########################################
## Part 4: Descriptive Variable Names  ###
##########################################

# add variable names
features <- read.table("Data/features.txt", sep=" ")

names(test) <- features[,2]
names(training) <- features[,2]


##########################################
## Part 3: Descriptive Activity Names  ###
##########################################

# pull in subject and test names
subject_test <- read.table("Data/test/subject_test.txt")
ytest <- read.table("Data/test/y_test.txt")

names(subject_test) <- "Subject"
names(ytest) <- "TestNum"

subject_train <- read.table("Data/train/subject_train.txt")
ytrain <- read.table("Data/train/y_train.txt")

names(subject_train) <- "Subject"
names(ytrain) <- "TestNum"

# pull in activity labels and replace numbers in xtest and ytest
activity_labels <- read.table("Data/activity_labels.txt")
names(activity_labels) <- c("TestNum", "Test")

library(plyr)

ytest2 <- data.frame(join(ytest, activity_labels, type="left")[,2])
names(ytest2) <- "Test"

ytrain2 <- data.frame(join(ytrain, activity_labels, type="left")[,2])
names(ytrain2) <- "Test"


#################
# Part 1 cont. ##
#################

# add test, subject to main datasets
test_final <- cbind(ytest2, subject_test, test)

train_final <- cbind(ytrain2, subject_train, training)

# combine test and train datasets
part1_data <- rbind(test_final, train_final)


##################################################
## Part 2: Extract only the means and std's  #####
##################################################

# only want the columns that contain mean() or std()
#   can't forget to keep our test, subject and test or train variables in the first three col's

library(stringr)

# location of mean()'s and std()'s
means <- complete.cases(str_locate(names(part1_data), "mean()"))
stds <- complete.cases(str_locate(names(part1_data), "std()"))

# combine for a list of both
means_stds <- which(means | stds)

part2_data <- part1_data[, c(1:2, means_stds)]

#################################################################
# Part 5: Averages for each variable by subject and activity  ###
#################################################################

# example from http://stackoverflow.com/questions/10787640/ddply-summarize-for-repeating-same-statistical-function-across-large-number-of

# start by melting part2_data
library(reshape2)
melt_part2 <- melt(part2_data, .(Test, Subject))

# ddply by test, subject and variable
ddply_melted <- ddply(melt_part2, .(Test, Subject, variable), summarize, mean=mean(value))

# dcast to get back to one row for each test/subject combination
part5_data <- dcast(ddply_melted, Test + Subject ~ variable, value.var="mean")

# write the result as a txt file
write.table(part5_data, file="TidyData.txt")

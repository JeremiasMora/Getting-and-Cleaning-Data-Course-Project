##  Getting and Cleaning Data Course Project
# I prefer to use the data already downloaded to my computer.
library(data.table)
library(dplyr)

## Step 0 or loading data set

# Loading training data set

x.train = read.table('./train/x_train.txt',header = FALSE)
y.train = read.table('./train/y_train.txt',header = FALSE)
subject.train = read.table('./train/subject_train.txt',header = FALSE)
train = cbind(x.train, y.train, subject.train)

# Loading test data set
x.test = read.table('./test/x_test.txt',header = FALSE)
y.test = read.table('./test/y_test.txt',header = FALSE)
subject.test = read.table('./test/subject_test.txt',header = FALSE)
test = cbind(x.test, y.test, subject.test)

# Loading activity labels
activity = read.table("activity_labels.txt")


# Step 1
# Merge data
x.data = rbind(x.train, x.test)
y.data = rbind(y.train, y.test)
subject.data = rbind(subject.train, subject.test)
names(subject.data) = "Subject"
data = rbind(test, train)

# Step 2
# Mean and standard deviation for each measurement
features = read.table("features.txt")[, 2]
mean.std = x.data[, grep("-(mean|std)\\(\\)",features)]
names(mean.std) = read.table("features.txt")[grep("-(mean|std)\\(\\)", features), 2]


# Step 3
# Descriptive activity names
y.data[, 1] = activity[y.data[, 1], 2]
names(y.data) = "Activity"
final.data = cbind(mean.std, y.data, subject.data)


# Step 4
# Appropriately labels
names(final.data) = make.names(names(final.data))
names(final.data) = gsub('Acc', "Acceleration", names(final.data))
names(final.data) = gsub('GyroJerk', "AngularAcceleration", names(final.data))
names(final.data) = gsub('Gyro', "AngularSpeed", names(final.data))
names(final.data) = gsub('Mag', "Magnitude", names(final.data))
names(final.data) = gsub('^t', "TimeDomain.", names(final.data))
names(final.data) = gsub('^f', "FrequencyDomain.", names(final.data))
names(final.data) = gsub('\\.mean', ".Mean", names(final.data))
names(final.data) = gsub('\\.std', ".StandardDeviation", names(final.data))
names(final.data) = gsub('Freq\\.', "Frequency.", names(final.data))
names(final.data) = gsub('Freq$', "Frequency", names(final.data))


# Step 5
# Create data
tidydata = final.data %>%
    group_by(Subject, Activity) %>%
    summarise_all(funs(mean))
write.table(tidydata, "tidydata.txt", row.name=FALSE)

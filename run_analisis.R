#Se realizo una lectura de todos los archivos que estaban comprimidos

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt" )


#Se colocaron los nombres de las columna de test

colnames(xtest) = features[,2]
colnames(ytest) = "activityID"
colnames(subjectest) = "subjectID"


#Se realizo los nombres de las columnas de train

colnames(xtrain) = features[,2]
colnames(ytrain) = "activityID"
colnames(subtrain) = "subjectID"


#Se mezclan los datasets hasta llegar a uno solo 

datatests <- cbind(ytest, subjectest, xtest)
datatrain <- cbind(ytrain, subtrain, xtrain)
alldata <- rbind(datatests, datatrain)


#Se hace un df de solo los promedios y las sd, y se saca el promedio

mean_sd <- select(alldata, contains("mean"), contains("std"))
labels <- merge(activity, mean_sd, by = "activityID")
tidy <- tapply(labels, labels[,1:89], mean)


#Queda los datos limpios para trabajar

alltidy <- cbind(tidy, labels)
write.table(alltidy, "tidydata.txt", row.names = FALSE)
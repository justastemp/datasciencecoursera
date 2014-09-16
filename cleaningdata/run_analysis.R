## This function calculates stuff


analyseAll <- function(destsa="mean_by_subj_act.txt", dests="mean_by_subj.txt",
                       desta="mean_by_act.txt") {
     ## Read the activity data, read subject data and
     ## read big data set using Roger Peng's classes trick
     ## to speed things up
     ## Read all test data: activities a, subject sub, data test
     a <- read.table("test/y_test.txt")
     sub <- read.table("test/subject_test.txt")
     test5rows <- read.table("test/X_test.txt", nrows =5)
     classes <- sapply(test5rows, class)
     test <- read.table("test/X_test.txt", colClasses = classes)
     ## Now bind all
     atest <- cbind(a,test)
     testset <- cbind(sub,atest)
     ## Redo most of that for training set
     a <- read.table("train/y_train.txt")
     sub <- read.table("train/subject_train.txt")
     train <- read.table("train/X_train.txt", colClasses = classes)
     atrain <- cbind(a,train)
     trainset <- cbind(sub,atrain)
     ## Time to rbind the whole set
     wholeset <- rbind(trainset,testset)
     ## Set colnames
     ## Data names come from features.txt
     features <- read.table("features.txt")
     feat2 <- as.character(features[,2])
     mycolnames <- c("subject","activity", feat2)
     colnames(wholeset) <- mycolnames
     ## Replace activity numbers by useful names, quick and dirty
     ## Activities: 1 walk, 2 walk upstairs, 3 walk downstairs
     ##             4 sit, 5 stand, 6 lie
     wholeset$activity<- gsub("1","walk",wholeset$activity)
     wholeset$activity<- gsub("2","walk up",wholeset$activity)
     wholeset$activity<- gsub("3","walk down",wholeset$activity)
     wholeset$activity<- gsub("4","sit",wholeset$activity)
     wholeset$activity<- gsub("5","stand",wholeset$activity)
     wholeset$activity<- gsub("6","lie",wholeset$activity)
     ## Tidy up by eliminating columns that don't have mean(), 
     ## Mean or std() as part of their names
     ## Find all desired column names by grepping for [Mm]ean and std
     ## I omit the meanFreq entries
     means <- feat2[grepl("mean[^a-zA-Z]",feat2)]
     Means <- feat2[grepl("Mean",feat2)]
     stds <- feat2[grepl("std",feat2)]
     all <- c(means,Means,stds)
     names <- c("subject","activity",all)
     cols <- as.character(colnames(wholeset))
     mycols <- cols[cols %in% c(names)] ## This way we avoid reordering of 
                                        ## columns
     ## And now we only choose those columns with mean and std data
     wholeset2 <- wholeset[, mycols] ## still, 75 columns in total!
     ## Time to calculate the averages by subject and activity and put
     ## all that in a nice(r) table, where we do all columns in one go
     finaltable <- aggregate(wholeset2[,3:75],list(Subject = wholeset2$subject,                    Activity = wholeset2$activity), mean)
     tact<-aggregate(wholeset2[,3:75],list(Activity = wholeset2$activity), mean)
     tsub <- aggregate(wholeset2[,3:75],list(Subject = wholeset2$subject), mean)
     write.table(finaltable, destsa, row.name = FALSE)
     write.table(tact, desta, row.name = FALSE)
     write.table(tsub, dests, row.name = FALSE)
}


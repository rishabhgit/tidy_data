run_analysis <- function(){
    
    cnames <- character()
    
    # read measurements and combine them
    train <- readTrainFiles()
    test <- readTestFiles()
    total <- rbind(test, train)
    
    # create index for mean and standard deviation measurements
    index <- msd_index()
    
    # subset to have only mean and std dev data
    msd <- total[,index]
    
    #read Activity and Feature files
    aLabels <- readLabels("activity_labels.txt")
    fLabels <- readLabels("features.txt")
    
    # Add activtiy Labels in the data set
    msd[,67] <- aLabels[msd[,67],2]
    
    # Add Feature labels to column_names
    cnames <- fLabels[head(index, n=-2),2]
    cnames <- append(cnames,c("activity", "subject"))
    colnames(msd) <- cnames
    
    #order dataset by subject and activity
    msd <- msd[order(msd$subject, msd$activity),]
    
    #find mean of all readings by subject and activity
    mtidy <- aggregate(msd,by=list(subject=msd$subject, activity=msd$activity),
                       FUN=mean, na.rm=TRUE)
    mtidy <- mtidy[,1:68]
    
    write.table(mtidy, file="./tidy_wearable.txt", row.names=FALSE)
    return(mtidy)
}

msd_index <- function(){
    
    sixer_base <- c(0,40,80,120,160,265,344,423)
    couple_base <- c(200,213,226,239,252,502,515,528,541)
    index <- numeric()
    for (i in seq_along(sixer_base)){
        for (j in 1:6){
            index <- append(index,sixer_base[i]+j)
        }
    }
    for (i in seq_along(couple_base)){
        index <- append(index, c(couple_base[i]+1, couple_base[i]+2))
    }
    # add index for activity and subject data
    index <- append (index, c(562,563))
    return(sort(index))
}

readTrainFiles <- function() {
    setwd("/home/rishabh/R_files")
    
    # read training data files
    train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
    train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
    train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    #combine subjects and activities with the training data
    train_all <- cbind(train_data, train_activity, train_subject)
    
    
    
    return(train_all)
    
}

readTestFiles <- function() {
    
    
        
    # read test data files
    test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
    test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
    test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
    #combine subjects and activities with the test data
    test_all <- cbind(test_data, test_activity, test_subject)
    
    return(test_all)
    
}

readLabels <- function(name) {
    
    path <- paste("./UCI HAR Dataset/", name, sep="")
    return(read.table(path, stringsAsFactors=FALSE))
    
    
}

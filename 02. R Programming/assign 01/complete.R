library(data.table)
setwd("~/coursera/02. R Programming/assign 01")

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  files <- dir(directory, pattern = '\\.csv', full.names = TRUE)
  tables <- lapply(files, read.csv)
  data_table <- rbindlist(tables)
  
  only_complete <- data_table[complete.cases(data_table)][ID %in% id]
  
  df <- within(only_complete, nobs <- ave(ID, list(ID), FUN=length))
  my_df <- df[,c(4,5),with=FALSE]
  my_df[!duplicated(my_df),]
}


##complete("specdata", 1)
##complete("specdata", c(2, 4, 8, 10, 12))
##complete("specdata", 332:1)
##complete("specdata", 3)

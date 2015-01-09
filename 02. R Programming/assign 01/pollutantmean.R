library(data.table)
setwd("~/coursera/02. R Programming/assign 01")
pollutantmean <- function(directory, pollutant, monitor_id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  data_table <- load_data(directory)
  ##print(subset(data_table,ID %in% monitor_id))
  x<- mean(subset(data_table,ID %in% monitor_id)[[pollutant]], na.rm=TRUE)
  round(x, 3)
}

load_data <- function(directory) {
  files <- dir(directory, pattern = '\\.csv', full.names = TRUE)
  tables <- lapply(files, read.csv)
  rbindlist(tables)
}

##pollutantmean("specdata", "sulfate", 1:10)
##pollutantmean("specdata", "nitrate", 70:72)
##pollutantmean("specdata", "nitrate", 23)

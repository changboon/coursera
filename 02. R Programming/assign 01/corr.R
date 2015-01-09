library(data.table)
source("complete.R")
setwd("~/coursera/02. R Programming/assign 01")
corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
 
  files_full <- list.files(directory, full.names = TRUE)
  N <- as.numeric(length(files_full))
  
  i=1
  correlation <- as.numeric()
  while (i <= N) {
    filenames <- sprintf("%03d.csv", i)
    filedir <- file.path(directory, filenames)
    data_table <- read.csv(filedir)
    
    nobs<- sum(complete.cases(data_table))
    
    if (nobs > threshold) {
      
      data_table <- data_table[complete.cases(data_table),][,c(2,3)]
      #print (head(cor(data_table)))
      correlation <- c(correlation, cor(data_table)[2,1])
    }
    i = i+1
  }
  correlation
}

# cr <- corr("specdata", 150)
# head(cr)
# summary(cr)
# cr <- corr("specdata", 400)
# head(cr)
# summary(cr)
# cr <- corr("specdata", 5000)
# summary(cr)
# length(cr)
# cr <- corr("specdata")
# summary(cr)
# length(cr)
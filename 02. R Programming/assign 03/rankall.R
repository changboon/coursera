setwd("~/coursera/02. R Programming/assign 03")

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  states <- unique(data[,7])
  data[,11] <- as.numeric(data[,11])
  data[,17] <- as.numeric(data[,17])
  data[,23] <- as.numeric(data[,23])
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (outcome %in% valid_outcomes) {
    if (num=="best") {
      num <- 1
    }
    if (outcome=="heart attack") {
      relevant <- data[,c(2,7,11)]
      relevant <- relevant[complete.cases(relevant),]
      split_data <- split(relevant, relevant[,2])
      results <- lapply(split_data, rank_data, num)
      results <- as.data.frame(do.call(rbind, results))
      names(results) <- c("hospital", "state")
      results
    } else if (outcome == "heart failure") {
      relevant <- data[,c(2,7,17)]
      relevant <- relevant[complete.cases(relevant),]
      split_data <- split(relevant, relevant[,2])
      results <- lapply(split_data, rank_data, num)
      results <- as.data.frame(do.call(rbind, results))
      names(results) <- c("hospital", "state")
      results
    } else if (outcome == "pneumonia") {
      relevant <- data[,c(2,7,23)]
      relevant <- relevant[complete.cases(relevant),]
      split_data <- split(relevant, relevant[,2])
      results <- lapply(split_data, rank_data, num)
      results <- as.data.frame(do.call(rbind, results))
      names(results) <- c("hospital", "state")
      results
    }
  } else {
    stop("invalid outcome")
  }
}

rank_data <- function (x, num = 1, state) {
  
  sorted <- x[order(x[,3],x[,1]),]
  if (num=="worst") {
    num <- nrow (sorted)
  }
  cbind(sorted[num,1], sorted[1,2])
}

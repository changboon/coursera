setwd("~/coursera/02. R Programming/assign 03")

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  states <- unique(data[,7])
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (state %in% states) {
    if (outcome %in% valid_outcomes) {
      if (num == "best") {
        num <- 1
      }
      if (outcome=="heart attack") {
        relevant <- data[data$State==state,][,c(2,11)]
        relevant[,2] <- as.numeric(relevant[,2])
        relevant <- relevant[complete.cases(relevant),]
        sorted <- relevant[order(relevant[,2],relevant[,1]),]
        if (num=="worst") {
          num <- nrow (sorted)
        }
        sorted[num,1]
      } else if (outcome == "heart failure") {
        relevant <- data[data$State==state,][,c(2,17)]
        relevant[,2] <- as.numeric(relevant[,2])
        relevant <- relevant[complete.cases(relevant),]
        sorted <- relevant[order(relevant[,2],relevant[,1]),]
        if (num=="worst") {
          num <- nrow (sorted)
        }
        sorted[num,1]
      } else if (outcome == "pneumonia") {
        relevant <- data[data$State==state,][,c(2,23)]
        relevant[,2] <- as.numeric(relevant[,2])
        relevant <- relevant[complete.cases(relevant),]
        sorted <- relevant[order(relevant[,2],relevant[,1]),]
        if (num=="worst") {
          num <- nrow (sorted)
        }
        sorted[num,1]
      }
    } else {
      stop("invalid outcome")
    }
  } else {
    stop("invalid state")
  }
}


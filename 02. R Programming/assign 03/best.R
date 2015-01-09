setwd("~/coursera/02. R Programming/assign 03")

best <- function(state, outcome) {
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  states <- unique(data[,7])
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (state %in% states) {
    if (outcome %in% valid_outcomes) {
      if (outcome=="heart attack") {
        relevant <- data[data$State==state,][,c(2,11)]
        relevant[,2] <- as.numeric(relevant[,2])
        relevant <- relevant[complete.cases(relevant),]
        relevant[,1][relevant[,2]==min(relevant[,2])]
      } else if (outcome == "heart failure") {
        relevant <- data[data$State==state,][,c(2,17)]
        relevant[,2] <- as.numeric(relevant[,2])
        relevant <- relevant[complete.cases(relevant),]
        relevant[,1][relevant[,2]==min(relevant[,2])]
      } else if (outcome == "pneumonia") {
        relevant <- data[data$State==state,][,c(2,23)]
        relevant[,2] <- as.numeric(relevant[,2])
        relevant <- relevant[complete.cases(relevant),]
        relevant[,1][relevant[,2]==min(relevant[,2])]
      }
    } else {
      stop("invalid outcome")
    }
  } else {
    stop("invalid state")
  }
}

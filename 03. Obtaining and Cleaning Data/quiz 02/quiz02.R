library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", key="a48c3672ccc822990af3", secret="ea0fed4c251a250675edbe997a8411e8907aa358
")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

setwd("~/coursera/03. Obtaining and Cleaning Data/quiz 02")
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("./data/AmericanCommunitySurvey.csv")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
  download.file(fileUrl, destfile = "./data/AmericanCommunitySurvey.csv")
}

acs <- data.frame(read.csv("./data/AmericanCommunitySurvey.csv"))
names(acs)

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[[10]])
nchar(htmlCode[[20]])
nchar(htmlCode[[30]])
nchar(htmlCode[[100]])

if (!file.exists("./data/somefile.for")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
  download.file(fileUrl, destfile = "./data/somefile.for")
}
somefile <- data.frame(read.fwf("./data/somefile.for", c(12, 7,4, 9,4, 9,4, 9,4), skip=4))
head(somefile)
sum(somefile[,4])

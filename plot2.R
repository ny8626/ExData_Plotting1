# Exploratory Data Analysis Week 1 Course Project 1
# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site:

# Dataset: Electric power consumption [20Mb]
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

setwd("C:/Users/C10114/R")

library(dplyr)

file <- "./data/household_power_consumption.txt"
DATA <- read.table(file, header = TRUE, stringsAsFactors=FALSE, sep = ";", fileEncoding = "utf8") %>%
  filter(as.Date(Date, format = "%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date, format = "%d/%m/%Y") == as.Date("2007-02-02")) %>% 
  mutate(Date1 = paste(Date, Time)) %>%
  subset(select = c(3:10))

is.na(DATA) <- DATA =="?"       #Replace ? to NA
DATA <- na.omit(DATA)           #Delete rows which contain NA

#Mutate Date1 as POSIXct

DATA <- DATA %>% 
  mutate(Date1 = as.POSIXct(strptime(Date1, format = "%d/%m/%Y %H:%M:%S"))) %>% 
  mutate_if(is.character, as.numeric)


#Plot 2
png(file = "C:/Users/C10114/R/plot2.png", width = 480, height = 480, pointsize = 12, bg = 'white')
with(DATA, plot(Date1,Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab = ""))
dev.off()
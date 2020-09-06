
## Install necessary packages
library(dplyr)
if(!require("sqldf")){
        install.packages("sqldf")
}
library(sqldf)
 

## Set the file name
fileName <- "consumption_data"

if(!file.exists(fileName)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, fileName, method = "curl")
}

## Checking if data exists
if(!file.exists("household_power_consumption.txt")){
        unzip(fileName)
}


## Read in data from 2007-02-01 to 2007-02-02
consumption_data <- read.csv.sql("household_power_consumption.txt","select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")
consumption_data$Date <- as.Date(consumption_data$Date, format = "%m/%d/%Y")


## Plot 1
hist(consumption_data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

## Copy plot as a PNG file
dev.copy(png, file = "plot1.png", width = 489, height = 480)
dev.off()

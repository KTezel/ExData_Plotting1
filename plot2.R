
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

## Combine date and time
consumption_data$DateTime <- strptime(paste(consumption_data$Date, consumption_data$Time), format = "%d/%m/%Y %H:%M:%S")


## Plot 2
plot(consumption_data$DateTime, consumption_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Copy plot as a PNG file
dev.copy(png, file = "plot2.png", width = 489, height = 480)
dev.off()

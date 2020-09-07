
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

## Set the plotting area

## Create a png object
png("plot4.png", 480,480)

## Set the plot area, 2 by 2
par(mfrow = c(2,2))##, mar = c(4,4,4,4))

## Plot 1
plot(consumption_data$DateTime, consumption_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Plot 2
plot(consumption_data$DateTime, consumption_data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

## Plot 3
plot(consumption_data$DateTime, consumption_data$Sub_metering_1, type = "l", ylab = "Energy Submetering", xlab = "")
lines(consumption_data$DateTime, consumption_data$Sub_metering_2, type = "l", col = "red")
lines(consumption_data$DateTime, consumption_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, bty = "n",col=c("black", "red", "blue"))

## Plot 4
plot(consumption_data$DateTime, consumption_data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

## close the graphical device
dev.off()

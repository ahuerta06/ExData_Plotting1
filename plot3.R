
library(RCurl)
library(dplyr)
library(data.table)


URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile = "./data/power_consumption.zip"
# Download and unzip the files
if(!file.exists(zipFile)) {
    print("File doesn´t exist. It will be downloaded.")
    outDir <- "./data"
    dir.create(outDir)
    download.file(URL, zipFile)
    unzip(zipFile,exdir=outDir)
} else print("File already exists. Nothing was downloaded.")

#Read and filter the file
data<-fread("./data/household_power_consumption.txt", na.strings="?")
data<- filter(data, Date %in% c("1/2/2007", "2/2/2007"))

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

#Open the PNG device.
png("plot3.png",  width = 480, height = 480, units = "px")

    plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(data$DateTime,data$Sub_metering_2, col="red", type="l")
        lines(data$DateTime,data$Sub_metering_3, col="blue", type="l")
        legend("topright"
               , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
               , col=c("black", "red", "blue")
               , lty =1)
    
        print("File plot3.png has been created")

#Turn off the PNG device
dev.off()


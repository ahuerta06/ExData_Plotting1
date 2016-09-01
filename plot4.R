
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
png("plot4.png",  width = 480, height = 480, units = "px")

    #Change the properties so it prints the images in a 2x2 grid.
    par(mfrow=c(2,2))
    
    plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global active power")
    
    plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
    
    plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(data$DateTime,data$Sub_metering_2, col="red", type="l")
        lines(data$DateTime,data$Sub_metering_3, col="blue", type="l")
        legend("topright"
               , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
               , col=c("black", "red", "blue")
               , lty =1, bty = "n")
    
    plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global reactive power")
    
    
    print("File plot4.png has been created")

#Turn off the PNG device
dev.off()


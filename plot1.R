
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
data$Date<-as.Date(strptime(data$Date, "%d/%m/%Y"))

#Open the PNG device.
png("plot1.png",  width = 480, height = 480, units = "px")

    hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
    print("File plot1.png has been created")

#Turn off the PNG device
dev.off()


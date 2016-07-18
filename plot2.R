# download and unzip data file

if(!file.exists("powerData")) {dir.create("powerData")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="powerData\\powerData.zip")
unzip(zipfile="powerData\\powerData.zip", exdir="powerData")

# read data file into R

powerData <- read.table("powerData\\household_power_consumption.txt", 
                        header=TRUE, sep=";", stringsAsFactors=FALSE, dec="." )

# subset the data to get only the selected dates

subsetData <- subset(powerData, Date == "1/2/2007" | Date == "2/2/2007")

# paste together date/time values

datetimeData <- paste(subsetData$Date, subsetData$Time, sep=" ")

# convert data to correct classes for analysis 

datetimeData <- strptime(datetimeData, "%d/%m/%Y %H:%M:%S")
activePower <- as.numeric(subsetData$Global_active_power)

# construct the line graph and print to png

png("plot2.png", width=504, height=504)

plot(datetimeData, activePower, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
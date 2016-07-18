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
sub_metering1 <- as.numeric(subsetData$Sub_metering_1)
sub_metering2 <- as.numeric(subsetData$Sub_metering_2)
sub_metering3 <- as.numeric(subsetData$Sub_metering_3)

# construct the line graph and print to png

png("plot3.png", width=504, height=504)

plot(datetimeData, sub_metering1, type="l", ylab="Energy sub metering", xlab="")
lines(datetimeData, sub_metering2, type="l", col="red")
lines(datetimeData, sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"))

dev.off()


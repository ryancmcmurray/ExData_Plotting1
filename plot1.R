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

# convert the Global_active_power data to numeric in preparation for creating the histogram

activePower <- as.numeric(subsetData$Global_active_power)

# construct the histogram and write to png

png("plot1.png", width=504, height=504)

hist(activePower, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.off()
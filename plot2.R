## If file doesn't already exist, download the zip file and unzip it.

if(!file.exists("household_power_consumption.zip")) {
     zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
     download.file(zipUrl, "household_power_consumption.zip", mode = "wb")
     rm(zipUrl)
}

if(!file.exists("household_power_consumption.txt")) {
     unzip("household_power_consumption.zip")
}


## Read the .txt file into a data frame and subset to only necessary dates

powerData <- read.table("household_power_consumption.txt", header = TRUE,
                        sep = ";", na.strings = "?")
powerData <- powerData[powerData$Date == "1/2/2007" |
                       powerData$Date == "2/2/2007", ]


## Convert Date & Time using the as.Date and strptime functions

powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")
powerData$Time <- with(powerData, as.POSIXlt(paste(Date, Time),
                                             format = "%Y-%m-%d %H:%M:%S"))


## Open a new .png file, plot the data, and annotate accordingly. Followed by
## closing the .png file.

png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(powerData, plot(Time, Global_active_power, type = "l",
                     xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
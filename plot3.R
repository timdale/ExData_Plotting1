
##
## exdata-011 Project 1, Plot 3
##
##

##
## read the raw data, extract the dates we want, and get date/times in friendly format
##
readPowerData <- function() {
    data <- read.csv("../exdata-011/household_power_consumption.txt", 
                     header=T, sep=';', na.strings="?", 
                     nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
    
    ## convert the date to more convenient format
    data$Date <- as.Date(data$Date, format="%d/%m/%Y")
    
    ## we only want two days of data: Feb 1 & 2, 2007
    data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
    
    ## Converting dates
    data$Datetime <- as.POSIXct(paste(as.Date(data$Date), data$Time))
    
    data
}


data = readPowerData()

with(data, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime, col='Red')
    lines(Sub_metering_3~Datetime, col='Blue')
})

legend("topright", 
       col=c("black", "red", "blue"), 
       lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

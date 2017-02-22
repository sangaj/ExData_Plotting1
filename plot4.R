if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

Sys.setlocale(category = "LC_ALL", locale = "english")
par(mfrow = c(2, 2)) 
data <- read.table(file, header=T, sep=";",na.strings = "?")
subdata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
datetime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subdata$Global_active_power)
globalReactivePower <- as.numeric(subdata$Global_reactive_power)
voltage <- as.numeric(subdata $Voltage)
subMetering1 <- as.numeric(subdata$Sub_metering_1)
subMetering2 <- as.numeric(subdata$Sub_metering_2)
subMetering3 <- as.numeric(subdata$Sub_metering_3)

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
temp <- legend("topright", col=c("black", "red", "blue"), x.intersp=3,lty=1, text.width = strwidth("1,000,000"), bty="n",xjust = 1, yjust = 1,
      legend=c("", "", ""),cex=0.3,y.intersp = 0.35)
text(temp$rect$left + temp$rect$w, temp$text$y,
     c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pos = 2)
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
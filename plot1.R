
### Check the data file otherwise download and unzip it
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

### read data and plot it 
data <- read.table(file, header=T, sep=";",na.strings = "?")
subdata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
subdata$Date <- strptime(subdata$Date,"%d/%m/%Y")
subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))
hist(subdata$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()


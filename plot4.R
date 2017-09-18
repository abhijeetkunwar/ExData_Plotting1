fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "power_consumption_data.zip"
if(!file.exists(fileName))
{
        download.file(fileUrl, destfile = fileName, method = "curl")
}

if(!file.exists("household_power_consumption.txt"))
{
        unzip(fileName)
}

data <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)
subdata <- subset(data, !is.na(Date) & !is.na(Time) & (Date %in% c("1/2/2007","2/2/2007")))
subdata[,2] <- paste(subdata$Date, subdata$Time, sep=" ")
time <- strptime(subdata$Time, "%d/%m/%Y %H:%M:%S")
voltage <- as.numeric(subdata$Voltage)
globalActivePower <- as.numeric(subdata$Global_active_power)
globalReactivePower <- as.numeric(subdata$Global_reactive_power)
sub_metering1 <- as.numeric(subdata$Sub_metering_1)
sub_metering2 <- as.numeric(subdata$Sub_metering_2)
sub_metering3 <- as.numeric(subdata$Sub_metering_3)
rm(data, subdata)
png(filename = "plot4.png", height = 480, width = 480)
par(mfrow=c(2,2))
plot(time, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(time, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(time, sub_metering1, type="l", ylab="Energy Submetering", xlab="")
lines(time, sub_metering2, type="l", col="red")
lines(time, sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(time, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()

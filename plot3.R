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
sub_metering1 <- as.numeric(subdata$Sub_metering_1)
sub_metering2 <- as.numeric(subdata$Sub_metering_2)
sub_metering3 <- as.numeric(subdata$Sub_metering_3)
rm(data, subdata)
png(filename = "plot3.png", height = 480, width = 480)
plot(time, sub_metering1, type="l", xlab="", ylab="Energy Submetering")
lines(time, sub_metering2, type="l", col="red")
lines(time, sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

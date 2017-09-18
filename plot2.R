fileName <- "power_consumption_data.zip"
if(!file.exists(fileName))
{
        download.file(fileUrl, destfile = fileName, method = "curl")
}

if(!file.exists("household_power_consumption.txt"))
{
        unzip(fileName)
}

data <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
subdata <- subset(data, !is.na(Date) & !is.na(Time) & (Date == "1/2/2007" | Date == "2/2/2007"))
subdata[,2] <- paste(subdata$Date, subdata$Time, sep=" ")
mod_subdata <- subdata
mod_subdata$Time <- strptime(mod_subdata$Time, "%d/%m/%Y %H:%M:%S")
mod_subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
rm(data, subdata)
png(filename = "plot2.png", height = 480, width = 480, bg = "white")
plot(mod_subdata$Time, mod_subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

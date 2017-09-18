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
subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
rm(data)
png(filename = "plot1.png", height = 480, width = 480, bg = "white")
hist(subdata$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

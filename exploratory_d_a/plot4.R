## The code for plot 4

## We start reading the txt file, but we know that we find our 2 dates
## of interest between lines 66000 and 70000, so we keep everything small

test  <- read.table("household_power_consumption.txt", nrows =5, sep=";", 
         header = TRUE)
mycols <- colnames(test)
raw  <- read.table("household_power_consumption.txt", sep=";", 
        header = TRUE, skip = 66000, nrows = 4000)
colnames(raw) <- mycols
data <- raw[(as.character(raw$Date) %in% c("1/2/2007", "2/2/2007")),]
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(data$Global_active_power, type = "l", xlab = "", xaxt = "n",
     ylab = "Global Active Power (kilowatts)")
Axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))

plot(data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
Axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))

plot(c(0,2880),c(0,38), type="n", xlab = "", xaxt="n", ylab = "Energy sub metering")
lines(data$Sub_metering_1, col = "black", lwd=1)
lines(data$Sub_metering_2, col = "red", lwd=1)
lines(data$Sub_metering_3, col = "blue", lwd=1)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), lwd=c(1,1,1), col = c("black","red","blue"))
Axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))

plot(data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
Axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))
dev.off()



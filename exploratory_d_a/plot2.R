## The code for plot 2

## We start reading the txt file, but we know that we find our 2 dates
## of interest between lines 66000 and 70000, so we keep everything small

test  <- read.table("household_power_consumption.txt", nrows =5, sep=";", 
         header = TRUE)
mycols <- colnames(test)
raw  <- read.table("household_power_consumption.txt", sep=";", 
        header = TRUE, skip = 66000, nrows = 4000)
colnames(raw) <- mycols
data <- raw[(as.character(raw$Date) %in% c("1/2/2007", "2/2/2007")),]
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data$Global_active_power, type = "l", xlab = "", xaxt = "n", 
     ylab = "Global Active Power (kilowatts)")
Axis(side = 1, at = c(1,1441,2880), labels = c("Thu", "Fri", "Sat"))
dev.off()

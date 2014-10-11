## The code for plot 1

## We start reading the txt file, but we know that we find our 2 dates
## of interest between lines 66000 and 70000, so we keep everything small

test  <- read.table("household_power_consumption.txt", nrows =5, sep=";", 
         header = TRUE)
mycols <- colnames(test)
raw  <- read.table("household_power_consumption.txt", sep=";", 
        header = TRUE, skip = 66000, nrows = 4000)
colnames(raw) <- mycols
data <- raw[(as.character(raw$Date) %in% c("1/2/2007", "2/2/2007")),]
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

library(lubridate)
dt <- read.table("household_power_consumption.txt", head = TRUE, sep = ";", 
                 na.strings="?")
#set Date/Time class
time <- paste(dt$Date, dt$Time)
class(time)
k<- strptime(time, "%d/%m/%Y %H:%M:%S")
dt$Date <- as.Date(k, "%Y-%m-%d")

#Filter date set for specific days required
filter <- as.Date(c(" 2007-02-01", "2007-02-02"), "%Y-%m-%d")
j <- dt$Date %in% filter
new_dt <- dt[j,]

# Create and output the graph to png file.
png(filename = "plot1.png")

hist(new_dt$Global_active_power, breaks = 15,
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()


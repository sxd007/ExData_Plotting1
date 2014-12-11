library(lubridate)
dt <- read.table("household_power_consumption.txt", head = TRUE, sep = ";", 
                 na.strings="?")
#set Date/Time class
time <- paste(dt$Date, dt$Time)
class(time)
k<- strptime(time, "%d/%m/%Y %H:%M:%S")
dt$Date <- as.Date(k, "%Y-%m-%d")
dt$k <- k
#Filter date set for specific days required
filter <- as.Date(c(" 2007-02-01", "2007-02-02"), "%Y-%m-%d")
j <- dt$Date %in% filter
new_dt <- dt[j,]

# Create and output the graph to png file.
png(filename = "plot4.png")
par(mfrow=c(2,2))
# insert top left graphic
plot(new_dt$k,new_dt$Global_active_power, type = "l", xlab="", ylab="Global Active Power")
# insert top right graphic
plot(new_dt$k, new_dt$Voltage, type = "l", xlab="datetime", ylab="Voltage")
# insert bottom left graphic
plot(new_dt$k, new_dt$Sub_metering_1,"l", col = "black", ylim=range(new_dt$Sub_metering_1), xlab = "", ylab="Energy Sub Metering")
par(new = TRUE)
plot(new_dt$k, new_dt$Sub_metering_2,"l", col = "red", ylim=range(new_dt$Sub_metering_1), xlab ="", ylab="")
par(new = TRUE)
plot(new_dt$k, new_dt$Sub_metering_3,"l", col = "blue", ylim=range(new_dt$Sub_metering_1), xlab ="", ylab="")
legend("topright",pch="-",col=c("black","red","blue"),cex = 1,bty = "n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# insert bottom right graphic
plot(new_dt$k, new_dt$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
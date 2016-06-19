library(dplyr)
library(data.table)
library(tidyr)

# read in data and tidy
file <- "./household_power_consumption.txt"
pwrdata <- fread(file, na.strings = "?", stringsAsFactors = FALSE)
pwrsubset <- filter(pwrdata, grep("^[1,2]/2/2007", Date))
pwrsubset <- unite(pwrsubset, Date_Time, Date, Time, sep = " ", remove = TRUE)

# plot graph and write to PNG file
Date_Time <- strptime(pwrsubset$Date_Time, "%d/%m/%Y %H:%M:%S")
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

plot(Date_Time, pwrsubset$Global_active_power,  type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
        
plot(Date_Time, pwrsubset$Voltage,  type = "l", ylab = "Voltage", 
     xlab = "datetime")
        
plot(Date_Time, pwrsubset$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")
lines(Date_Time, pwrsubset$Sub_metering_2, type = "l", col = "red")
lines(Date_Time, pwrsubset$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_Metering_2", "Sub_Metering_3"), 
       lty = 1, lwd = 2.5, col = c("black", "red", "blue"))
        
plot(Date_Time, pwrsubset$Global_reactive_power,  type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")
        
dev.off()
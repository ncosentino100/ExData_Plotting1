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
png(file = "plot2.png", width = 480, height = 480)
plot(Date_Time, pwrsubset$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()


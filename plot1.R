library(dplyr)
library(data.table)

# read in data and tidy
file <- "./household_power_consumption.txt"
pwrdata <- fread(file, na.strings = "?", stringsAsFactors = FALSE)
pwrsubset <- filter(pwrdata, grep("^[1,2]/2/2007", Date))
pwrsubset <- unite(pwrsubset, Date_Time, Date, Time, sep = " ", remove = TRUE)

# plot graph and write to PNG file
png(file = "plot1.png", width = 480, height = 480)
hist(pwrsubset$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()

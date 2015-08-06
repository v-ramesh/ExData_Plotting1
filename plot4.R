#LOAD DATA

# Unzipped data file saved as "data/household_power_consumption.txt"
filename <- file.path("data", "household_power_consumption.txt")

# Subsetting the data for the two days of interest directly to avoid memory
# issues with storing the whole dataset in memory
data_two_days <- subset(read.csv(filename, sep=";", na.strings="?", 
                                 stringsAsFactors=FALSE),
                        Date %in% c("1/2/2007", "2/2/2007"))

# Create a new column datetime in POSIXlt class format from 
# Date and Time columns
data_two_days$datetime = strptime(paste(data_two_days$Date, 
                                        data_two_days$Time, sep = " "),
                                  format = "%d/%m/%Y %T")


# PLOT DATA

png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")
par(mfrow = c(2,2))

#Top Left Plot
with(data_two_days,
     plot(datetime, Global_active_power, type = "l",
          xlab = "", ylab = "Global Active Power"))

#Top Right Plot
with(data_two_days,
     plot(datetime, Voltage, type = "l"))

#Bottom Left Plot
with(data_two_days,
     plot(datetime, Sub_metering_1, type = "l",
          xlab = "", ylab = "Energy sub metering"))
with(data_two_days,
     points(datetime, Sub_metering_2, type = "l", col = "red"))
with(data_two_days,
     points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = 1, bty = "n")

#Bottom Right Plot
with(data_two_days,
     plot(datetime, Global_reactive_power, type = "l"))

dev.off()

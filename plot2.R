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

png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")
with(data_two_days,
     plot(datetime, Global_active_power, type = "l",
          xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

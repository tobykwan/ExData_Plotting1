#
# plot2.R
# 
# This script does the following:
# 1) Read the household_power_consumption.txt CSV file
# 2) Extracts only the 2 days of data on 2007-02-01 and 2007-02-02
# 3) Plot graph 2 and save it as PNG

# Read the original CSV file
df <- read.csv2("household_power_consumption.txt", na.strings = "?", dec=".",
                colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert the date + time character fields to POSIXlt
df$DateTime <- strptime(paste(df$Date, df$Time, sep = ", "), format = "%d/%m/%Y, %H:%M:%S")

# Subset for the target two days 2007-02-01 and 2007-02-02 (i.e. before 2007-02-03)
df2 <- subset(df, DateTime >= as.POSIXlt("2007-02-01") & DateTime < as.POSIXlt("2007-02-03"))

# Open the PNG file for writing
png(filename = "plot2.png",
    width=480, height=480, units="px")

# Draw the graph
with(df2, {
    plot(DateTime, Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")
    lines(DateTime, Global_active_power, type = "l")
})

# Finish off the graph by closing it
dev.off()
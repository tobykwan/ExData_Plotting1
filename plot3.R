#
# plot3.R
# 
# This script does the following:
# 1) Read the household_power_consumption.txt CSV file
# 2) Extracts only the 2 days of data on 2007-02-01 and 2007-02-02
# 3) Plot graph 3 and save it as PNG

# Read the original CSV file
df <- read.csv2("household_power_consumption.txt", na.strings = "?", dec=".",
                colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert the date + time character fields to POSIXlt
df$DateTime <- strptime(paste(df$Date, df$Time, sep = ", "), format = "%d/%m/%Y, %H:%M:%S")

# Subset for the target two days 2007-02-01 and 2007-02-02 (i.e. before 2007-02-03)
df2 <- subset(df, DateTime >= as.POSIXlt("2007-02-01") & DateTime < as.POSIXlt("2007-02-03"))

# Open the PNG file for writing
png(filename = "plot3.png",
    width=480, height=480, units="px")

# Draw the graph
with(df2, {
    plot(DateTime, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
    lines(DateTime, Sub_metering_1, type = "l", col="black")
    points(DateTime, Sub_metering_2, type="n")
    lines(DateTime, Sub_metering_2, type = "l", col="red")
    points(DateTime, Sub_metering_3, type="n")
    lines(DateTime, Sub_metering_3, type = "l", col="blue")
    legend("topright", lty=1, lwd=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Finish off the graph by closing it
dev.off()
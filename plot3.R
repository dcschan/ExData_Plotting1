# the following command was executed in Git Bash to extract rows corresponding to the required dates
# and write to file data.txt:
# "grep '^[1|2]\/2\/2007' household_power_consumption.txt > data.txt"

data = read.table("data.txt", header=TRUE, sep=';', na.strings='?')
cols = c('Date', 'Time', 'GlobalActivePower', 'GlobalReactivePower', 'Voltage', 'GlobalIntensity', 'SubMetering1', 'SubMetering2', 'SubMetering3') 
colnames(data) = cols
data$Date = as.Date(data$Date, format="%d/%m/%Y")

data = transform(data, datetime=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

plot(data$datetime, data$SubMetering1, xlab = '', ylab = 'Energy sub metering', type = 'l')
lines(data$datetime, data$SubMetering2, col="red")
lines(data$datetime, data$SubMetering3, col="blue")

legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1))

dev.copy(png, file = "plot3.png", width=480, height=480, units='px')
dev.off()
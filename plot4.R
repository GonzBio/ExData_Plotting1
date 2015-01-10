#data.table module is needed to access fread, install if needed
library(data.table)
#reads only rows with data 1 or 2/2/2007
data <- fread(paste("grep ^[12]/2/2007", "./household_power_consumption.txt"), na.strings = c("?", ""))
#use the first row from file to set column names
setnames(data, colnames(fread("./household_power_consumption.txt", nrows=0)))
#grep search adds to the file rows with 11,12,21,22 so we need to exclude them
data2 <- data[data$Date %in% c("1/2/2007","2/2/2007" ),]
#values in column need to be transformed into integers
data2 <- transform(data2, Global_active_power = as.numeric(Global_active_power))
#new column with values in column transformed into POSIXct format
data2$DateTime <- as.POSIXct(paste(data2$Date, data2$Time), format="%d/%m/%Y %H:%M:%S") 
#creates 4 by 4 figure with plot dimension of 2.7 (horizontal) and 2.5 (vertical) 
par(mfrow = c(2,2), pin = c(1.5,1.5), mar = c(3,4,2,2)) #adds figures by row
#plot 1
plot(data2$DateTime, data2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#plot 2
plot(data2$DateTime, data2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#plot3
plot(data2$DateTime, data2$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(data2$DateTime, data2$Sub_metering_2, type = "l", col = "red")
lines(data2$DateTime, data2$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), inset = c(0.15, 0.05), cex = 0.5, bty = "n", lty=c(1,1,1),col=c("black","blue","red"))
#plot4
plot(data2$DateTime, data2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

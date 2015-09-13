# reading the data
houselc <- read.csv2("household_power_consumption.txt", 
                     colClasses = "character")

# get only data between the 01/02 and 02/02 2007
houselc$Date <- as.Date(houselc$Date, "%d/%m/%Y")
i <- which(houselc$Date <= "2007/02/02" & houselc$Date >= "2007/02/01")
dataelec <- houselc[i,]

# converting column time from Charaters to datetime format
dataelec$Time <- strptime(paste(dataelec$Date, dataelec$Time), "%Y-%m-%d %H:%M:%S")

# Converting the strings to numbers
dataelec$Global_active_power <- as.numeric(dataelec$Global_active_power)
dataelec$Sub_metering_1 <- as.numeric(dataelec$Sub_metering_1)
dataelec$Sub_metering_2 <- as.numeric(dataelec$Sub_metering_2)
dataelec$Sub_metering_3 <- as.numeric(dataelec$Sub_metering_3)

#create the png file
png(file = "plot4.png", width=480, height=480)

#split the screen to 4 areas  

par(mfcol = c(2,2))

#Graph 1
plot(x = dataelec$Time,dataelec$Global_active_power, type = "l"
     , ylab ="Global Active Power", xlab = "")

#Graph 2
plot(x = dataelec$Time,dataelec$Sub_metering_1,type = "l",
     ylab = "Energy sub metering", xlab = "")
points(x = dataelec$Time,dataelec$Sub_metering_2,type = "l", col="red")
points(x = dataelec$Time,dataelec$Sub_metering_3,type = "l", col="blue")
legend("topright", legend = names(dataelec[,7:9]),lwd = 1, col = c("black","red","blue"))

#Graph 3
with(dataelec, plot(x =Time,y = Voltage, type = "l", xlab = "datetime"))

#Graph 4
with(dataelec, plot(x =Time,y = Global_reactive_power, type = "l", xlab = "datetime"))


#shut down the activity
dev.off()

#clean the env
rm(list = ls())
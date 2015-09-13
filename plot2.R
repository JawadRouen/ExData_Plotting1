# reading the data
houselc <- read.csv2("household_power_consumption.txt", 
                     colClasses = "character")

# get only data between the 01/02 and 02/02 2007
houselc$Date <- as.Date(houselc$Date, "%d/%m/%Y")
i <- which(houselc$Date <= "2007/02/02" & houselc$Date >= "2007/02/01")
dataelec <- houselc[i,]

# Converting the strings to numbers
dataelec$Global_active_power <- as.numeric(dataelec$Global_active_power)

# converting column time from Charaters to datetime format
dataelec$Time <- strptime(paste(dataelec$Date, dataelec$Time), "%Y-%m-%d %H:%M:%S")

# plot the global Active Power by time change
plot(x = dataelec$Time,dataelec$Global_active_power, type = "l"
     , ylab ="Global Active Power (in kilowatts)", xlab = "")

# save the graph in png file
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()

#clean the env
rm(list = ls())
#Read and set up data.frame
setwd("/Users/marsh/Downloads/")
householddata <- read.csv("household_power_consumption.txt", header = TRUE,
                          sep = ';', stringsAsFactors = FALSE)
mydata <- householddata[(householddata$Date == '1/2/2007' | householddata$Date
                         == '2/2/2007'),]
mydata$Date <- as.Date(mydata$Date, format = '%d/%m/%Y')
mydata <- mutate(mydata, Date.Time = paste(mydata$Date, mydata$Time))
mydata$Date.Time <- strptime(mydata$Date.Time, format = "%Y-%m-%d %H:%M:%S")
mydata <- select(mydata, Date, Time, Date.Time, Global_active_power,
                 Global_reactive_power, Voltage, Global_intensity,
                 Sub_metering_1, Sub_metering_2, Sub_metering_3)

par(mfrow = c(2,2), cex = 0.5, cex.lab = 1.25, cex.axis = 1.25)

#Create plot 1
with(mydata, plot(Date.Time, Global_active_power, type = 'l', xlab = "",
                  ylab = "Global Active Power (kilowatts)"))

#Create plot 2
with(mydata, plot(Date.Time, Voltage, type = 'l', xlab = "datetime",
                  ylab = "Voltage"))

#Create plot 3
with(mydata, plot(Date.Time, Sub_metering_1, type = 'l', xlab = "",
                  ylab = "Energy sub metering",
                  ylim = as.numeric(c(0,max(Sub_metering_1, Sub_metering_2, 
                                            Sub_metering_3)))))
lines(mydata$Date.Time, mydata$Sub_metering_2, type = 'l', col = 'red')
lines(mydata$Date.Time, mydata$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       pch = '-', lty = 1, seg.len = 2, bty = "n", cex = 1,
       col = c("black","red","blue"))

#Create plot 4
with(mydata, plot(Date.Time, Global_reactive_power, type = 'l',
                  xlab = "dateime", ylab = "Global_reactive_power",
                  ylim = as.numeric(c(0, max(Global_reactive_power)))))

#Send graphic to file
setwd("/Users/marsh/datasciencecoursera/exploratory_data_analysis/")
dev.copy(png, "plot4.png")
dev.off()

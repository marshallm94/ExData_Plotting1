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

#Create Plot
with(mydata, plot(Date.Time, Global_active_power, type = 'l', xlab = "",
                  ylab = "Global Active Power (kilowatts)"))

#Send graphic to file
setwd("/Users/marsh/datasciencecoursera/exploratory_data_analysis/")
dev.copy(png, file = "plot2.png")
dev.off()

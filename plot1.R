#Read and set up data.frame
setwd("/Users/marsh/Downloads/")
householddata <- read.csv("household_power_consumption.txt", header = TRUE,
                          sep = ';', stringsAsFactors = FALSE)
mydata <- householddata[(householddata$Date == '1/2/2007' | householddata$Date
                        == '2/2/2007'),]
mydata$Date <- as.Date(mydata$Date, format = '%d/%m/%Y')
mydata$Global_active_power <- as.numeric(mydata$Global_active_power)

#Create Plot
par(cex = 0.75)
hist(mydata$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", yaxt = 'n')
axis(2, at = seq(0,1200,200))

#Send graphic to file
setwd("/Users/marsh/datasciencecoursera/exploratory_data_analysis/")
dev.copy(png, file = "plot1.png")
dev.off()
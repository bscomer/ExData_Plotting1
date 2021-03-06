#File Download and unzipping/extracting to working directory
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./temp_household_power_consumption.zip")
unzip("./temp_household_power_consumption.zip", overwrite=TRUE)

#Read File into R 
data<-read.table(file="./household_power_consumption.txt", header=TRUE, sep=";", 
        na.strings="?")

#Change date column class to Date
data$Date<-as.Date(data$Date, format="%d/%m/%Y")

#Subset by date and transform date
subset_data<-subset(data, Date=="2007-02-01"|Date=="2007-02-02")
subset_data <- transform(subset_data, date_time=as.POSIXct(paste(Date, Time)), 
        "%d/%m/%Y %H:%M:%S")
#Open PNG graphics device
png(filename="./plot1.png", width=480, height=480)

#Create plot
hist(subset_data$Global_active_power, xlab="Global Active Power (kilowatts)", 
        ylab="Frequency", col="red", main=paste("Global Active Power"))

dev.off()

#Creates plot1.png in working directory
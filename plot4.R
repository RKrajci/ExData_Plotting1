#load sqldf package
library(sqldf)

#import subsetted data from text file, close connection
text<-"household_power_consumption.txt"
file<-file(text)
data<-sqldf("select * from file where Date in ('1/2/2007','2/2/2007')", file.format=list(header=TRUE, sep=";", na.strings="?"))
close(file)

#create formatted datetime column
data$datetime<-as.POSIXct(paste(as.Date(data$Date,"%d/%m/%Y"),format(strptime(data$Time,"%H:%M:%S"),"%H:%M:%S")),format="%Y-%m-%d %H:%M:%S")

#create plot and send to PNG file
par(mfrow=c(2,2))
png(filename="plot4.png",width=480,height=480)
plot(data$datetime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(data$datetime,data$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(data$datetime,data$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(data$datetime,data$Sub_metering_1,col="black")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),bty="n")
plot(data$datetime,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
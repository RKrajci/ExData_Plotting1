library(sqldf)
text<-"household_power_consumption.txt"
file<-file(text)
data<-sqldf("select * from file where Date in ('1/2/2007','2/2/2007')", file.format=list(header=TRUE, sep=";", na.strings="?"))
close(file)
data$datetime<-as.POSIXct(paste(as.Date(data$Date,"%d/%m/%Y"),format(strptime(data$Time,"%H:%M:%S"),"%H:%M:%S")),format="%Y-%m-%d %H:%M:%S")
png(filename="plot1.png", width=480,height=480)
hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
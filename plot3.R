#Read data into df datframe (download if needed)
if (!file.exists("household_power_consumption.txt")) {
    temp<-tempfile()
    path<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(path,temp)
    unzip(temp)
    unlink(temp)
}

power_consumption<- read.table("household_power_consumption.txt",
                               sep=";", header=T, stringsAsFactors=F, na.strings="?")

df <- power_consumption[ which(power_consumption$Date == '1/2/2007' | 
                                   power_consumption$Date == '2/2/2007'),]
#create Device
png(filename="plot3.png",
    width = 480, height=480, units="px")
#Plot
plot(strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"),
     df$Sub_metering_1,
     type="l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black"
)
lines(strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"),df$Sub_metering_2, col="red")
lines(strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"),df$Sub_metering_3, col="blue")
axis(side=2, at=0:3*10)
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,
       col = c("black","red","blue")
       )
#Close Device
dev.off()
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
png(filename="plot2.png",
    width = 480, height=480, units="px")
#Plot
plot(strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"),
     df$Global_active_power,
     type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
     )

axis(side=2, at=0:3*200)
#Close Device
dev.off()
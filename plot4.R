#Reading data

#reading table
data<-read.table(file="household_power_consumption.txt",sep=";"
                 ,header=TRUE,na.strings="?",skip=66636,nrow=69517-66637)
#making colnames
colnames(data)<-c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1",
                  "Sub_metering_2","Sub_metering_3")

#changing the classes into "Date","Time"
data$Time<-as.character(data$Time)
data$Date<-as.character(data$Date)
#convert "16:39:00" to "2007-02-01 16:39:00"
#substring(data$Date,5,8): convert "1/2/2007" to "2007"
data$Time<-strptime(paste(paste(substring(data$Date,5,8),
                                substring(data$Date,3,3),
                                substring(data$Date,1,1),sep=""),
                          data$Time),"%Y%b%e %H:%M:%S")
#convert "1/2/2007" to "2007-02-01"
data$Date<-strptime(paste(substring(data$Date,5,8),substring(data$Date,3,3),
                          substring(data$Date,1,1),sep="")
                    ,format="%Y%b%e",tz="")

#using PNG device
png("plot4.png",width=480,height=480)

#to know weekdays
weekdays<-as.factor(weekdays(data$Date))
(levels<-levels(weekdays))
num<-nrow(subset(data,data$Date!=data$Date[1]))


#plot4
split.screen(figs =c(2,2))

#plot4-1
screen(1)
plot(data$Global_active_power,type="l",xaxt="n",
     xlab="",ylab="Global Active Power")
axis(side=1,at=c(0,num,nrow(data)),labels=c("Thu","Fri","Sat"))
#plot4-2
screen(2)
plot(data$Voltage,type="l",xaxt="n",
     xlab="datetime",ylab="Voltage")
axis(side=1,at=c(0,num,nrow(data)),labels=c("Thu","Fri","Sat"))
#plot4-3
screen(3)
plot(data$Sub_metering_1,type="l",xaxt="n",ylim=c(0,40),
        xlab="",ylab="Energy sub metering")
axis(side=1,at=c(0,num,nrow(data)),labels=c("Thu","Fri","Sat"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1),box.lty=0,cex=0.6)
par(new=T)
plot(data$Sub_metering_2,type="l",xaxt="n",
     ylim=c(0,40),col="red",xlab="",ylab="")
par(new=T)
plot(data$Sub_metering_3,type="l",xaxt="n",
     ylim=c(0,40),col="blue",xlab="",ylab="")
#plot4-4
screen(4)
plot(data$Global_reactive_power,type="l",xaxt="n",
	xlab="datetime",ylab="Global_reactive_power")
axis(side=1,at=c(0,num,nrow(data)),labels=c("Thu","Fri","Sat"))

#close PNG device
dev.off()

close.screen(all=T)


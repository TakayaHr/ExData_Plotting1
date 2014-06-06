#Reading data


#reading table
data<-read.table(file="household_power_consumption.txt",sep=";"
                 ,header=TRUE,na.strings="?",skip=66636,nrow=69517-66637)
#making colnames
colnames(data)<-c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1",
                  "Sub_metering_2", "Sub_metering_3")

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
png("plot2.png",width=480,height=480)


#making plot2
#plotting
plot(data$Global_active_power,type="l",xaxt="n",
     xlab="",ylab="Global Active Power (kilowatts)")
#to know weekdays
weekdays<-as.factor(weekdays(data$Date))
(levels<-levels(weekdays))
#making x axis
num<-nrow(subset(data,data$Date!=data$Date[1]))
axis(side=1,at=c(0,num,nrow(data)),labels=c("Thu","Fri","Sat"))

#close PNG device
dev.off()


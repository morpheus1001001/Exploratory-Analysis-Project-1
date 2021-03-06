#Download the file from source
fileurl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
file.info(fileurl)$size
download.file(fileurl,"Household power consumption",method = "curl")
list.files()
unzip("Household power consumption")

#Reading the data into R
mydata<-read.table( "household_power_consumption.txt",header = TRUE,sep = ";", na.strings="?",colClasses = as.numeric())
head(mydata)
str(mydata)

library(dplyr)
library(lubridate)

#Create a new variable that contains Date and Time together
m<-mutate(mydata,"DateTime"=dmy_hms(paste(Date,Time)))
m<-m[,3:10]
str(m)
head(m)

#Subset the required inerval
studydata<-subset(m,(DateTime >= ymd("2007-02-01")) & (DateTime < ymd("2007-02-03")) )
str(studydata)
head(studydata)

#Plot3
png("plot3.png", width=480, height=480)
with(studydata,{plot(DateTime,Sub_metering_1,type="l",xlab="",ylab = "Energy sub metering")
        lines(DateTime,Sub_metering_2,type="l",col="red")
        lines(DateTime,Sub_metering_3,type="l",col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
})
dev.off()

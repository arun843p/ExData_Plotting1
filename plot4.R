plot4 <- function() {
        ##Get Required data for charting
        df <- read_req_data()
        
        ##Convert Required Chart elements to Numeric class
        df$Global_active_power <- as.numeric(df$Global_active_power)
        df$Voltage <- as.numeric(df$Voltage)
        df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
        df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
        df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
        df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
        
        ##Open & Create Blank png file
        png(file= "plot4.png")
        
        ##Setting Plotting area for 4 plots
        par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(2,0,0,1))
        
        ##1st Plot
        with(df, plot(y= Global_active_power,x=Time, type = "l", ylab = "Gloabl Active Power",xlab=""))
        
        ##2nd Plot
        with(a1, plot(y= Voltage,x=Time, type = "l", ylab = "Voltage",xlab="datetime"))
        
        ##3rd Plot
        with(df, plot(y= Sub_metering_1,x=Time, type = "n", ylab = "",xlab=""))
        with(df, lines(y= Sub_metering_1,x=Time, lty=1,lwd=1, ylab = "",xlab=""))
        with(df, lines(y= Sub_metering_2,x=Time, lty=1, lwd=1, ylab = "",xlab="",col = "red"))
        with(df, lines(y= Sub_metering_3,x=Time, lty=1, lwd=1, ylab = "",xlab="",col = "blue"))   
        ##Legends
        legend("topright",bty="n", pch=c(NA,NA,NA), col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, cex=0.8)
        ##Label
        title(ylab="Energy Sub Metering")
        
        ##4th Plot
        with(df, plot(y= Global_reactive_power,x=Time, type = "l", xlab = "datetime"))
        
        ##Close PNG file
        dev.off()
}

read_req_data <- function(){
        ##Reading Main Data
        df_main <- read.csv2("C:/Users/arpurohit/Desktop/R/Working Directory/Data/exdata-data-household_power_consumption/household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE)
        
        ##Formatting Date
        df_main$Date <- as.Date(df_main$Date, format = "%d/%m/%Y")
        
        ##Subset 1 for date 2007-02-01
        df1 <- subset(df_main, Date == "2007-02-01")
        df2 <- subset(df_main, Date == "2007-02-02")
        df_req <- rbind(df1, df2)
        df_req$Time <- strptime(paste(df_req$Date,df_req$Time),"%Y-%m-%d %H:%M:%S")
        df_req$Weekday <- weekdays(df_req$Date, abbreviate=TRUE)
        df_req
        
}
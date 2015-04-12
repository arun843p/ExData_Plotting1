plot2 <- function() {
   ##Get Required data for charting
   df <- read_req_data()
   
   ##Convert Required Chart elements to Numeric class
   df$Global_active_power <- as.numeric(df$Global_active_power)
   
   ##Send Chart on RStudio Graphic Device
   with(df, plot(y= Global_active_power,x=Time, pch=".", lwd=1, ylab="Global Active Power (kilowatts)",xlab=""))
   with(df, lines(y= Global_active_power,x=Time))
   
   ##Copy Chart to PNG file
   dev.copy(png,"plot2.png")   
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
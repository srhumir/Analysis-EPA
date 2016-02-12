##Download and unzip the data
###create the "data" directory
if (!dir.exists("./data")){
       dir.create("./data")     
} 
###Download zip file
if (!file.exists("./data/EPA.zip")){
       url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
       download.file(url, destfile = "./data/EPA.zip")
}
###unzip the file
if (!file.exists("./data/Source_Classification_Code.rds") | !file.exists("./data/summarySCC_PM25.rds")){
       unzip("./data/EPA.zip", exdir = "./data")
}
##load data into memory
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


##How have emissions from motor vehicle sources changed from 1999-2008
##in Baltimore City?
###subset to Baltimore
NEIBal <- subset(NEI, fips == "24510")
###find cehicle relared SCC's
index <- grep(".*[Vv]ehicle.*", SCC$Short.Name)
VehicleSCC <- as.character(SCC$SCC[index])
NEIBalVehicle <- subset(NEIBal, SCC %in% VehicleSCC)

##start plotting
png("./assignment2/plot5.png", type = "cairo")
plot(unique(NEIBalVehicle$year),tapply(NEIBalVehicle$Emissions, NEIBalVehicle$year, sum),
     type = "l", lwd = 3, col = "blue",
     main = "", xlab = "", ylab = "")
title(main = "Total PM.25 emission related to Vehicle in Baltimore",
      xlab = "Year", ylab = "PM2.5 emission (ton)")
dev.off()

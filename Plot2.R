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


##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
##(fips == "24510") from 1999 to 2008? 
###subset Baltimore data
NEIBaltimore <- subset(NEI, fips == "24510")
##start plotting
png("./assignment2/plot2.png", type = "cairo")
barplot(tapply(NEIBaltimore$Emissions, NEIBaltimore$year, sum),
     main = "", xlab = "", ylab = "")
title(main = "Total PM.25 emission in Baltimore City",
      xlab = "Year",
      ylab = "PM2.5 emission (ton)")
dev.off()

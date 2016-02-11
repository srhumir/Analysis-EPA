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


##Across the United States, how have emissions from coal combustion-related
##sources changed from 1999-2008?

##Get SSC's related to coal combustion
index <- grep(".*Comb.*Coal.*", SCC$Short.Name)
CoalSCC <- as.character(SCC$SCC)[index]
NEICoal <- subset(NEI, SCC %in% CoalSCC)

##start plotting
png("./assignment2/plot4.png", type = "cairo")

plot(unique(NEICoal$year),tapply(NEICoal$Emissions, NEICoal$year, sum),
     type = "l", lwd = 3, col = "blue",
     main = "", xlab = "", ylab = "")
title(main = "Total PM.25 emission related to coal combustion",
      xlab = "Year", ylab = "PM2.5 emission (ton)")
dev.off()

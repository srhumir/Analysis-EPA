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


##Compare emissions from motor vehicle sources in Baltimore City with emissions
##from motor vehicle sources in Los Angeles County, California (fips == "06037").
##Which city has seen greater changes over time in motor vehicle emissions?

###subset to Baltimore
NEIBalLos <- subset(NEI, fips == "24510" | fips == "06037")
###find cehicle relared SCC's
index <- grep(".*[Vv]ehicle.*", SCC$Short.Name)
VehicleSCC <- as.character(SCC$SCC)[index]
NEIBalLosVehicle <- subset(NEIBalLos, SCC %in% VehicleSCC)
NEIBalLosVehicle$city <- factor(NEIBalLosVehicle$fips, labels = c("Los Angeles", "Baltimre"))

##start plotting
library(ggplot2)
png("./assignment2/plot6.png", type = "cairo")
p <- ggplot(NEIBalLosVehicle)
p2 <- p + geom_bar(mapping = aes(x= as.factor(year), weight = Emissions))+
  xlab("Year")+ ylab("Total PM2.5 Emission (ton) ")
p2 + facet_grid(.~city )
dev.off()

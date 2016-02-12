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


##Of the four types of sources indicated by the type 
##(point, nonpoint, onroad, nonroad) variable, which of these four sources 
##have seen decreases in emissions from 1999–2008 for Baltimore City?
##Which have seen increases in emissions from 1999–2008? 
##Use the ggplot2 plotting system to make a plot answer this question.
NEIBaltimore <- subset(NEI, fips == "24510")
###Creste factor by combinig type and year
f <- as.factor(paste(NEIBaltimore$type, NEIBaltimore$year, sep = ","))
###compute the total emmisikon by type and year
a <- rowsum(NEIBaltimore$Emissions, f)
###extract type and year to make new data.frame
b <- (strsplit(as.character(rownames(a)), ","))
type <- sapply(b, function(x) as.character(x[1]))
year <- sapply(b, function(x) as.integer(x[2]))
###new data.fram consisitinf of total emission by type and year
BaltimoreTY <- data.frame( Total_Emission = tapply(NEIBaltimore$Emissions, f, sum),
                           type = type, year = year)
###make plot
png("./assignment2/plot3.png", type = "cairo")
qplot(year, Total_Emission , data = BaltimoreTY, geom = "line", color  = type )
dev.off()

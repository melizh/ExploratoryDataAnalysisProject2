# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

rm(list=ls())

scc <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
pm25data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

# use tapply to find total pollution numbers for balitmore city
baltcity <- subset(pm25data,pm25data$fips=="24510")
years <- unique(baltcity$year)
totyearpol <- tapply(baltcity$Emissions,baltcity$year,sum)

# make a plot
png(filename='plot2.png')
plot(years,totyearpol,type='l',
     xlab="Year",
     ylab="Total PM2.5 Emissions in Baltimore City")
points(years,totyearpol)
dev.off()
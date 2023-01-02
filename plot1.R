# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
rm(list=ls())

scc <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
pm25data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

# use tapply to find total pollution numbers
years <- unique(pm25data$year)
totyearpol <- tapply(pm25data$Emissions,pm25data$year,sum)

# make a plot
png(filename='plot1.png')
plot(years,totyearpol,type='l',
     xlab="Year",
     ylab="Total PM2.5 Emissions")
points(years,totyearpol)
dev.off()
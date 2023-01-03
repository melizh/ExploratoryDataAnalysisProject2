# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?

rm(list=ls())

scc <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
pm25data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

# find rows of scc that contain coal-related information
vehRows <- grep("vehicle",scc$SCC.Level.Two,ignore.case=TRUE)
vehSensors <- scc$SCC[vehRows]

baltcity <- subset(pm25data,pm25data$fips=="24510")

pm25veh <- baltcity[baltcity$SCC %in% vehSensors,]
years <- unique(pm25veh$year)
totyearpol <- tapply(pm25veh$Emissions,pm25veh$year,sum)

# make a plot
png(filename='plot5.png')
plot(years,totyearpol,type='l',
     xlab="Year",
     ylab="Total PM2.5 Emissions from Vehicles in Baltimore City")
points(years,totyearpol)
dev.off()

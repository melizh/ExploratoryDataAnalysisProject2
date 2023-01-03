# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

rm(list=ls())

scc <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
pm25data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

# find rows of scc that contain coal-related information
coalRows <- grep("coal",scc$SCC.Level.Three,ignore.case=TRUE)
coalSensors <- scc$SCC[coalRows]
pm25coal <- pm25data[pm25data$SCC %in% coalSensors,]
years <- unique(pm25coal$year)
totyearpol <- tapply(pm25coal$Emissions,pm25coal$year,sum)

# make a plot
png(filename='plot4.png')
plot(years,totyearpol,type='l',
     xlab="Year",
     ylab="Total PM2.5 Emissions from Coal")
points(years,totyearpol)
dev.off()

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California 
# (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

rm(list=ls())
library(ggplot2)
library(dplyr)

scc <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
pm25data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

# find rows of scc that contain vehicle-related information
vehRows <- grep("vehicle",scc$SCC.Level.Two,ignore.case=TRUE)
vehSensors <- scc$SCC[vehRows]

# use dplyr to find total pollution numbers for 2 cities by type and year
citypm <- subset(pm25data,pm25data$fips=="24510" | pm25data$fips=="06037")
cityveh <- as.data.frame(citypm %>% group_by(fips,year) %>% summarise(bcsums=sum(Emissions), .groups='drop'))
years <- unique(cityveh$year)
types <- unique(cityveh$type)

# make a plot using ggplot2
png(filename='plot6.png')
g <- ggplot(cityveh, aes(x=year,y=bcsums,color=fips)) + 
  geom_point(size=3) + 
  labs(x='Year',y='Total PM2.5 Emissions from Vehicles',color="County Code")
print(g)
dev.off()
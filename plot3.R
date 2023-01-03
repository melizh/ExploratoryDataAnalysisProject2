# Of the four types of sources indicated by the \color{red}{\verb|type|}type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources have 
# seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen
# increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

rm(list=ls())
library(ggplot2)
library(dplyr)

scc <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
pm25data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

# use dplyr to find total pollution numbers for balitmore city by type and year
baltcity <- subset(pm25data,pm25data$fips=="24510")
years <- unique(baltcity$year)
types <- unique(baltcity$type)
totyearpol <- tapply(baltcity$Emissions,baltcity$year,sum)

bc <- as.data.frame(baltcity %>% group_by(type,year) %>% summarise(bcsums=sum(Emissions), .groups='drop'))

#make a plot using ggplot2
png(filename='plot3.png')
g <- ggplot(bc, aes(x=year,y=bcsums,color=type)) + 
  geom_point(size=3) + 
  labs(x='Year',y='Total PM2.5 Emissions',color="Type")
print(g)
dev.off()

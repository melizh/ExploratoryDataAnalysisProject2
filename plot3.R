# Of the four types of sources indicated by the \color{red}{\verb|type|}type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources have 
# seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen
# increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

rm(list=ls())
library(ggplot2)

scc <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
pm25data <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

# use tapply to find total pollution numbers for balitmore city
baltcity <- subset(pm25data,pm25data$fips=="24510")
years <- unique(baltcity$year)
types <- unique(baltcity$type)

df <- data.frame(matrix(ncol=length(types)+1,nrow=length(years)))
colnames(df) <- c("year",types)
df[,"year"] <- years
for (polsrc in types) {
  typesubset <- subset(baltcity,baltcity$type == polsrc)
  df[,polsrc] <- tapply(typesubset$Emissions,typesubset$year,sum)
}

# make a plot using ggplot2
#png(filename='plot3.png')
g = ggplot(df, aes(year,POINT))
g + geom_line(color=1) + 
  geom_line(aes(year,NONPOINT),color=2) + 
  geom_line(aes(year,`ON-ROAD`),color=3) + 
  geom_line(aes(year,`NON-ROAD`),color=4) + 
  labs(x='Year', y = 'Total PM2.5 Pollution', color="Legend")
#dev.off()

## EDAP Proj2 Plot1.R

## This first line will likely take a few seconds. Be patient!

if(!exists("NEI")){
  NEI <- readRDS("~/R/data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("~/R/data/Source_Classification_Code.rds")
}
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

aggEmmByYear <- aggregate(Emissions ~ year, NEI, sum)



barplot(height=aggEmmByYear$Emissions, 
        names.arg=aggEmmByYear$year, 
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))

## Saving to file
dev.copy(png, file="plot1a.png", height=480, width=480)

dev.off()

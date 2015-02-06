## EDAP Project 2 Plot2

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("~/R/data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("~/R/data/Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

subsetNEI  <- NEI[NEI$fips=="24510", ]

aggEmmByYear <- aggregate(Emissions ~ year, subsetNEI, sum)


barplot(height=aggEmmByYear$Emissions, names.arg=aggEmmByYear$year, 
        xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in Baltimore City, MD'))

## Saving to file
dev.copy(png, file="plot2a.png", height=480, width=480)

dev.off()

## EDAP Project 2 Plot 6
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("~/R/data/summarySCC_PM25.rds")
}

# 24510 is Baltimore MD, see plot2.R, 06037 is Los Angeles CA
# Searching for ON-ROAD type in NEI
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") 
                 & (NEI$type=="ON-ROAD" | NEI$type=="OFF-ROAD"),  ]


if(!exists("SCC")){
  SCC <- readRDS("~/R/data/Source_Classification_Code.rds")
}

# should subset here

RoadMatches  <- grepl("Mobile", SCC$SCC.Level.One, ignore.case=TRUE)
subsetSCC <- SCC[RoadMatches, 
                 ]


# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(subsetNEI, subsetSCC, by="SCC")
}

library(ggplot2)

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


aggEmmByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggEmmByYearAndFips$fips[aggEmmByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggEmmByYearAndFips$fips[aggEmmByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

g <- ggplot(aggEmmByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Motor vehicle emissions in Baltimore City, MD vs Los Angeles, CA')
print(g)

png("plot6a.png", width=840, height=480)

dev.off()

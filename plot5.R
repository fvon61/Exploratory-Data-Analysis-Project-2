##EDAP Project 2 Plot 5

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("~/R/data/summarySCC_PM25.rds")
}

# 24510 is Baltimore fips, see plot2.R
# Searching for ON-ROAD and OFF-ROAD type in NEI
subsetNEI <- NEI[NEI$fips=="24510" & (NEI$type=="ON-ROAD" | NEI$type=="OFF-ROAD"),  ]

rm(NEI)

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
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


aggEmmByYear <- aggregate(Emissions ~ year, subsetNEI, sum)


library(ggplot2)

g <- ggplot(aggEmmByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Motor vehicle emmisions in Baltimore City, MD')
print(g)

png("plot5a.png", width=840, height=480)
dev.off()

##EDAP Project 2 Plot 4

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("~/R/data/summarySCC_PM25.rds")
}

#subsetNEI <- NEI[coalMatches, ]


if(!exists("SCC")){
  SCC <- readRDS("~/R/data/Source_Classification_Code.rds")
}

# fetch all SCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, 
                 ]
# merge the two data sets 

if(!exists("NEIsubsetSCC")){
  NEIsubsetSCC <- merge(NEI, subsetSCC, by="SCC")
}

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

aggEmmByYear <- aggregate(Emissions ~ year, NEIsubsetSCC, sum)

g <- ggplot(aggEmmByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources')

print(g)

png("plot4a.png", width=640, height=480)
dev.off()

# Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

setwd("/Users/dehshini/code/R/exploratory_project")
library(tidyverse)
library(magrittr)

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# subset baltimore city
baltimore <- NEI %>%
    filter(fips == "24510")

# subset motor vehicle sources
motor <- SCC %>%
    filter(grepl("vehicle", SCC.Level.Two, ignore.case = TRUE)) %>%
    select(SCC)

# merge
baltimore_motor <- merge(baltimore, motor, by = "SCC")

#subset for los angeles county
la <- NEI %>%
    filter(fips == "06037")
    
# merge
la_motor <- merge(la, motor, by = "SCC")

# plot
g <- ggplot() +
    geom_bar(data = baltimore_motor, aes(x = year, y = Emissions, fill = "Baltimore"), stat = "identity") +
    geom_bar(data = la_motor, aes(x = year, y = Emissions, fill = "LA"), stat = "identity") +
    facet_grid(.~fips)

g + ggtitle("Comparing PM2.5 Emissions from Motor Vehicle Sources in Baltimore and LA") +
    xlab("Year") +
    ylab("Total PM2.5 Emissions") +
    theme_minimal()

#save
dev.print(png, file = "plot6.png", width = 550)

setwd("/Users/dehshini/code/R/exploratory_project")
library(tidyverse)
library(magrittr)

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# 1. Have total emissions from PM2.5 decreased in the United States
#from 1999 to 2008? Using the base plotting system, make a plot
#showing the total PM2.5 emission from all sources for each of
#the years 1999, 2002, 2005, and 2008.

#summarize emissions by year
total_emissions <- NEI %>%
    group_by(year) %>%
    summarise(
        total = sum(Emissions, na.rm=TRUE)
    )

#make a barplot
barplot(
    height = total_emissions$total,
    names.arg = total_emissions$year,
    xlab = "year",
    ylab = "Total PM2.5 Emissions",
    main = "Total PM2.5 Emissions per year"
)

#save the plot
dev.print(png, file = "plot1.png", width = 480, height = 480)

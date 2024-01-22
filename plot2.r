#2. Have total emissions from PM2.5 decreased in the Baltimore
# City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

setwd("/Users/dehshini/code/R/exploratory_project")
library(tidyverse)
library(magrittr)

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#subset for baltimore
baltimore <- NEI %>%
    filter(fips == "24510")

# aggregate
baltimore_emissions <- baltimore %>%
    group_by(year) %>%
    summarise(
        total = sum(Emissions), na.rm = TRUE
    )

#plot
barplot(
    height = baltimore_emissions$total,
    names.arg = baltimore_emissions$year,
    xlab = "year",
    ylab = "Total PM2.5 Emissions",
    main = "Baltimore PM2.5 Emissions per year"
)

#save plot
dev.print(png, file = "plot2.png", width = 480, height = 480)
# Of the four types of sources indicated 
# by the type (point, nonpoint, onroad, nonroad) variable,
#  which of these four sources have seen decreases in emissions 
#  from 1999–2008 for Baltimore City? 
#  Which have seen increases in emissions from 1999–2008? 
#  Use the ggplot2 plotting system to make a plot answer this question.

setwd("/Users/dehshini/code/R/exploratory_project")
library(tidyverse)
library(magrittr)

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#subset baltimore city
baltimore <- NEI %>%
    filter(fips == "24510")

#group by year and source type
baltimore_sources <- baltimore %>% 
    group_by(year, type) %>% 
    summarise(Emissions = sum(Emissions))

#plot
g <- ggplot(baltimore_sources, aes(year, Emissions, color = type)) +
    geom_point() +
    geom_line() +
    ggtitle("Emissions from 1999-2008 in Baltimore City") +
    xlab("Year") +
    ylab("Emissions (tons)") +
    theme_minimal()

g

#save
dev.print(png, file = "plot3.png", width = 555, height = 455)
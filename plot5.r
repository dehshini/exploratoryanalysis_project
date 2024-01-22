#How have emissions from motor vehicle sources
#changed from 1999–2008 in Baltimore City?

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

# plot
baltimore_motor_summary <- baltimore_motor %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions)) 

#plot

g <- ggplot(baltimore_motor_summary, aes(x = year, y = Emissions)) +
    geom_point() +
    geom_line() +
    ggtitle("Emissions from motor vehicle sources from 1999-2008 in Baltimore City") +
    xlab("Year") +
    ylab("Emissions")+
    theme_minimal()

g

#save

dev.print(png, file = "plot5.png", width = 480)


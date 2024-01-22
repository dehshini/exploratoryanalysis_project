# Across the United States, how have emissions from coal
#  combustion-related sources changed from 1999–2008?

setwd("/Users/dehshini/code/R/exploratory_project")
library(tidyverse)
library(magrittr)

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Filter data
coal <- SCC %>%
    filter(
        grepl(
            "coal",
            Short.Name,
            ignore.case = TRUE
        )
    ) %>% 
    select(SCC)

NEI_coal <- NEI %>%
    filter(SCC %in% coal$SCC)


# Plot
g <- ggplot(NEI_coal, aes(factor(year), Emissions, fill = type)) +
    geom_bar(stat = "identity") +
    ggtitle("Emissions from coal sources 1999-2008") +
    xlab("year") +
    ylab("Emissions") +
    theme_minimal()

g

# Save plot
dev.print(png, file = "plot4.png", width = 480, height = 480)

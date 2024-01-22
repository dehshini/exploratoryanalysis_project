# Across the United States, how have emissions from coal
#  combustion-related sources changed from 1999–2008?

setwd("/Users/dehshini/code/R/exploratory_project")
library(tidyverse)
library(magrittr)

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

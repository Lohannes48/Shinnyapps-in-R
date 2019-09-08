
# Library Input ------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)

# Prepare Data ------------------------------------------------------------

cars <- read_csv("data/autos.csv")

cars <- cars %>% 
  drop_na(gearbox)

theme_algoritma <- readRDS("data/theme_algoritma.rds")

# Prepare Input -----------------------------------------------------------

selectGear <- unique(cars$gearbox)
selectFuel <- unique(cars$fuelType)


# Library Input ------------------------------------------------------------

library(dplyr)
library(tidyverse)
library(plotly)
library(Scale)
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(shinydashboard)
library(leaflet)
library(shiny)

# Prepare Data ------------------------------------------------------------

cars <- read_csv("data/autos.csv")

cars <- cars %>% 
  drop_na(gearbox)

theme_algoritma <- readRDS("data/theme_algoritma.rds")

best5_place <- read.csv("data/Best10.csv")

cheap8_place <- read.csv("data/Poor10.csv")

best5_place <- best5_place %>% 
  mutate(category = "Expensive")

cheap8_place <- cheap8_place %>% 
  mutate(category = "Cheap")

dat <- rbind(best5_place, cheap8_place)

# Prepare Input -----------------------------------------------------------

selectGear <- unique(cars$gearbox)
selectFuel <- unique(cars$fuelType)
selectBrand <- unique(cars$brand)

library(sf)
library(janitor)
library(tidyverse)
library(tmap)
install.packages("countrycode")
library(countrycode)

# read global gender inequality data

ggid <- read_csv("HDR21-22_Composite_indices_complete_time_series.csv")

# select columns

ggid2 <- ggid %>%
  select(iso3, country, gii_2010, gii_2019)

# load spatial data

wc <- read_sf("World_Countries_(Generalized)/World_Countries__Generalized_.shp")

# select columns

ggid3 <- ggid2 %>%
  mutate(gii_diff = gii_2019 - gii_2010)

# convert to ISO2

ggid4 <- ggid3 %>%
  mutate(iso2 = countrycode(`iso3`, "iso3c", "iso2c"))

# join csv to spatial data

ggid_map <- wc %>%
  left_join(.,
            ggid4,
            by = c("ISO" = "iso2"))

# plot

tmap_mode("plot")
qtm(ggid_map, 
    fill = "gii_diff")

















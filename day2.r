# Data Carpentry Day 2
# April 13 2016

# http://neondataskills.org/R/vector-data-reproject-crs-R/
# Setup
setwd("~/Documents/Data_Carpentry/")

library(rgdal)
library(raster)


# Layer 1 - Boundaries of US, baselayer
us_boundary <- readOGR("NEON-DS-Site-Layout-Files/US-Boundary-Layers/",
                       "US-State-Boundaries-Census-2014")

# Info for us_boundary
class(us_boundary)
names(us_boundary)
crs(us_boundary)

# Plot 
plot(us_boundary, 
     main = "Map of US Census Bureau Data")

# New layer - Add boundary to US
country_boundary <- readOGR("NEON-DS-Site-Layout-Files/US-Boundary-Layers/", 
                            "US-Boundary-Dissolved-States")

# Explore country_boundary
class(country_boundary)
names(country_boundary)
crs(country_boundary)

# Plot 2 layers together
# First
plot(us_boundary, 
     main = "Map of US Census Bureau Data", 
     border = "grey18")

# Second
plot(country_boundary,
     lwd = 4,
     border = "grey40",
     add = TRUE)


# Add location of LTER TOWER
point_HARV <- readOGR("NEON-DS-Site-Layout-Files/HARV/", 
                      "HARVtower_UTM18N")

# Explore 
names(point_HARV)
class(point_HARV)

# Store Plot
US_Plot <- recordPlot()

US_Plot
# Plot tower
plot(point_HARV,
     pch = 19, col = "purple",
     add = TRUE)


# Not lining up
# Explore data further to find why not
extent(point_HARV)        
extent(us_boundary)

projInfo(type = "datum")


# Reproject Data####
point_HARV_WGS84 <- spTransform(point_HARV, crs(us_boundary))

# Explore reprojected data
extent(point_HARV_WGS84)
extent(point_HARV)
extent(us_boundary)

# Plot
plot(point_HARV_WGS84,
     pch = 19, col = "purple",
     add = TRUE)


# EXERCISE 1
# file: Boundary-US-State-NEast.shp
ne_us_boundary <- readOGR("NEON-DS-Site-Layout-Files/US-Boundary-Layers/",
                          "Boundary-US-State-NEast")

plot(ne_us_boundary)

# Explore
crs(ne_us_boundary)

# Point 18n
north_pt <- readOGR("NEON-DS-Site-Layout-Files/HARV/", 
                      "HARVtower_UTM18N")

crs(north_pt)

new_north <- spTransform(north_pt, crs(ne_us_boundary))

plot(ne_us_boundary,
     lwd = 4,
     main = "North Eastern United States")

plot(new_north, 
     col = "red",
     pch = 20,
     add=TRUE)

legend("topright", legend="18 NE", pch = 20,
       col = "red", cex = .8)

# EXERCISE

# SOLUTION
# Explore 
crs(ne_us_boundary)

# CRS object
UTM_crs <- crs(point_HARV)
UTM_crs

# Reproject NE State boundaries
ne_us_boundary_UTM <- spTransform(ne_us_boundary, UTM_crs)

plot(ne_us_boundary_UTM, 
     main = "Map of NE US\nLTER tower location UTM zone 18", 
     border = "grey18", 
     lwd = 2)

# Tower location
plot(point_HARV, 
     pch = 19, 
     col = "purple", 
     add = TRUE)

labelsVec <- c("State Boundary", "Fisher Tower")
lineVec <- c(1,NA)
symVec <- c(NA, 19)
colVec <- c("grey18", "purple")

legend("topright", legend = labelsVec, lty = lineVec, pch = symVec, col = colVec)

# END SOLUTION


# Saving a shapefile
writeOGR(point_HARV_WGS84, getwd(), "towerWGS84", driver = "ESRI Shapefile")


###############################################################################
# Work with Raster Data####
##############################################################################

GDALinfo("NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif")

# Access individual info
hm  <- GDALinfo("NEON-DS-Airborne-Remote-Sensing/HARV/DSM/HARV_dsmCrop.tif") 
hm["rows"]


# Get data
DSM_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif")
crs(DSM_HARV)

# Plot
plot(DSM_HARV)


























# Intro to Spatial
# April 12 2016
# http://neondataskills.org/R/plot-shapefiles-in-R/

# Libraries 
library(raster)
library(rgdal)

###############################################################################
# Vector Data
###############################################################################

# Setup
setwd('~/Documents/Data_Carpentry/')
getwd()

# Open shapefile
roads_HARV <- readOGR("NEON-DS-Site-Layout-Files/HARV/", "HARV_roads")

# Plot
plot(roads_HARV)

# lines = where vertices are stored
# b box = spatial extent 
# data = attributes
head(roads_HARV@data,3)

roads_HARV@lines

# first line in r object
roads_HARV@lines[[1]]


###############################################################################
# Raster Data
###############################################################################
# Grid cells 
# GeoTIFF - based on tiff images, tifftags: store metadata in file

# info
GDALinfo('NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif')

# Open geoTIFF
chm_HARV <- raster('NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif')
plot(chm_HARV)


####################################################################################
# Intro to Vector
###################################################################################
aoiBoundary_HARV <- readOGR("NEON-DS-Site-Layout-Files/HARV/", "HarClip_UTMZ18")

# INFORMATION 
class(aoiBoundary_HARV)

# What units -> meters
# USE TO VERIFY FOR NEW LAYERS
crs(aoiBoundary_HARV)

extent(aoiBoundary_HARV)

plot(aoiBoundary_HARV)

# Plot
plot(aoiBoundary_HARV, main="AOI Boundary", border="red", col="wheat")

# EXERCISE
hr <- readOGR("NEON-DS-Site-Layout-Files/HARV/", "HARV_roads")
class(hr)
extent(hr)
plot(hr)
hr
# EXERCISE


# Layer 
plot(hr, add=TRUE)
plot(aoiBoundary_HARV, add=TRUE)
plot(point_HARV, add  = TRUE, pch = 19, col = "purple")


point_HARV <- readOGR("NEON-DS-Site-Layout-Files/HARV", layer="HARVtower_UTM18N")

# EXERCISE 2
# file: NEON_RemoteSensing/HARV/CHM/HARV_chmCrop.tif

chmCrop <- raster('NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif')
plot(chmCrop, add=TRUE)
plot(hr, add=TRUE)
plot(aoiBoundary_HARV, add=TRUE)
plot(point_HARV, add=TRUE)


# Explore point 
extent(point_HARV)
names(point_HARV)
head(point_HARV)

# site name    ObjectName$attribute
point_HARV$SiteName

# view roads
roads_HARV$TYPE

roads_HARV[roads_HARV$TYPE=="footpath",]

# Footpaths
footpath_HARV <- roads_HARV[roads_HARV$TYPE=="footpath",]

plot(footpath_HARV)

# Plot with new colors for each footpath
plot(footpath_HARV, col=c('rosybrown1','springgreen1'), lwd = 6, main="HARV Footpaths\nNEXT LINE")


# Boardwalk
boardwalk_HARV <- roads_HARV[roads_HARV$TYPE=="boardwalk",]
plot(boardwalk_HARV,col=c('springgreen1'), lwd = 6, main="HARV Boardwalk\nNEXT LINE")
boardwalk_HARV


# Types of road summary - how many?
summary(roads_HARV$TYPE)

# Levels
levels(roads_HARV$TYPE)
length(levels(roads_HARV$TYPE))

# Colors assigned
colors = c("springgreen1","rosybrown1","Purple","brown")
roadColors <- c("springgreen1","rosybrown1","Purple","brown")[roads_HARV$TYPE]

plot(roads_HARV, col=roadColors, lwd=9, main="ROADS")

# Add figure
legend("topleft", legend = levels(roads_HARV$TYPE),fill=colors, cex = 2, bty = n)


# NEON-DS-Site-Layout-Files/US-Boundary-Layers\US-State-Boundaries-Census-2014
US_State <- readOGR("NEON-DS-Site-Layout-Files/US-Boundary-Layers/", "US-State-Boundaries-Census-2014") 
state_colors <- c("cadetblue4","aliceblue","cadetblue","cadetblue1","cadetblue2")
regions <- c("cadetblue4","aliceblue","cadetblue","cadetblue1","cadetblue2")[US_State$region]

# test
plot(US_State)

# info
summary(US_State$region)
names(US_State)
head(US_State)

# plot and legend 
plot(US_State, col=regions,main="Regions of \nUnited States")
legend("bottomleft",bty="n", legend = levels(US_State$region), fill=regions)


# Multiple spatial data types

# BASE plot
plot(aoiBoundary_HARV, col="lightyellow", border="grey", main="NEON Harvard Forest")

# Add rows
plot(roads_HARV, col=roadColors, add = TRUE)

# Add point
plot(point_HARV, pch = 20, col="red", add=TRUE)

# Legend 
# labels
labels <- c("Tower", "AOI", levels(roads_HARV$TYPE))
legend("bottomright", bty="n", fill=plotColors, legend = labels, cex=.9)

# plot colors
plotColors <- c("red","lightyellow", roadColors, cex=1)
plotColors


plot_HARV <- recordPlot()
plot_HARV

# unique symbols
plotSym <- c(19, 15, 15,15,15,15)
plotSym

legend("bottomright", bty="n", col = plotColors, legend = labels, cex=.8, pch = plotSym)

# make the road into lines
lineLegend <- c(NA, NA, 1,1,1,1)

# reset plot symbols
plotSym <- c(19,15,NA,NA,NA,NA)
plotSym

# Plot together
plot_HARV
legend("bottomright", legend=labels, lty = lineLegend, pch = plotSym, bty = "n",
       col = plotColors, cex = .8)


# EXERCISE 3
# file: NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp
Plot_Loc <- readOGR("NEON-DS-Site-Layout-Files/HARV/", "PlotLocations_HARV")

plot(Plot_Loc)

names(Plot_Loc)

Plot_Loc$soilTypeOr


soil_type <- c(Plot_Loc$soilTypeOr)

soil_color <- c("red", "blue")
soil_col <- c("red", "blue")[soil_type]

lvl <- levels(Plot_Loc$soilTypeOr)
symbl <- c(23,23)

plot(Plot_Loc, col=soil_col, pch=23, main="Soil Types")
legend("bottomright", legend = lvl, pch = symbl)




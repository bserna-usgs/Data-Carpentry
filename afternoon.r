# Data Carpentry Day 2 - Afternoon
# April 13 2016

# Polygon
aoiBoundary <- readOGR("NEON-DS-Site-Layout-Files/HARV/", "HarClip_UTMZ18")

# Raster
chm_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif")

# Reviewing extent of layers to verify same
plot(extent(chm_HARV), col = "blue")
plot(extent(aoiBoundary), col = "red", add=T)

# Specify each output
extent(aoiBoundary)@xmin

# Crop raster ####
chm_HARV_crop <- crop(chm_HARV, aoiBoundary)
plot(chm_HARV_crop)

# Verify boundaries
plot(aoiBoundary, add=T, border="red",lwd=6)


# Exercise
sp_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif")
plot(sp_HARV)


# Extract Values ####
tree_height <- extract(chm_HARV, aoiBoundary, df=T)

# Histogram of tree height
hist(tree_height$HARV_chmCrop, col = rainbow(30), xlab = "Tree height / HARV chm", main = "Tree Height")

length(tree_height$HARV_chmCrop)

# Find mean
mean(tree_height$HARV_chmCrop)

# Extract a summary stat using a point and a buffer
plot(point_HARV, pch=22)

# Extract using a buffered point
# Average tree height around a tower
av_ht_tower <- extract(chm_HARV, point_HARV,fun=mean, df=T, buffer=20)
av_ht_tower

#Exercise
# HARV/plot.locations_HARV.shp
plot_HARV_loc <- readOGR("NEON-DS-Site-Layout-Files/HARV/", "PlotLocations_HARV")

plot(plot_HARV_loc)

avg_HARV <- extract(chm_HARV, plot_HARV_loc, fun=mean, df=T, buffer=20)
plot(avg_HARV, col=rainbow(80), pch=20, lwd=9, main = "Harvard points")


avg_HARV_v2 <- extract(chm_HARV, plot_HARV_loc, fun=mean, sp=T, buffer=20)
plot(avg_HARV_v2, col = rainbow(100), cex=.1*avg_HARV_v2@data$HARV_chmCrop, pch=20, main = "Average Tree Height")
summary(avg_HARV)


###############################################################################
# Multi-band rasters in r 
###############################################################################

RGB_band1_HARV <- raster("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

plot(RGB_band1_HARV)

greyscale_colors <- gray.colors(100, start=0.0, end=1.0, gamma = 2.2, alpha = NULL)
greyscale_colors


plot(RGB_band1_HARV,col = greyscale_colors, axes=F, main = "Band ")

# Stack function to open many bands
RGB_stack_HARV <- stack("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")
plot(RGB_stack_HARV, col = greyscale_colors, main="Multi-band Raster")

# Histogram of bands
hist(RGB_stack_HARV)
RGB_stack_HARV

# How to adjust how it plots by adjusting bands 
plotRGB(RGB_stack_HARV, r=3, g=2, b=1)
plotRGB(RGB_stack_HARV)

wna <- stack("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")
plotRGB(wna)

GDALinfo("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")

GDALinfo("NEON-DS-Airborne-Remote-Sensing/HARV/RGB_Imagery/HARV_Ortho_wNA.tif")







## ########################## ##
##
## Author: Brayden Youngberg
##
## This collection of scripts were developed for my MSc dissertation to classify
## aspects of peatland condition using ultra-high resolution remote sensing data.
## 
## This script is used to process RGB and multi-spectral data, along with DEMs, to
## create variables and variable stacks for classification. This utilises a helper
## script defining the calculations for the different indices.
##
## License: GPL-3.0 license
##
## ########################## ##

library(terra)
#calculate normalized reflectance (if calculating from Metashape exported Micasense data)#
Mica.reflectance <- function(data, bands) {data[[bands]]/32768}

#create Indices#
#Micasense multi-spec
NDVI <- function(data, Nir, red) {(data$Nir-data$red)/(data$Nir+data$red)}
GNDVI <- function(data, Nir, green) {(data$Nir - data$green)/(data$Nir + data$green)}
NDRE <- function(data, Nir, Redge) {(data$Nir - data$Redge)/(data$Nir + data$Redge)}
EVI <- function(data, Nir, red, blue) {(2.5*((data$Nir - data$red)/((data$Nir + 6*data$red - 7.5*data$blue +1))))}
MTVI2 <- function(data, Nir, green, red) {(1.5*(1.2*(data$Nir-data$green))-(2.5*(data$red-data$green)))/sqrt(((2*data$Nir+1)^2)-(6*data$Nir-5*sqrt(data$red))-0.5)}
RedgeSimple <- function(data, Nir, Redge) {(data$Nir/data$Redge)}
coreRtvi <- function(data, Nir, Redge, green) {(100*(data$Nir-data$Redge) - 10*(data$Nir - data$green))}
MCARI2 <- function(data, Nir, red, green) {(1.5*(2.5*(data$Nir-data$red) - 1.3*(data$Nir-data$green)))/sqrt(((2*data$Nir+1)^2)-(6*data$Nir-5*sqrt(data$red))-0.5)}

#DJI RGB
GLI <- function(data, green, red, blue) {((2*data$green - data$red - data$blue)/(data$green + data$red + data$blue))}
SoilBrightness <- function(data, red, green) {(sqrt(((data$red*data$red)/ (data$green*data$green))/2))}
avg.Brightness <- function(data, red, green, blue) {((data$red + data$green + data$blue)/3)}
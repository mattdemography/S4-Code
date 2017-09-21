library(dplyr)
library(rgeos)
library(rgdal)
library(spdep)

###checking consistency of 1880 adddress tables
cities <- list.files("S:/Users/_Exchange/1880 Stuff/AllCities")

#remove non-cities
cities <- cities[!(1:42 %in% c(17,41))]
cities[25] <- "NewHaven"
cities[26] <- "NewOrleans"

#files to check
folders <- c("ED","Street Grid With Ranges","Street Grid Without Ranges")
files <- c("_ED","_Street_Ranges","_StreetGrid")

#create empty matrix
results <- matrix("", nrow=40, ncol=3)

#collect CRS strings for all files
for(a in 1:40){
  print(cities[a])
  for(b in 1:3){
    shape <- readOGR(dsn = paste("S:/Projects/Preparing 1880 Files/Ben Results/", cities[a], sep=""),
                     layer = paste(cities[a], files[b], sep=""), stringsAsFactors = F)
    results[a,b] <- proj4string(shape)
  }
}

results <- as.data.frame(results)
names(results) <- c("ED","Ranges","No.Ranges")
write.csv(results, "S:/Projects/Preparing 1880 Files/Ben_result_proj.csv", row.names = F)

##change projection/datums to Albers Equal Area, NAD83
#for(a in 25:40){
#  print(cities[a])
#  for(b in 1:3){
#    shape <- readOGR(dsn = paste("S:/Projects/Preparing 1880 Files/", cities[a], "/", folders[b], sep=""),
#                     layer = paste(cities[a], files[b], sep=""), stringsAsFactors = F) %>%
#      spTransform(sp::CRS("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0"))
#    proj4string(shape) <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0"
#    writeOGR(shape, dsn = paste("S:/Projects/Preparing 1880 Files/", cities[a], "/", folders[b], sep=""),
#            layer = paste(cities[a], files[b], sep=""), driver = "ESRI Shapefile", overwrite_layer = T)
#  }
#}


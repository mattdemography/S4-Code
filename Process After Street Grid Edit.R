library(Hmisc)
library(DataCombine)
library(readstata13)
library(gmodels)
library(foreign)
library(car)
library(plyr)
library(seg)
library(spdep)
library(reshape)
library(reshape2)
library(rJava)
library(xlsx)
library(maptools)+
library(rgdal)
library(haven)

trim <- function( x ) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

#Bring in MicroData
  mdata<-read.csv("Z:/Users/Matt/SanAntonio/Micro Data Files/SanAntonioTX_StudAuto.csv", stringsAsFactors = F)
#Bring in Street Grid
  setwd("Z:/Users/Matt/SanAntonio/GIS/Grids/")
  grid30<-readOGR(dsn=getwd(), layer="San Antonio_1930_stgrid_edit_AddedRanges")
  grid30_data<-grid30@data
#Street Name Change List from Steve Morse
  new<-read.csv("Z:/Users/Matt/SanAntonio/StName_Change.csv")
  new$New<-trim(gsub("[*]", "", new$New, perl=T))

#Make variable names lowercase
  names(grid30_data)<-tolower(names(grid30_data))
  names(grid30_data)
  names(mdata)<-tolower(names(mdata))
  names(mdata)
  
#Keep Unique MicroData Street Names
  m_st<-subset(mdata, !duplicated(mdata$autostud_street))
  m_st1<-m_st$autostud_street
  grid<-subset(grid30_data, !duplicated(grid30$fullname))
  grid1<-as.character(grid$fullname)
  
  m_st$ingrid<-m_st1 %in% grid1
  table(m_st$ingrid)
  m<-m_st[which(m_st$ingrid=="FALSE"),]
  myvars<-c("autostud_street")
  m<-m[myvars]
  
  grid$indata<-grid1 %in% m_st1
  table(grid$indata)
  g<-grid[which(grid$indata=="FALSE"),]
  myvars<-c("fullname")
  g<-g[myvars]
  
#Create Grid That Dissolves Street + Ranges. First create variable to mark unique Street + Ranges then
#Dissolve on this unique variable in ARC. This Grid will be what is used to Geocode.
#Dissolve on 'st_ran_id'
  grid30$st_ran_id<-id(grid30@data[c("fullname", "lfromadd", "ltoadd", "rfromadd", "rtoadd")], drop=T)
  View(grid30@data)
  
  setwd("Z:/Users/Matt/SanAntonio/GIS/Process Files/")
  writeOGR(grid30, dsn=getwd(), "SanAntonio_1930_Temp_GridToGeocode", check_exists = TRUE,
           overwrite_layer = TRUE, driver="ESRI Shapefile")
  
#Once This file has been created import it to Arc and create a dissolve on 'st_ran_id'.
#Then spatially join the "SanAntonio_1930_Temp_GridToGeocode" to the dissolve (Target Features) file that was just created.
#Now we bring in this spatially joined file and keep only lines where 'st_ran_id' = 'st_ran_id_'.
#Then keep only one !duplicated of each st_ran_id.
  setwd("Z:/Users/Matt/SanAntonio/GIS/Process Files/")
  grid30_2<-readOGR(dsn=getwd(), layer="SanAntonio_1930_Temp_GridToGeocode2")
  View(grid30_2@data)
  
  grid30_2$JOIN_FID<-as.character(grid30_2$JOIN_FID)
  grid30_2$st_ran_id<-as.character(grid30_2$st_ran_id)
  
  grid30_2$keep<-ifelse(grid30_2$st_ran_id==grid30_2$st_ran_id_, 1, 0)
  grid30_2<-subset(grid30_2, grid30_2$st_ran_id==grid30_2$st_ran_id_)
  grid30_2<-subset(grid30_2, !duplicated(grid30_2$st_ran_id))
  
  setwd("Z:/Users/Matt/SanAntonio/GIS/Grids/")
  writeOGR(grid30_2, dsn=getwd(), "SanAntonio_1930_GridToGeocode", check_exists = TRUE,
           overwrite_layer = TRUE, driver="ESRI Shapefile")

##### Create Address File for Geocoding ####    
  changes<-read.csv("Z:/Users/Matt/SanAntonio/GIS/Process Files/Streets To Be Changed.csv", stringsAsFactors = F)
  names(changes)<-tolower(names(changes))
  
#Change Only Microdata Streets Without a North/South direction
  changes<-subset(changes, changes$change2=="")
  changes<-subset(changes, changes$change1!="OUTSIDE CITY LIMITS")
  
  mdata<-plyr::rename(mdata, c(block="Mblk"))
  mdata$state<-"TX"
  mdata$city<-"San Antonio"
  
  #Change Microdata Names where they are noted in SteveMorse
  #Order By Fullname
    mdata<-mdata[order(mdata$autostud_street),]
    changes<-changes[order(changes$from),]
  #Make Changes
    vars<-c("serial", "autostud_street", "ed", "type", "Mblk","hn", "city", "state")
    mdata<-mdata[vars]
    mdata$autostud_street<-ifelse(mdata$autostud_street %in% changes$from, changes$change1, mdata$autostud_street)
  
  #Create New Address File
    mdata$address<-paste(mdata$hn, mdata$autostud_street, sep=" ")
    write.csv(mdata, "Z:/Users/Matt/SanAntonio/GIS/Geocoded Points/Add_PostEdit_30.csv")
    hh<-subset(mdata, !duplicated(mdata$serial))
    write.csv(hh, "Z:/Users/Matt/SanAntonio/GIS/Geocoded Points/AddHH_PostEdit_30.csv")
  
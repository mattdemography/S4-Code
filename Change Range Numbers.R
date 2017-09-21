#USE THIS CODE ONLY FOR FIXING MISTAKES ORIGINALLY MADE.
#TO SEE MISTAKES CHECK 'Checking1880_2016_07_08.xlsx
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
library(spatialsegregation)
library(haven)


trim <- function( x ) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

shift<-function(x,shift_by){
  stopifnot(is.numeric(shift_by))
  stopifnot(is.numeric(x))
  
  if (length(shift_by)>1)
    return(sapply(shift_by,shift, x=x))
  
  out<-NULL
  abs_shift_by=abs(shift_by)
  if (shift_by > 0 )
    out<-c(tail(x,-abs_shift_by),rep(0,abs_shift_by))
  else if (shift_by < 0 )
    out<-c(rep(0,abs_shift_by), head(x,-abs_shift_by))
  else
    out<-x
  out
}


##### 1 - Street Grid with Address Ranges - SHAPE FILE ####
ispresent1<-data.frame(City=character())
citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
citylist<-subset(citylist, citylist$Fix1!="x")
LongName<-citylist$LongName
Cityname<-citylist$Cityname
Shortname<-citylist$Shortname
Seg_ID<-citylist$Seg_ID
Ex<-citylist$Ex
SG<-citylist$SG
Seg<-citylist$Seg_Original
hex150<-citylist$hex150
hex225<-citylist$hex225
seg_id1<-citylist$Seg_ID_1
seggrid<-citylist$SegGrID
seggrid_1<-citylist$SegGrID_1
street<-citylist$st
rows<-nrow(citylist)

for(i in 23:23){
}
tryCatch({
  library(shapefiles)
  setwd(paste("Z:/Projects/Preparing 1880 Files/", LongName[i],"/Street Grid With Ranges/",sep=""))
  range<-readOGR(dsn=getwd(), layer=paste(Shortname[i],"_Street_Ranges",sep=""))
  
  range$l_f_range<-as.numeric(levels(range$l_f_range))[range$l_f_range]
  range$l_t_range<-as.numeric(levels(range$l_t_range))[range$l_t_range]
  range$r_f_range<-as.numeric(levels(range$r_f_range))[range$r_f_range]
  range$r_t_range<-as.numeric(levels(range$r_t_range))[range$r_t_range]

  setwd(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Street Grid With Ranges/", sep=""))
  writeOGR(range, dsn=getwd(), paste(Shortname[i],"_Street_Ranges",sep=""), driver="ESRI Shapefile",
           check_exists = TRUE, overwrite_layer = TRUE)
  detach("package:shapefiles", unload=TRUE)
  
  tab2<-as.data.frame(unique(Second$NHGISNAM))
  rename(tab2, c('unique(Second$NHGISNAM)'="City"))
  ispresent2<-rbind(ispresent2,tab2)
}, error=function(e){cat(conditionMessage(e))})
}
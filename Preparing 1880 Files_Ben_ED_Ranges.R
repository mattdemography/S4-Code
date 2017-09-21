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
library(maptools)
library(rgdal)
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
citylist<-read.csv("S:/Projects/Preparing 1880 Files/City Lists.csv")
LongName<-citylist$LongName
Cityname<-citylist$Cityname
Cityname<-citylist$Cityname
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

for(i in 25:rows){
  tryCatch({
    library(shapefiles)
    setwd(paste("S:/Users/_Exchange/1880 Stuff/AllCities/", Cityname[i],"/",sep=""))
    First<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_dup", sep=""))
    #Must detach package after this line because package shapefiles affects how read.dbf works
    detach("package:shapefiles", unload=TRUE)
    
    #Make field names lower case
    names(First)<-tolower(names(First))
    
    #Check if l_f_add exists. #Takes care of Hartford, Nashville, Oakland, and Omaha
    ifelse(exists("l_f_add", where=First@data), (First$l_f_add=First$l_f_add), 
           (First$l_f_add=First$fraddl))
    ifelse(exists("l_t_add", where=First@data), (First$l_t_add=First$l_t_add), 
           (First$l_t_add=First$toaddl))
    ifelse(exists("r_f_add", where=First@data), (First$r_f_add=First$r_f_add), 
           (First$r_f_add=First$fraddr))
    ifelse(exists("r_t_add", where=First@data), (First$r_t_add=First$r_t_add), 
           (First$r_t_add=First$toaddr))
    
    #Check if l_f_add exists. #Takes care of Mobile
    ifelse(exists("l_f_add", where=First@data), (First$l_f_add=First$l_f_add), 
           (First$l_f_add=First$lfromadd))
    ifelse(exists("l_t_add", where=First@data), (First$l_t_add=First$l_t_add), 
           (First$l_t_add=First$ltoadd))
    ifelse(exists("r_f_add", where=First@data), (First$r_f_add=First$r_f_add), 
           (First$r_f_add=First$rfromadd))
    ifelse(exists("r_t_add", where=First@data), (First$r_t_add=First$r_t_add), 
           (First$r_t_add=First$rtoadd))
    
    #Keep Variables
    myvars<-c("cityname", "statename", "l_f_add", "l_t_add", "r_f_add", "r_t_add", "newaddress")
    First<-First[myvars]
    
    #Rename Variables
    First<-rename(First, c(cityname="City", statename="State", l_f_add="l_f_range", l_t_add="l_t_range", 
                           r_f_add="r_f_range", r_t_add="r_t_range", newaddress="Street"))
    #UpperCase Street
    First$Street<-toupper(First$Street)
    
    #Remove "Illegible Street"
    First$keep<-ifelse(grepl(("ILLEGIBLE"), First$Street), 1, 0)   
    First<-subset(First, keep!=1)
    
    myvars<-c("keep")
    First<-First[!names(First) %in% myvars]  
    
    #Output New Files for The First Shapefile  
    library(shapefiles)
    setwd(paste("S:/Projects/Preparing 1880 Files/", Cityname[i], "/Street Grid With Ranges/", sep=""))
    #proj4string(First) <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0"
    writeOGR(First, dsn=getwd(), paste(Cityname[i],"_Street_Ranges",sep=""), check_exists = TRUE,
             overwrite_layer = TRUE, driver="ESRI Shapefile")
    detach("package:shapefiles", unload=TRUE)
    
    tab1<-as.data.frame(unique(First$City))
    ispresent1<-rbind(ispresent1,tab1)
  }, error=function(e){cat(conditionMessage(e))})
}

write.csv(ispresent1, "S:/Users/Ben/Ben's 1880 Cities/Complete1.csv")  

######## 2 - ED Boundaries - SHAPE FILE #####
citylist<-read.csv("S:/Projects/Preparing 1880 Files/City Lists.csv")
LongName<-citylist$LongName
Cityname<-citylist$Cityname
Cityname<-citylist$Cityname
Seg_ID<-citylist$Seg_ID
rows<-nrow(citylist)

ispresent2<-data.frame(City=character())
for(i in 26:26){
  tryCatch({
    library(shapefiles)
    setwd(paste("S:/Users/_Exchange/1880 Stuff/AllCities/", Cityname[i],"/",sep=""))
    Second<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_edt",sep=""))
    
    Second<-subset(Second, Second$ED!=-1)
    Second<-subset(Second, Second$ED!=0)
    Second<-subset(Second, Second$ED!=999)
    Second<-subset(Second, Second$ED!=9999)
    
    myvars<-c("ED")
    Second<-Second[myvars]
    
    setwd(paste("S:/Projects/Preparing 1880 Files/", Cityname[i], "/ED/", sep=""))
    #proj4string(Second) <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0"
    writeOGR(Second, dsn=getwd(), paste(Cityname[i],"_ED",sep=""), driver="ESRI Shapefile",
             check_exists = TRUE, overwrite_layer = TRUE)
    detach("package:shapefiles", unload=TRUE)
    
    tab2<-as.data.frame(unique(Second$NHGISNAM))
    rename(tab2, c('unique(Second$NHGISNAM)'="City"))
    ispresent2<-rbind(ispresent2,tab2)
  }, error=function(e){cat(conditionMessage(e))})
}

write.csv(ispresent2, "S:/Users/Ben/Ben's 1880 Cities/Complete2.csv")  


#5 - Street Grid No Ranges - Segment, Segment Group, and Extended Segment Group - SHAPE FILE ####
#NEED OVERLAPPING AS WELL - DONE FOR 10 SOUTHERN CITIES - CREATE PYTHON CODE

#Create stable variable names to be used in the for loop.  This is necessary because not all variables have the same naming structure in the files

citylist<-read.csv("S:/Projects/Preparing 1880 Files/City Lists.csv")
citylist<-subset(citylist, citylist$Fix5!="x")
LongName<-citylist$LongName
Cityname<-citylist$Cityname
Cityname<-citylist$Cityname
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

ispresent5<-data.frame(City=character())
for(i in 33:33){
  tryCatch({
    library(shapefiles)
    setwd(paste("S:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
    Fifth<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_segment", sep=""))
    #Must detach package after this line because package shapefiles affects how read.dbf works
    detach("package:shapefiles", unload=TRUE)
    
    #Make field names lower case
    Type<-read.dbf(paste("S:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/", Cityname[i],"_dup_name.dbf",sep=""))
    SegGroup<-read.dbf(paste("S:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],"_join150.dbf", sep=""))
    Extended<-read.dbf(paste("S:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],"_join225.dbf", sep=""))
    
    names(Type)<-tolower(names(Type))
    names(SegGroup)<-tolower(names(SegGroup))
    names(Extended)<-tolower(names(Extended))
    names(Fifth)<-tolower(names(Fifth))
    
    #Make changes to Yi's Files
    ifelse(exists(paste(Seg_ID[i]), where=Extended), 
           (assign("Extended$",Seg_ID[i])),
           (Extended$seg_id=Extended$segment_id))
    
    ifelse(exists(paste(Seg_ID[i]), where=SegGroup), 
           (assign("SegGroup$",Seg_ID[i])),
           (SegGroup$seg_id=SegGroup$segment_id))   
    
    #Bring in Segment Id
    #Create new house number from geocoded data
    ifelse(exists("newaddress", where=Fifth@data), (Fifth$newaddress=Fifth$newaddress),
           (Fifth$newaddress=Fifth$street_new))
    Fifth$newaddress<-ifelse(is.na(Fifth$newaddress), as.character(Fifth$street), as.character(Fifth$newaddress))
    
    #Eliminate Seg ID's of zero.
    Fifth<-subset(Fifth, (eval(parse(text=paste("Fifth$",Seg_ID[i],sep="")))!=0))
    
    #Bring in Segment Group
    Fifth_1<-merge(x=SegGroup[,c(as.character(hex150[i]),as.character(Seg_ID[i]), "newaddress")],
                   y=Extended[,c(as.character(hex225[i]),as.character(Seg_ID[i]))], by=Seg_ID[i], all.x=TRUE)
    #Chicago
    myvars<-c("newaddress", "hexid150", "seg_id")
    SegGroup<-SegGroup[myvars]
    myvars<-c("hex225", "seg_id")
    Extended<-Extended[myvars]
    Fifth_1<-merge(x=SegGroup, y=Extended, by="seg_id", all.x=TRUE)
    #Keep only unique segment ids
    Fifth_1<-subset(Fifth_1, !duplicated(eval(parse(text=paste("Fifth_1$", Seg_ID[i], sep="")))))
    
    #Pull New Address From Dup File and From Segment Project File
    myvars<-c("newaddress", "type")
    newadd_dup<-Type[myvars]
    myvars<-c("newaddress", as.character(Seg_ID[i]))
    newadd_pro<-Fifth@data[myvars]
    #This file is from the Street Project File, but keeps all observations
    newadd_pro2<-Fifth@data[myvars]
    #Keep Only Unique New Address
    newadd_dup<-subset(newadd_dup, !duplicated(newadd_dup$newaddress))
    newadd_pro<-subset(newadd_pro, !duplicated(newadd_pro$newaddress))
    #Merge
    newtype<-merge(x=newadd_pro, y=newadd_dup, by="newaddress", all.x=T)
    myvars<-c("newaddress", "type")
    newtype<-newtype[myvars]
    newtype2<-merge(x=newadd_pro2, y=newtype, by="newaddress", all.x=T)
    
    #Add Type
    Fifth_1<-merge(x=Fifth_1, y=newtype2[,c(as.character(Seg_ID[i]),"type")], by=as.character(Seg_ID[i]), all.x=TRUE)
    #Drop Newaddress as it will be added from the Street Segment File (Fifth)
    myvars<-c("newaddress")
    Fifth_1<-Fifth_1[!names(Fifth_1) %in% myvars]
    #Clean Up Memory for Efficient Processing
    rm(SegGroup, Extended, Type) 
    #Merge to Shapefile
    Fifth<-merge(x=Fifth, y=Fifth_1, by=as.character(Seg_ID[i]), all.x=TRUE)        
    #Rename Variables where necessary
    Fifth<-rename(Fifth, c(seg_id="Seg_id", segid="Seg_id", newaddress="Street", type="Type", 
                           hexid150="SegG_id", hex150="SegG_id", hexid225="ExtG_id", hex225="ExtG_id"))
    #Remove segment length variable
    myvars<-c("Street", "Type", "Seg_id", "SegG_id", "ExtG_id")
    Fifth<-Fifth[myvars]
    
    #Uppercase Street and Type
    Fifth$Street<-toupper(Fifth$Street)
    Fifth$Type<-toupper(Fifth$Type) 
    
    #Remove "Illegible Street"
    Fifth$keep<-ifelse(grepl(("ILLEGIBLE"), Fifth$Street), 1, 0)   
    Fifth<-subset(Fifth, keep!=1)
    
    myvars<-c("keep")
    Fifth<-Fifth[!names(Fifth) %in% myvars]
    #Output New Files for The First Shapefile  
    library(shapefiles)
    setwd(paste("S:/Projects/Preparing 1880 Files/", LongName[i], "/Street Grid Without Ranges/", sep=""))
    writeOGR(Fifth, dsn=getwd(), paste(LongName[i],"_StreetGrid",sep=""),check_exists = TRUE,
             overwrite_layer = T, driver="ESRI Shapefile")
    detach("package:shapefiles", unload=TRUE)
    
    tab5<-as.data.frame(unique(Cityname[i]))
    rename(tab5, c('unique(Cityname[i])'="City"))
    ispresent5<-rbind(ispresent5,tab5)
  }, error=function(e){cat(conditionMessage(e))})
}




##JUNK

#JUST REPROJECT CHICAGO
i<-9
library(shapefiles)
setwd(paste("S:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
Second<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_edt",sep=""))

Second<-subset(Second, Second$ED!=-1)
Second<-subset(Second, Second$ED!=0)
Second<-subset(Second, Second$ED!=999)
Second<-subset(Second, Second$ED!=9999)

myvars<-c("ED")
Second<-Second[myvars]

setwd(paste("S:/Projects/Preparing 1880 Files/", LongName[i], "/ED/", sep=""))
Second <- spTransform(Second,"+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")
writeOGR(Second, dsn=getwd(), paste(Cityname[i],"_ED_test",sep=""), driver="ESRI Shapefile",
         check_exists = TRUE, overwrite_layer = TRUE)
detach("package:shapefiles", unload=TRUE)

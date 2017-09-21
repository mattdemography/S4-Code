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
.jinit(parameters="-Xmx2g")
library(xlsx)
library(maptools)
library(rgdal)
library(spatialsegregation)


trim <- function( x ) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}
#Create stable variable names to be used in the for loop.  This is necessary because not all variables have the same naming structure in the files
citylist<-read.csv(("Z:/Users/Matt/Preparing 1880 Files/City Lists.csv"))
LongName<-citylist$LongName
Cityname<-citylist$Cityname
Shortname<-citylist$Shortname
Seg_ID<-citylist$Seg_ID
Seg<-citylist$Seg
street<-citylist$st
rows<-nrow(citylist)

###### TESTING CITIES ######  
for(i in 1:rows){
  tryCatch({
    library(shapefiles)
    setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
    Dup_name<-readOGR(dsn=getwd(), layer=paste(Shortname[i],"_dup_name", sep=""))
    #Must detach package after this line because package shapefiles affects how read.dbf works
    detach("package:shapefiles", unload=TRUE)
    names(Dup_name)<-tolower(names(Dup_name))
    names(Dup_name)
    
    #Check if l_f_add exists. #Takes care of Hartford, Nashville, Oakland, and Omaha
    ifelse(exists("l_f_add", where=Dup_name@data), (Dup_name$l_f_add=Dup_name$l_f_add), 
           (Dup_name$l_f_add=Dup_name$fraddl))
    ifelse(exists("l_t_add", where=Dup_name@data), (Dup_name$l_t_add=Dup_name$l_t_add), 
           (Dup_name$l_t_add=Dup_name$toaddl))
    ifelse(exists("r_f_add", where=Dup_name@data), (Dup_name$r_f_add=Dup_name$r_f_add), 
           (Dup_name$r_f_add=Dup_name$fraddr))
    ifelse(exists("r_t_add", where=Dup_name@data), (Dup_name$r_t_add=Dup_name$r_t_add), 
           (Dup_name$r_t_add=Dup_name$toaddr))
    
    #Check if l_f_add exists. #Takes care of Mobile
    ifelse(exists("l_f_add", where=Dup_name@data), (Dup_name$l_f_add=Dup_name$l_f_add), 
           (Dup_name$l_f_add=Dup_name$lfromadd))
    ifelse(exists("l_t_add", where=Dup_name@data), (Dup_name$l_t_add=Dup_name$l_t_add), 
           (Dup_name$l_t_add=Dup_name$ltoadd))
    ifelse(exists("r_f_add", where=Dup_name@data), (Dup_name$r_f_add=Dup_name$r_f_add), 
           (Dup_name$r_f_add=Dup_name$rfromadd))
    ifelse(exists("r_t_add", where=Dup_name@data), (Dup_name$r_t_add=Dup_name$r_t_add), 
           (Dup_name$r_t_add=Dup_name$rtoadd))
    
    #Grab data from shape file
    Dat.Dup_name<-Dup_name@data

#Calculate Percent of missing ranges
  Dat.Dup_name$norange<-ifelse((Dat.Dup_name$l_f_add==9999 & Dat.Dup_name$l_t_add==9999) | 
                                (Dat.Dup_name$l_f_add==0 & Dat.Dup_name$l_t_add==0) |
                                 (is.na(Dat.Dup_name$l_f_add) & is.na(Dat.Dup_name$l_t_add)), 1, 0)
  NoRangePer<-table(Dat.Dup_name$norange)

  Cityname2<-Cityname[i]  
  Cityname2<-as.character(Cityname2)
  write.xlsx(NoRangePer, file = "Z:/Users/Matt/Preparing 1880 Files/NoRange_list.xlsx", 
              sheetName = Cityname2, append=T)
  
  library(shapefiles)
  setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
  RangePts<-readOGR(dsn=getwd(), layer=paste(Shortname[i],"_rangepts", sep=""))
  
  #Check if housenum_n exists.  IF only housenum exists then change it to housenum_n as housenum_n is a better version in most files
  #This will be used for grabbing the house numbers
  ifelse(exists("housenum_n", where=RangePts@data), (RangePts$housenum_n=RangePts$housenum_n), 
         (RangePts$housenum_n=RangePts$housenum))

#Pull Data From Geocoded Shapefile
  All<-RangePts@data
  All$obs<-recode(All$User_fld, "\" \"=0; else=1")
  names(All)<-tolower(names(All))
  
#Keep only House Number from Geo-Coded Data
  All$housenum_n<-as.numeric(All$housenum_n)
  All$housenum<-as.numeric(All$housenum)
  All$new_housenum<-trim(laply(strsplit(as.character(All$match_addr), split = " "), "[", 1))
  All$new_housenum<-as.numeric(All$new_housenum)

#All Unique Street Segments from Micro Data with Addresses
  #Check if street_new exists.
  ifelse(exists("street_new", where=All), (All$street_new=All$street_new), 
         (All$street_new=All$full_name))

#All Street Segments with Ranges from Micro Data with Addresses
  StRange<-All[order(All$dup_id),]
  StRange_L<-StRange[which(StRange$side=="L"),]
  StRange_R<-StRange[which(StRange$side=="R"),]
    
  #Find Ranges of Geo Coded Micro Data - LEFT
    #MIN
    MinRange_L<-tapply(StRange_L$new_housenum, INDEX=list(StRange_L$dup_id), FUN=min)
    MinRange2_L<-data.frame(dup_id=names(MinRange_L), MinRange_L=MinRange_L)
    StRange_L<-merge(x=StRange_L, y=MinRange2_L, by="dup_id", all.x=T)
  
    #MAXIMUM
    MaxRange_L<-tapply(StRange_L$new_housenum, INDEX=list(StRange_L$dup_id), FUN=max)
    MaxRange2_L<-data.frame(dup_id=names(MaxRange_L), MaxRange_L=MaxRange_L)
    StRange_L<-merge(x=StRange_L, y=MaxRange2_L, by="dup_id", all.x=T)
    
    myvars<-c("dup_id", "MinRange_L", "MaxRange_L")
    StRange_L<-StRange_L[myvars]
    StRange_L<-subset(StRange_L, !duplicated(StRange_L$dup_id))
  
  #Find Ranges of Geo Coded Micro Data - RIGHT
    #MIN
    MinRange_R<-tapply(StRange_R$new_housenum, INDEX=list(StRange_R$dup_id), FUN=min)
    MinRange2_R<-data.frame(dup_id=names(MinRange_R), MinRange_R=MinRange_R)
    StRange_R<-merge(x=StRange_R, y=MinRange2_R, by="dup_id", all.x=T)
    
    #MAXIMUM
    MaxRange_R<-tapply(StRange_R$new_housenum, INDEX=list(StRange_R$dup_id), FUN=max)
    MaxRange2_R<-data.frame(dup_id=names(MaxRange_R), MaxRange_R=MaxRange_R)
    StRange_R<-merge(x=StRange_R, y=MaxRange2_R, by="dup_id", all.x=T)
    
    myvars<-c("dup_id","MinRange_R", "MaxRange_R")
    StRange_R<-StRange_R[myvars]
    StRange_R<-subset(StRange_R, !duplicated(StRange_R$dup_id))
    
    #Merge Right and Left Miniums
    myvars<-c("status", "dup_id")
    StRange<-StRange[myvars]
    StRange<-subset(StRange, !duplicated(StRange$dup_id))
    
    StRange<-merge(x=StRange, y=StRange_L, by="dup_id", all.x=T)
    StRange<-merge(x=StRange, y=StRange_R, by="dup_id", all.x=T)

#Combine for Street Ranges from Micro Data
  ifelse(exists("name", where=Dat.Dup_name), (Dat.Dup_name$name=Dat.Dup_name$name), 
           (Dat.Dup_name$name=Dat.Dup_name$fename))
  Allgrid<-merge(x=Dat.Dup_name, y=StRange, by="dup_id", all.x=T)
  
#Now See If these new ranges can be used for files without ranges
  No<-Allgrid[which(Allgrid$norange==1),]
  write.xlsx(No, file = "Z:/Users/Matt/Preparing 1880 Files/NoRange_data.xlsx", 
             sheetName = Cityname2, append=T)
  
  #No$l_f_add<-ifelse(No$l_f_add==9999, No$NewNum_Min, No$l_f_add)
  
  #Yes<-Allgrid[which(Allgrid$norange==0),]
  
rm(MaxRange_L, MinRange_L, MaxRange2_L, MinRange2_L, MaxRange_R, MinRange_R, MaxRange2_R, MinRange2_R,
   StRange_L, StRange_R)
write.csv(No, file=paste("Z:/Users/Matt/Preparing 1880 Files/",Cityname[i],"_norange.csv",sep=""))
  }, error=function(e){cat(conditionMessage(e))})
}

#Library List
library(foreign)
library(car)
library(plyr)
library(seg)
library(reshape)
library(reshape2)
library(rJava)
library(xlsx)
library(maptools)
library(rgdal)
library(readstata13)
library(haven)

citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
Cityname<-citylist$Cityname
Person<-citylist$Person
rows<-nrow(citylist)

  s<-data.frame(Var1=character(), Freq=character(), city=character(), Person=character(), Num_HH=character(),
                Blank_Points=character(), Num_Persons=character())
  

for(i in 1:rows){
#Fix Off Street Files
  #Old<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", Cityname[i],"/",Cityname[i],"_geocode_offst.dbf",sep=""))
  #Points<-read.csv(paste("Z:/Projects/Preparing 1880 Files/",Cityname[i],"/Match Address/",Cityname[i],".csv", sep=""))
  #Points<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", Cityname[i],"/",Cityname[i],"_geocode_offst.dbf",sep=""))
  Points<-read.dta13(paste("Z:/Projects/1880Data/MicroData For Publication/", Cityname[i],".dta",sep=""))
  
  Points<-read.dta13(paste("Z:/Projects/1880Data/MicroData For Publication/Chicago.dta",sep=""))
  
  
  names(Points)<-tolower(names(Points))
  
  #Calculate non-blank addresses
  Points$blank<-ifelse(Points$match_addr=="",1,0)
  t<-Points[which(Points$blank==1),]
  #t<-subset(t, !duplicated(t$serial))

#library(shapefiles)
#  setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", Cityname[i],"/",sep=""))
#  Old<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_geocode_offst", sep=""))
#detach("package:shapefiles", unload=TRUE)
  
  #d<-data.frame(table(Old$Status))
  d<-data.frame(table(length(Points$serial)))
  d$Cityname<-Cityname[i]
  d$Person<-Person[i]
  d$Num_HH<-length(unique(Points$serial))
  d$Blank_Points<-length(unique(t$serial))
  d$Num_Persons<-length(Points$serial)
  s<-rbind(s,d)
}

  write.csv(s, "Z:/Users/Matt/City_Pop.csv")

  Old<-Old[which(Old@data$Status=="M"),]
  names(Old)<-tolower(names(Old))
  myvars<-c("arc_city", "arc_state", "match_addr", "enumdist", "recidus", "serial")
    Old<-Old[myvars]
  Old<-plyr::rename(Old, c(arc_city="City", arc_state="State", match_addr="Addr_Match", enumdist="ED", serial="Serial"))
  #Add St_type Place Holder
    Old$St_Type<-""
    Old<-Old[,c(1,2,3,7,4,5,6)]
  Old<-subset(Old, !duplicated(Old$Serial))
  
  setwd(paste("Z:/Projects/Preparing 1880 Files/",Cityname[i],"/Off Street/",sep=""))
  New<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_OffStreet", sep=""))
  length(New)
#Must detach package after this line because package shapefiles affects how read.dbf works
  detach("package:shapefiles", unload=TRUE)

  New$keep<-ifelse(is.na(New$Addr_Match),1,0)
  table(New$keep)
  Old<-Old[which(Old$keep==1),]
  
  
  
  
  
  
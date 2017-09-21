#Library List
  library(foreign)
  library(car)
  library(readstata13)
  library(plyr)
  library(seg)
  library(reshape)
  library(reshape2)
  library(rJava)
  library(xlsx)
  library(maptools)
  library(rgdal)
  library(haven)
  
citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
  Cityname<-citylist$Cityname
  Seg_ID<-citylist$Seg_ID
  Segment<-citylist$SG
  hex150<-citylist$hex150
  rows<-nrow(citylist)
  
for(i in 1:1){
}
#Bring in Microdata file
    Points<-read.csv(paste("Z:/Projects/Preparing 1880 Files/",Cityname[i],"/Match Address/",Cityname[i],".csv", sep=""))

  #Fix Variables
    #Cityname
      Points$Cityname<-Cityname[i]  
    #Race
      Points$race<-car::recode(Points$race, "100='white';c(200, 210)='black';300='American Indian/Alaska Native';
                               400='Chinese';500='Japanese';else='Missing'")
    #Relate
      rel<-read.csv("Z:/Projects/Preparing 1880 Files/Relate_Codes.csv", stringsAsFactors = F)
      Points$relate<-as.character(Points$relate)
      Points<-merge(Points, rel[,c("Code", "Label")], by.x="relate", by.y="Code", all.x=T)
      Points<-rename(Points, c("Label"="Relation to HH"))
    #Birthplace
      bpl<-read.csv("Z:/Projects/Preparing 1880 Files/BPL_Codes.csv", stringsAsFactors = F)
      Points$bpldet<-as.character(Points$bpldet)
      Points<-merge(Points, bpl[,c("Code", "Label")], by.x="bpldet", by.y="Code", all.x=T)
      Points<-rename(Points, c("Label"="BPL"))
    #Father's Birthplace
      fbpl<-read.csv("Z:/Projects/Preparing 1880 Files/FBPL_Codes.csv", stringsAsFactors = F)
      Points$fbpldtus<-as.character(Points$fbpldtus)
      Points<-merge(Points, fbpl[,c("Code", "Label")], by.x="fbpldtus", by.y="Code", all.x=T)
      Points<-rename(Points, c("Label"="FBPL"))
    #Mother's Birthplace
      mbpl<-read.csv("Z:/Projects/Preparing 1880 Files/MBPL_Codes.csv", stringsAsFactors = F)
      Points$mbpldtus<-as.character(Points$mbpldtus)
      Points<-merge(Points, mbpl[,c("Code", "Label")], by.x="mbpldtus", by.y="Code", all.x=T)
      Points<-rename(Points, c("Label"="MBPL"))
    #Sex
      Points$sex<-car::recode(Points$sex, "1='Male'; 2='Female';else='Missing'")

  #Keep Variables for Building Profiles
    myvars<-c("serial", "namefrst","namelast", "sex", "relate", "age", "race", "BPL","FBPL","MBPL", "occstrng")
    Build_Profile<-Points[myvars]

#Rename Variables to Make Intuitive
  Build_Profile<-rename(Build_Profile, c("namefrst"="First Name", "namelast"="Surname", "sex"="Sex", "age"="Age",
                           "race"="Race", "occstrng"="Occupation", "BPL" = "Birthplace", "FBPL"="Fathers Birthplace",
                           "MBPL"="Mothers Birthplace"))
  myvars<-c("bpldet","relate", "fbpldtus", "mbpldtus")
  Build_Profile<-Build_Profile[!names(Build_Profile) %in% myvars]
  
#### Write Building Profile File #####
  write.csv(Build_Profile,paste("Z:/Projects/Preparing 1880 Files/Online Maps/",Cityname[i],"_MicroData.csv", sep=""))
  

###### Aggregation Calculations #####
#Keep Variables for Aggregation
  myvars<-c("serial", "age", "race", "occ50us", "bpldet", "fbpldtus", "mbpldtus", "building_id", "segment_id")
  Agg<-Points[myvars]



 
           
}
  


    
    
  #Bring in File to Aggregate Buildings (Addresses)
  Build<-read.dbf(paste("Z:/Projects/Preparing 1880 Files/", Cityname[i],"/Off Street/",Cityname[i],"_OffStreet.dbf",sep=""))
  Points<-merge(Points, Build[,c("Addr_Match", "Serial")], by.x="serial", by.y="Serial", all.x=T)
  Points$serial<-as.character(Points$serial)
  
  #Bring in File to Aggregate Segment ID
  S<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",Cityname[i],"/",Cityname[i],Segment[i], sep=""))
  names(S)<-tolower(names(S))
  S$serial<-as.character((S$serial))
  S<-subset(S, !duplicated(S$serial))
  Points<-merge(Points, S[,c("serial","match_addr")], by="serial", all.x=T)
  #Attach Addresses to points that do not have them if we have information for them.
  Points$Addr_Match<-ifelse(is.na(Points$Addr_Match),Points$match_addr,Points$Addr_Match)
  
#FOR CITIES WITHOUT RECIDUS IN _OFF STREET FILE
  citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
  #citylist<-subset(citylist, (citylist$rec!="x"))
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

ispresent3a<-data.frame(City=character())
for(i in 1:rows){
  
#Bring in Old File from Previous Step
micropub<-read.csv(paste("Z:/Projects/Preparing 1880 Files/Output/", Shortname[i], "_micropub.csv", sep=""))
#Bring in Microdata file
Points<-read.dta13(paste("Z:/Projects/1880Data/MicroData For Publication/",LongName[i],".dta", sep=""))
names(Points)<-tolower(names(Points))
  
  #Keep variables from microdata file
  myvars<-c("recidus", "serial")
  Points<-Points[myvars]

  #Keep only one serial number
  Points<-subset(Points, !duplicated(Points$serial))
  Points<-rename(Points, c("serial"="Serial"))
  
  All<-merge(x=micropub, y=Points, by="Serial", all.x=T)
  myvars<-c("X")
  All<-All[!(names(All) %in% myvars)]
  All<-subset(All, !is.na(All$y))
  write.csv(All, paste("Z:/Projects/Preparing 1880 Files/Output/With_Recidus/", Shortname[i], "_micropub_010417.csv", sep=""))  
}
  
  
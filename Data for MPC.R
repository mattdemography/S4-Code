#FOR CITIES WITHOUT RECIDUS IN _OFF STREET FILE
  citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
  Cityname<-citylist$Cityname
  rows<-nrow(citylist)

ispresent3a<-data.frame(City=character())
for(i in 1:rows){
#Bring in Old File from Previous Step
#micropub<-read.csv(paste("Z:/Projects/Preparing 1880 Files/Output/", Cityname[i], "_micropub.csv", sep=""))
print (paste("Working On:", Cityname[i], sep=""))
micropub<-read.dbf(paste("Z:/Projects/Preparing 1880 Files/", Cityname[i], "/Off Street/", Cityname[i],"_OffStreet_BenResult.dbf", sep=""),
                   as.is=T)
names(micropub)<-tolower(names(micropub))
  myvars<-c("match_addr", "cityname", "statename", "x", "y", "serial")
  micropub<-micropub[myvars]
  micropub$serial<-substr(micropub$serial,regexpr("[^0]", micropub$serial),nchar(micropub$serial))

#Bring in Microdata file
Points<-read.dta13(paste("Z:/Projects/Preparing 1880 Files/", Cityname[i],"/Match Address/",Cityname[i],"_BenResult.dta", sep=""))
names(Points)<-tolower(names(Points))
  #Keep variables from Points file
  myvars<-c("recidus", "serial", "type", "enumdist")
  Points<-Points[myvars]
  Points$recidus<-as.character(Points$recidus)
  Points$serial<-substr(Points$serial,regexpr("[^0]",Points$serial),nchar(Points$serial))

#Keep only one serial number
  Points<-subset(Points, !duplicated(Points$serial))
#Subset Points not in geocode results
  m_serial<-as.numeric(unique(micropub$serial))
  Points$keep<-ifelse(Points$serial %in% m_serial, 0, 1)
  NotGeocode<-subset(Points, Points$keep==1)
  NotGeocode$match_addr<-NA
  NotGeocode$cityname<-unique(micropub$cityname)
  NotGeocode$statename<-unique(micropub$statename)
  NotGeocode$x<-NA
  NotGeocode$y<-NA

  All<-merge(x=micropub, y=Points, by="serial", all.x=T)
  All<-rbind(All, NotGeocode)
  myvars<-c("X", "keep")
  All<-All[!(names(All) %in% myvars)]
  All<-plyr::rename(All, c(match_addr="Addr_Match", cityname="City", statename="State", type="St_type", enumdist="ED"))
  
  #All<-subset(All, !is.na(All$y))
  write.csv(All, paste("Z:/Projects/Preparing 1880 Files/Output/Ben Results/", Cityname[i], "_micropub_060217.csv", sep=""),row.names = F)  
}
  
  
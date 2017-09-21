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
  
for(i in 1:rows){
  tryCatch({
    library(shapefiles)
    setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
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
    setwd(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Street Grid With Ranges/", sep=""))
    writeOGR(First, dsn=getwd(), paste(LongName[i],"_Street_Ranges",sep=""), check_exists = TRUE,
             overwrite_layer = TRUE, driver="ESRI Shapefile")
    detach("package:shapefiles", unload=TRUE)
  
    tab1<-as.data.frame(unique(First$City))
    ispresent1<-rbind(ispresent1,tab1)
  }, error=function(e){cat(conditionMessage(e))})
}

  write.csv(ispresent1, "Z:/Users/Matt/Preparing 1880 Files/Complete1.csv")  

######## 2 - ED Boundaries - SHAPE FILE #####
citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
  citylist<-subset(citylist, citylist$Fix2!="x")
  LongName<-citylist$LongName
  Cityname<-citylist$Cityname
  Cityname<-citylist$Cityname
  Seg_ID<-citylist$Seg_ID
  rows<-nrow(citylist)
  
ispresent2<-data.frame(City=character())
for(i in 9:9){
  tryCatch({
    library(shapefiles)
    setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
    Second<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_edt",sep=""))
    
    Second<-subset(Second, Second$ED!=-1)
    Second<-subset(Second, Second$ED!=0)
    Second<-subset(Second, Second$ED!=999)
    Second<-subset(Second, Second$ED!=9999)
    
    myvars<-c("ED")
    Second<-Second[myvars]
    
    setwd(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/ED/", sep=""))
    writeOGR(Second, dsn=getwd(), paste(Cityname[i],"_ED",sep=""), driver="ESRI Shapefile",
             check_exists = TRUE, overwrite_layer = TRUE)
    detach("package:shapefiles", unload=TRUE)
  
    tab2<-as.data.frame(unique(Second$NHGISNAM))
    rename(tab2, c('unique(Second$NHGISNAM)'="City"))
    ispresent2<-rbind(ispresent2,tab2)
  }, error=function(e){cat(conditionMessage(e))})
}

  write.csv(ispresent2, "Z:/Users/Matt/Preparing 1880 Files/Complete2.csv")  
  
######## 3 - Off St Geocoded Addresses - POINT FILE #####
  citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
  #citylist<-subset(citylist, (citylist$Fix3!="x"))
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
  
ispresent3<-data.frame(City=character())
for(i in 32:32){
}
  tryCatch({
    library(shapefiles)
      setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
      Third<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_geocode_offst", sep=""))
      Third<-Third[which(Third@data$Status=="M"),]
    #Must detach package after this line because package shapefiles affects how read.dbf works
    detach("package:shapefiles", unload=TRUE)
    
    #Make names lowercase
      names(Third)<-tolower(names(Third))
    #Bring in DBF from On Street to merge type with Off Street
      OnSt<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", Cityname[i],"/", Cityname[i],"_type.dbf",sep=""))
      names(OnSt)<-tolower(names(OnSt))
      OnSt$match_addr<-as.character(OnSt$match_addr)
      OnSt<-OnSt[!(is.na(OnSt$match_addr)),]
      
    #Check if Street_new exists.
      ifelse(exists("street_new", where=OnSt), (OnSt$street_new=OnSt$street_new), 
             (OnSt$street_new=OnSt$full_name))    
    
    #For Hartford
      #OnSt$street_new<-paste(OnSt$fename," ", OnSt$fetype, sep="")
      
    #Remove duplicate serial ids which happen when an onstreet point is attached to two segments.
      OnSt$unique<-id(OnSt[c("match_addr", "serial")], drop=T)
      OnSt$compareadd<-gsub("[0-9]+[ ]", "", OnSt$match_addr)
      OnSt$newaddress<-as.character(OnSt$newaddress)
      OnSt$newaddress<-tolower(OnSt$newaddress)
      OnSt$compareadd<-as.character(OnSt$compareadd)
      OnSt$compareadd<-tolower(OnSt$compareadd)
      OnSt$street_new<-as.character(OnSt$street_new)
      OnSt$street_new<-tolower(OnSt$street_new)
      
      OnSt$newaddress2<-paste(OnSt$newaddress, ", ", OnSt$cityname, ", ", OnSt$statename, sep="")
      OnSt$newaddress2<-tolower(OnSt$newaddress2)
      
    #For Detroit
    #  OnSt$newaddress2<-paste(OnSt$full_name, ", ", OnSt$cityname, ", ", OnSt$statename, sep="")
    #  OnSt$newaddress2<-tolower(OnSt$newaddress2)
      
      cnt<-tapply(OnSt$join_count, INDEX=list(OnSt$unique), FUN=sum)
      cnts<-data.frame(unique=names(cnt), dups=cnt)
      OnSt<-merge(x=OnSt, y=cnts, by="unique", all.x=T)

      one<-OnSt[which(OnSt$dups==1 | OnSt$dups==0),]
      more<-OnSt[which(OnSt$dups>=2),]
      
      more$keep<-ifelse(more$compareadd==more$newaddress | more$street_new==more$newaddress | 
                          more$compareadd==more$newaddress2 | more$street_new==more$newaddress2 , 1, 0)
      more<-more[which(more$keep==1),]
      more<-subset(more, !duplicated(more$serial))
      
      one<-subset(one, !duplicated(one$serial))
      one$keep<-1
      dup<-rbind(one, more)
      dup<-subset(dup, !duplicated(dup$serial))
      
    #Keep variables from OnSt file
      myvars<-c("serial", "type", "match_addr")
      dup<-dup[myvars]
      dup<-plyr::rename(dup, c(match_addr="OnStADD"))
      
    #Join Type to Shapefile
      Third<-merge(x=Third, y=dup, by="serial", all.x=T, all.y=F)  

    #Keep Variables
      myvars<-c("arc_city", "arc_state", "match_addr", "type", "enumdist", "recidus", "serial")
      Third<-Third[myvars]
    #Rename Variables
      Third<-plyr::rename(Third, c(arc_city="City", arc_state="State", match_addr="Addr_Match",
                            type="St_Type", enumdist="ED", serial="Serial"))
      
    #Remove 'Illegible Street'
      Third$keep<-ifelse(grepl(("Illegible"), Third$Addr_Match), 1, 0)   
      Third<-subset(Third, keep!=1)
      myvars<-c("keep")
      Third<-Third[!(names(Third) %in% myvars)]
      
    #Remove Duplicate Serial Numbers
      Third<-subset(Third, !duplicated(Third$Serial))  
    
    #For Philadelphia
      Third$City<-"Philadelphia"
      Third$Addr_Match<-ifelse(grepl("[0-9]", laply(strsplit(as.character(Third$Addr_Match), split=","), "[", 2)),
                                paste(laply(strsplit(as.character(Third$Addr_Match), split=","), "[", 1),
                                "Philadelphia", laply(strsplit(as.character(Third$Addr_Match), split=", "), "[", 3), sep=", ")
                                , "")

    #For BUFFALO #
    #  Third$keep<-ifelse(grepl(("Driving Park"), Third$Addr_Match), 1, 0)
    #  table(Third$keep)
    #  Third<-subset(Third, keep!=1)
    #  myvars<-c("keep")
    #  Third<-Third[!names(Third) %in% myvars]
        
    #Output New Files for The Third Shapefile  
    library(shapefiles)
      setwd(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", sep=""))
      writeOGR(Third, dsn=getwd(), paste(LongName[i],"_OffStreet",sep=""), check_exists = TRUE,
               overwrite_layer = TRUE, driver="ESRI Shapefile")
    detach("package:shapefiles", unload=TRUE)
  
    write.csv(Third, paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", Cityname[i], ".csv", sep=""))
    Third.csv<-read.csv(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", Cityname[i], ".csv", sep=""))
    Third.csv<-rename(Third.csv, c(coords.x1="x", coords.x2="y"))
    myvars<-c("X", "optional", "coords.x1", "coords.x2")
      Third.csv<-Third.csv[!names(Third.csv) %in% myvars]
      write.csv(Third.csv, paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", Cityname[i], ".csv", sep=""))
  
  #Eliminate 'NA' in 'St_Type'
    Third.csv<-read.csv(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", Cityname[i], ".csv", sep=""))
    myvars<-c("X")
    Third.csv<-Third.csv[!names(Third.csv) %in% myvars]
    Third.csv$St_Type<-ifelse(is.na(Third.csv$St_Type), " ", as.character(Third.csv$St_Type))
    write.csv(Third.csv, paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", Cityname[i], ".csv", sep=""))

  #Remove Files to Help with Memory
    rm(Third, OnSt, one, more, dup)
    
  }, error=function(e){cat(conditionMessage(e))})
}
  
  write.csv(ispresent3, "Z:/Users/Matt/Preparing 1880 Files/Complete3.csv")  

###### 3A - Add non-geocoded data to csv files
citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
  #citylist<-subset(citylist, (citylist$Fix3a!="x"))
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
  
ispresent3a<-data.frame(City=character())
  for(i in 1:1){
  }
    tryCatch({ 
      #Bring in Old File from Previous Step
        micropub<-read.csv(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", Cityname[i], ".csv", sep=""))
      #Bring in Microdata file
        Points<-read.dta13(paste("Z:/Projects/1880Data/MicroData For Publication/",LongName[i],".dta", sep=""))
        names(Points)<-tolower(names(Points))
        
      #Keep variables from microdata file
        myvars<-c("incplcus", "recidus", "serial")
        Points<-Points[myvars]
      #Keep only one serial number
        Points<-subset(Points, !duplicated(Points$serial))
        Points<-rename(Points, c("incplcus"="City", "serial"="Serial"))
        
      #Add State, Match, "St_Type, "ED", "x", "y" to the microdata since it does not contain it and the fields must match to bind
        
        State<-as.character(micropub$State)
        
        Points$State<-paste(State[1],sep="") 
        Points$Addr_Match<-" "
        Points$St_Type<-" "
        Points$ED<-as.integer("")
        Points$x<-as.numeric("")
        Points$y<-as.numeric("")
        
      #Check for Missing serial numbers
        Points$keep<-ifelse(Points$Serial %in% micropub$Serial, 0, 1)
        Points<-subset(Points, Points$keep==1)
      
      #Join both files
        myvars<-c("keep")
        Points<-Points[!names(Points) %in% myvars]
  
        myvars<-c("X")
        #For Pittsburgh
          #myvars<-c("coords.x3")
        micropub<-micropub[!names(micropub) %in% myvars]
        
        micropub<-rbind(micropub, Points)
    
    #Write out file
    write.csv(micropub, paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Off Street/", Cityname[i], "_micropub.csv", sep=""))
      
    tab3a<-as.data.frame(Cityname[i])
    ispresent3a<-rbind(ispresent3a,tab3a)
    }, error=function(e){cat(conditionMessage(e))})
}  
  
###### 4 - Match Address with Segment ID, Segment Group, Extended Segment Group, Building Group - MicroData POINT FILE #####
ispresent4<-data.frame(City=character())
citylist<-read.csv(("Z:/Projects/Preparing 1880 Files/City Lists.csv"))
citylist<-subset(citylist, (citylist$Maps=="x"))
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
  
for(i in 1:1){
}
    tryCatch({
      #d<-read.dbf(file.choose())
      Type<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", Cityname[i],"/", Cityname[i],"_type.dbf",sep=""))
      Segment<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",Cityname[i],"/",Cityname[i],Seg[i], sep=""))
      SegGroup<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",Cityname[i],"/",Cityname[i],SG[i], sep=""))
      Extended<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",Cityname[i],"/",Cityname[i],Ex[i], sep=""))
      Points<-read.dta13(paste("Z:/Projects/1880Data/MicroData For Publication/",Cityname[i],".dta", sep=""))

      names(Type)<-tolower(names(Type))
      names(Segment)<-tolower(names(Segment))
      names(SegGroup)<-tolower(names(SegGroup))
      names(Extended)<-tolower(names(Extended))
      names(Points)<-tolower(names(Points))

    #Remove Duplicates 
      Type<-subset(Type, !duplicated(Type$serial))
      Segment<-subset(Segment, !duplicated(Segment$serial))
      SegGroup<-subset(SegGroup, !duplicated(SegGroup$serial))
      Extended<-subset(Extended, !duplicated(Extended$serial))
        
    #Make changes to Yi's Files
      ifelse(exists(paste(Seg_ID[i]), where=Extended), 
             (assign("Extended$",Seg_ID[i])),
             (Extended$seg_id=Extended$join_fid))
      
      ifelse(exists(paste(Seg_ID[i]), where=SegGroup), 
             (assign("SegGroup$",Seg_ID[i])),
             (SegGroup$seg_id=SegGroup$join_fid))
      
      ifelse(exists("seg_id", where=SegGroup), (SegGroup$seg_id=SegGroup$seg_id), (SegGroup$seg_id=SegGroup$segid))
      ifelse(exists("seg_id", where=Segment), (Segment$seg_id=Segment$seg_id), (Segment$seg_id=Segment$segid))
      ifelse(exists("seg_id", where=Extended), (Extended$seg_id=Extended$seg_id), (Extended$seg_id=Extended$segid))
      
  #Bring in Segment Id
      #Create new house number from geocoded data
        Segment$new_housenum<-trim(laply(strsplit(as.character(Segment$match_addr), split = " "), "[", 1))
        Segment$new_housenum<-as.numeric(Segment$new_housenum)
      #  Segment$housenum_n<-trim(gsub("[?]","", Segment$housenum_n, perl=T))
      #  Segment$housenum_n<-as.numeric(Segment$housenum_n)
        ifelse(exists("newaddress", where=Segment), (Segment$newaddress=Segment$newaddress),
               (Segment$newaddress=Segment$street_new))
        Segment$newaddress<-ifelse(is.na(Segment$newaddress), as.character(Segment$street), as.character(Segment$newaddress))
        Segment<-Segment[complete.cases(Segment$side,Segment$new_housenum),]
      
      #Eliminate Seg ID's of zero or missing.
        Segment<-Segment[complete.cases(Segment[Seg_ID[i]]),]
        Segment<-subset(Segment, (eval(parse(text=paste("Segment$",Seg_ID[i],sep="")))!=0))
    
      #Order by Address and House Number
        Segment<-Segment[order(Segment$newaddress,Segment$new_housenum),]
      #Tag Unique Streets and Housenumbers - I.E. BUILDINGS
        Segment$build_id<-id(Segment[c("newaddress","new_housenum")], drop=T)
        Segment$build_id<-as.numeric(Segment$build_id)
      #Tag Unique Sides and Segments
        Segment$segside<-id(Segment[c(as.character(Seg_ID[i]),"side")], drop=T)
    
  #Bring in Segment Group
    Fourth<-merge(x=SegGroup[,c(as.character(hex150[i]),"serial")],
                  y=Extended[,c(as.character(hex225[i]),as.character(Seg_ID[i]),"serial")], by="serial", all.x=TRUE)
  #Add Type
    Fourth<-merge(x=Fourth, y=Type[,c("serial", "type")], by="serial", all.x=TRUE)
    Fourth<-merge(x=Fourth,y=Segment[,c("serial","new_housenum","newaddress","build_id", "side","segside")], 
                  by="serial", all.x=TRUE)        
    Fourth<-subset(Fourth, !duplicated(Fourth$serial))
    
  #Clean Up Memory for Efficient Processing
    #rm(SegGroup, Extended, Type, Segment)
    
  #Bring in Building Groups
    #Create subset of Fourth so that only one building id is in the dataset
      Neigh<-Fourth[!duplicated(Fourth$build_id),]
    
    #Divide by Side of Street
      sgright<-Neigh[which(Neigh$side=="R"),]
      sgleft<-Neigh[which(Neigh$side=="L"),]
    
    #Order
      sgright<-sgright[order(sgright$newaddress, sgright$new_housenum),]
      sgleft<-sgleft[order(sgleft$newaddress, sgleft$new_housenum),]
    
    #Create Neighbor Pairs
      sgright$Neighbor_1<-shift(sgright$build_id, 1)
      sgright$Neighbor_2<-shift(sgright$build_id, -1)
    #Create a sequence of numbers by segment id.  This code counts from 1 to N+1 for every unique segment id.
      sgright$Seq<-with(sgright, ave(eval(parse(text=paste("sgright$",Seg_ID[i],sep=""))),
                                   eval(parse(text=paste("sgright$",Seg_ID[i],sep=""))), FUN=seq_along))
    #Marks the maximum number in the sequence of numbers.  This is used to determine the last building on the segment
      sgright$Max<-with(sgright, ave(sgright$Seq,eval(parse(text=paste("sgright$",Seg_ID[i],sep=""))), FUN=function(x)
        seq_along(x)==which.max(x)))==1
    #Marking the first and last building of each segment
      sgright$Neighbor_1<-ifelse(sgright$Max=="TRUE", "NA", sgright$Neighbor_1)
      sgright$Neighbor_2<-ifelse(sgright$Seq==1, "NA", sgright$Neighbor_2)
    
    #Create Neighbor Pairs - LEFT SIDE
      sgleft$Neighbor_1<-shift(sgleft$build_id, 1)
      sgleft$Neighbor_2<-shift(sgleft$build_id, -1)
      
      sgleft$Seq<-with(sgleft, ave(eval(parse(text=paste("sgleft$",Seg_ID[i],sep=""))),
                                 eval(parse(text=paste("sgleft$",Seg_ID[i],sep=""))), FUN=seq_along))
      sgleft$Max<-with(sgleft, ave(sgleft$Seq,eval(parse(text=paste("sgleft$",Seg_ID[i],sep=""))), FUN=function(x)
        seq_along(x)==which.max(x)))==1
    
      sgleft$Neighbor_1<-ifelse(sgleft$Max=="TRUE", "NA", sgleft$Neighbor_1)
      sgleft$Neighbor_2<-ifelse(sgleft$Seq==1, "NA", sgleft$Neighbor_2)
    
    Neigh<-rbind(sgright,sgleft)
    myvars<-c("Neighbor_1", "Neighbor_2", "build_id")
    Neigh<-Neigh[myvars]
    
    #Combine Neighbors with Fourth
    Neigh<-Neigh[!duplicated(Neigh$build_id),]
    Fourth<-merge(x=Fourth, y=Neigh, by="build_id", all.x=TRUE)  
  
  rm(Neigh, sgleft, sgright)
    
    #Rename Variables where necessary
      Fourth<-rename(Fourth, c(new_housenum="House_Number", newaddress="Street", type="Type",side="Side", 
                             seg_id="Segment_id", segid="Segment_id", build_id="Building_id", hexid150="SegGroup_id", 
                             hex150="SegGroup_id", hexid225="ExtGroup_id", hex225="ExtGroup_id"))
      myvars<-c("segside")
      Fourth<-Fourth[!(names(Fourth) %in% myvars)]
      
    #Arrange Order of Variables
      myvars<-c("serial", "House_Number", "Street", "Type", "Side", "Segment_id", "Building_id", "Neighbor_1", "Neighbor_2",
                "SegGroup_id", "ExtGroup_id")
      Fourth<-Fourth[myvars]
    #Bring in MicroData
      Fourth<- data.frame(lapply(Fourth, as.character), stringsAsFactors=FALSE)
      Fourth$serial<-as.numeric(Fourth$serial)
      Points$serial<-as.numeric(Points$serial)
      Fourth<-merge(x=Points, y=Fourth, by="serial", all.x=TRUE)

    #Keep Certain Variables for Microdata - Minnesota
      myvars<-c("serial", "match_address")
      
      
    #Write Output Files
      write.csv(Fourth, paste("Z:/Projects/Preparing 1880 Files/", Cityname[i], "/Match Address/", Cityname[i], ".csv", sep=""))  
      #Change characters to factors to work with Stata output
        for (colname in names(Fourth)){
          if (is.character(Fourth[[colname]])){
            Fourth[[colname]]<-as.factor(Fourth[[colname]])
          }
        }
      write.dta(Fourth, paste("Z:/Projects/Preparing 1880 Files/", Cityname[i], "/Match Address/", Cityname[i], ".dta", sep=""))
    
    tab4<-as.data.frame(unique(Fourth$incplcus))
    rename(tab4, c('unique(Fourth$incplcus)'="City"))
    
    ispresent4<-rbind(ispresent4,tab4)
  }, error=function(e){cat(conditionMessage(e))})
}


#5 - Street Grid No Ranges - Segment, Segment Group, and Extended Segment Group - SHAPE FILE ####
  #NEED OVERLAPPING AS WELL - DONE FOR 10 SOUTHERN CITIES - CREATE PYTHON CODE
  
  #Create stable variable names to be used in the for loop.  This is necessary because not all variables have the same naming structure in the files
  
  citylist<-read.csv("Z:/Projects/Preparing 1880 Files/City Lists.csv")
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
for(i in 1:rows){
  tryCatch({
    library(shapefiles)
    setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
    Fifth<-readOGR(dsn=getwd(), layer=paste(Cityname[i],"_segment_project", sep=""))
    #Must detach package after this line because package shapefiles affects how read.dbf works
    detach("package:shapefiles", unload=TRUE)

    #Make field names lower case
      Type<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/", Cityname[i],"_dup_name.dbf",sep=""))
      SegGroup<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],"_join150.dbf", sep=""))
      Extended<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],"_join225.dbf", sep=""))

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
          myvars<-c("hexid225", "seg_id")
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
        setwd(paste("Z:/Projects/Preparing 1880 Files/", LongName[i], "/Street Grid Without Ranges/", sep=""))
        writeOGR(Fifth, dsn=getwd(), paste(LongName[i],"_StreetGrid",sep=""),check_exists = TRUE,
                 overwrite_layer = FALSE, driver="ESRI Shapefile")
        detach("package:shapefiles", unload=TRUE)
        
      tab5<-as.data.frame(unique(Cityname[i]))
      rename(tab5, c('unique(Cityname[i])'="City"))
      ispresent5<-rbind(ispresent5,tab5)
  }, error=function(e){cat(conditionMessage(e))})
}

  
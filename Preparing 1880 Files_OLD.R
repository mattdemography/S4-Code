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


#Create stable variable names to be used in the for loop.  This is necessary because not all variables have the same naming structure in the files
citylist<-read.csv(("Z:/Users/Matt/Preparing 1880 Files/City Lists.csv"))
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

##### 1 - Street Grid with Address Ranges - SHAPE FILE ####
ispresent1<-data.frame(City=character())
for(i in 1:1){
  tryCatch({
    library(shapefiles)
    setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
    First<-readOGR(dsn=getwd(), layer=paste(Shortname[i],"_dup", sep=""))
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
    
  #Output New Files for The First Shapefile  
    library(shapefiles)
    setwd(paste("Z:/Users/Matt/Preparing 1880 Files/", LongName[i], "/Street Grid With Ranges/", sep=""))
    writeOGR(First, dsn=getwd(), paste(LongName[i],"_Street_Ranges",sep=""), driver="ESRI Shapefile")
    detach("package:shapefiles", unload=TRUE)
  
    tab1<-as.data.frame(unique(First$City))
    ispresent1<-rbind(ispresent1,tab1)
  }, error=function(e){cat(conditionMessage(e))})
}

  write.csv(ispresent1, "Z:/Users/Matt/Preparing 1880 Files/Complete1.csv")  

######## 2 - ED Boundaries - SHAPE FILE #####
ispresent2<-data.frame(City=character())
for(i in 1:rows){
  tryCatch({
    library(shapefiles)
    setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
    Second<-readOGR(dsn=getwd(), layer=paste(Shortname[i],"_edt",sep=""))
    
    setwd(paste("Z:/Users/Matt/Preparing 1880 Files/", LongName[i], "/ED/", sep=""))
    writeOGR(Second, dsn=getwd(), paste(Shortname[i],"_ED",sep=""), driver="ESRI Shapefile")
    detach("package:shapefiles", unload=TRUE)
  
    tab2<-as.data.frame(unique(Second$NHGISNAM))
    rename(tab2, c('unique(Second$NHGISNAM)'="City"))
    ispresent2<-rbind(ispresent2,tab2)
  }, error=function(e){cat(conditionMessage(e))})
}

  write.csv(ispresent2, "Z:/Users/Matt/Preparing 1880 Files/Complete2.csv")  
  
######## 3 - Off St Geocoded Addresses - POINT FILE #####
  ##### LOOK AT HOUSENUM AND HOUSENUM_N ######
ispresent3<-data.frame(City=character())
for(i in 1:rows){
  tryCatch({
    library(shapefiles)
      setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
      Third<-readOGR(dsn=getwd(), layer=paste(Shortname[i],"_geocode_offst", sep=""))
      Third<-Third[which(Third@data$Status=="M"),]
    #Must detach package after this line because package shapefiles affects how read.dbf works
    detach("package:shapefiles", unload=TRUE)
    
    #Make names lowercase
      names(Third)<-tolower(names(Third))
    #Bring in DBF from On Street to merge type with Off Street
      OnSt<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/", Shortname[i],"_type.dbf",sep=""))
      names(OnSt)<-tolower(names(OnSt))
      OnSt$match_addr<-as.character(OnSt$match_addr)
      OnSt<-OnSt[!(is.na(OnSt$match_addr)),]
      
    #Check if housenum_n exists.  IF only housenum exists then change it to housenum_n as housenum_n is a better version in most files
      ifelse(exists("street_new", where=OnSt), (OnSt$street_new=OnSt$street_new), 
             (OnSt$street_new=OnSt$full_name))    
    
    #Remove duplicate serial ids which happen when an onstreet point is attached to two segments.
      OnSt$unique<-id(OnSt[c("match_addr", "serial")], drop=T)
      OnSt$compareadd<-gsub("[0-9]+[ ]", "", OnSt$match_addr)
      OnSt$newaddress<-as.character(OnSt$newaddress)
      OnSt$newaddress<-tolower(OnSt$newaddress)
      OnSt$compareadd<-as.character(OnSt$compareadd)
      OnSt$compareadd<-tolower(OnSt$compareadd)
      OnSt$street_new<-as.character(OnSt$street_new)
      OnSt$street_new<-tolower(OnSt$street_new)
      
      cnt<-tapply(OnSt$join_count, INDEX=list(OnSt$unique), FUN=sum)
      cnts<-data.frame(unique=names(cnt), dups=cnt)
      OnSt<-merge(x=OnSt, y=cnts, by="unique", all.x=T)

      one<-OnSt[which(OnSt$dups==1 | OnSt$dups==0),]
      more<-OnSt[which(OnSt$dups>=2),]
      
      more$keep<-ifelse(more$compareadd==more$newaddress | more$street_new==more$newaddress, 1, 0)
      more<-more[which(more$keep==1),]
      more<-subset(more, !duplicated(more$serial))
      
      one<-subset(one, !duplicated(one$serial))
      one$keep<-1
      dup<-rbind(one, more)
      dup<-subset(dup, !duplicated(dup$serial))
      
    #Keep variables from OnSt file
      myvars<-c("serial", "type", "match_addr")
      dup<-dup[myvars]
      dup<-rename(dup, c(match_addr="OnStADD"))
      
    #Join Type to Shapefile
      Third<-merge(x=Third, y=dup, by="serial", all.x=T, all.y=F)  
      
    #Check if housenum_n exists.  IF only housenum exists then change it to housenum_n as housenum_n is a better version in most files
      ifelse(exists("housenum_n", where=Third@data), (Third$housenum_n=Third$housenum_n), 
             (Third$housenum_n=Third$housenum))
      
    #Keep Variables
      myvars<-c("arc_city", "arc_state", "match_addr", "housenum_n", "street", "type", "enumdist", "serial", "x", "y")
      Third<-Third[myvars]
      
    #Rename Variables
      Third<-rename(Third, c(arc_city="City", arc_state="State", match_addr="Addr_Match", housenum_n="HNum_Orig",
                             street="St_Orig",type="St_Type", enumdist="ED", serial="Serial", x="X", y="Y"))
    #All Caps
      Third$St_Orig<-toupper(Third$St_Orig)

    #Output New Files for The Third Shapefile  
    library(shapefiles)
      setwd(paste("Z:/Users/Matt/Preparing 1880 Files/", LongName[i], "/Off Street/", sep=""))
      writeOGR(Third, dsn=getwd(), paste(LongName[i],"_OffStreet",sep=""), driver="ESRI Shapefile")
    detach("package:shapefiles", unload=TRUE)
  
    tab3<-as.data.frame(unique(Third$City))
    ispresent3<-rbind(ispresent3,tab3)
  
  #Remove Files to Help with Memory
    rm(Third, OnSt, one, more, dup)
    
  }, error=function(e){cat(conditionMessage(e))})
}
  
  write.csv(ispresent3, "Z:/Users/Matt/Preparing 1880 Files/Complete3.csv")  
  

###### 4 - Match Address with Segment ID, Segment Group, Extended Segment Group, Building Group - MicroData POINT FILE #####
ispresent4<-data.frame(City=character())
for(i in 1:rows){
    tryCatch({
      Type<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/", Shortname[i],"_type.dbf",sep=""))
      Segment<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Shortname[i],Seg[i], sep=""))
      SegGroup<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],SG[i], sep=""))
      Extended<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],Ex[i], sep=""))
      Points<-read.dta13(paste("Z:/Projects/1880Data/MicroData For Publication/",Shortname[i],".dta", sep=""))
      names(Type)<-tolower(names(Type))
      names(Segment)<-tolower(names(Segment))
      names(SegGroup)<-tolower(names(SegGroup))
      names(Extended)<-tolower(names(Extended))
      names(Points)<-tolower(names(Points))
      
    #Make changes to Yi's Files
      ifelse(exists(paste(Seg_ID[i]), where=Extended), 
             (assign("Extended$",Seg_ID[i])),
             (Extended$seg_id=Extended$join_fid))
      
      ifelse(exists(paste(Seg_ID[i]), where=SegGroup), 
             (assign("SegGroup$",Seg_ID[i])),
             (SegGroup$seg_id=SegGroup$join_fid))   
      
  #Bring in Segment Id
      #Create new house number from geocoded data
        Segment$new_housenum<-trim(laply(strsplit(as.character(Segment$match_addr), split = " "), "[", 1))
        Segment$new_housenum<-as.numeric(Segment$new_housenum)
        Segment$housenum_n<-trim(gsub("[?]","", Segment$housenum_n, perl=T))
        Segment$housenum_n<-as.numeric(Segment$housenum_n)
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
    Fourth$serial<-as.numeric(levels(Fourth$serial))[Fourth$serial]
    Fourth<-subset(Fourth, !duplicated(Fourth$serial))
    
  #Clean Up Memory for Efficient Processing
    rm(SegGroup, Extended, Type, Segment)
    
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
      Fourth<-merge(x=Points, y=Fourth, by="serial", all.x=TRUE)

    #Write Output Files
      write.csv(Fourth, paste("Z:/Users/Matt/Preparing 1880 Files/", LongName[i], "/Match Address/", Shortname[i], ".csv", sep=""))  
      #Change characters to factors to work with Stata output
        for (colname in names(Fourth)){
          if (is.character(Fourth[[colname]])){
            Fourth[[colname]]<-as.factor(Fourth[[colname]])
          }
        }
      write.dta(Fourth, paste("Z:/Users/Matt/Preparing 1880 Files/", LongName[i], "/Match Address/", Shortname[i], ".dta", sep=""))
    
    tab4<-as.data.frame(unique(Fourth$incplcus))
    rename(tab4, c('unique(Fourth$incplcus)'="City"))
    
    ispresent4<-rbind(ispresent4,tab4)
  }, error=function(e){cat(conditionMessage(e))})
}

  write.csv(ispresent4, "Z:/Users/Matt/Preparing 1880 Files/Complete4.csv")  
  
#5 - Street Grid No Ranges - Segment, Segment Group, and Extended Segment Group - SHAPE FILE ####
  #NEED OVERLAPPING AS WELL - DONE FOR 10 SOUTHERN CITIES - CREATE PYTHON CODE
ispresent5<-data.frame(City=character())
for(i in 1:rows){
  tryCatch({
    library(shapefiles)
    setwd(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/",sep=""))
    Fifth<-readOGR(dsn=getwd(), layer=paste(Shortname[i],"_segment_project", sep=""))
    #Must detach package after this line because package shapefiles affects how read.dbf works
    detach("package:shapefiles", unload=TRUE)

    #Make field names lower case
      Type<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/", LongName[i],"/", Shortname[i],"_type.dbf",sep=""))
      SegGroup<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],SG[i], sep=""))
      Extended<-read.dbf(paste("Z:/Users/_Exchange/1880 Stuff/AllCities/",LongName[i],"/",Cityname[i],Ex[i], sep=""))
      
      names(Type)<-tolower(names(Type))
      names(SegGroup)<-tolower(names(SegGroup))
      names(Extended)<-tolower(names(Extended))
      names(Fifth)<-tolower(names(Fifth))
      
      #Make changes to Yi's Files
      ifelse(exists(paste(Seg_ID[i]), where=Extended), 
             (assign("Extended$",Seg_ID[i])),
             (Extended$seg_id=Extended$join_fid))
      
      ifelse(exists(paste(Seg_ID[i]), where=SegGroup), 
             (assign("SegGroup$",Seg_ID[i])),
             (SegGroup$seg_id=SegGroup$join_fid))   
      
      #Bring in Segment Id
      #Create new house number from geocoded data
        ifelse(exists("newaddress", where=Fifth@data), (Fifth$newaddress=Fifth$newaddress),
             (Fifth$newaddress=Fifth$street_new))
        Fifth$newaddress<-ifelse(is.na(Fifth$newaddress), as.character(Fifth$street), as.character(Fifth$newaddress))

      #Eliminate Seg ID's of zero.
        Fifth<-subset(Fifth, (eval(parse(text=paste("Fifth$",Seg_ID[i],sep="")))!=0))
      
      #Bring in Segment Group
        Fifth_1<-merge(x=SegGroup[,c(as.character(hex150[i]),"serial")],
                      y=Extended[,c(as.character(hex225[i]),as.character(Seg_ID[i]),"serial")], by="serial", all.x=TRUE)
      #Keep only unique segment ids
        Fifth_1<-subset(Fifth_1, !duplicated(eval(parse(text=paste("Fifth_1$", Seg_ID[i], sep="")))))
      #Add Type
        Fifth_1<-merge(x=Fifth_1, y=Type[,c("serial", "type")], by="serial", all.x=TRUE)
      #Clean Up Memory for Efficient Processing
        rm(SegGroup, Extended, Type) 
      #Remove Serial Variable - Not needed
        myvars<-c("serial")
        Fifth_1<-Fifth_1[!names(Fifth_1) %in% myvars]
      #Merge to Shapefile
        Fifth<-merge(x=Fifth, y=Fifth_1, by=as.character(Seg_ID[i]), all.x=TRUE)        
      #Rename Variables where necessary
        Fifth<-rename(Fifth, c(seg_id="Seg_id", segid="Seg_id", newaddress="Street", type="Type", 
                                hexid150="SegG_id", hex150="SegG_id", hexid225="ExtG_id", hex225="ExtG_id"))
      #Remove segment length variable
        myvars<-c("seg_len", "seglen", "sen_len")
        Fifth<-Fifth[!names(Fifth) %in% myvars]
      
      #Uppercase Street and Type
        Fifth$Street<-toupper(Fifth$Street)
        Fifth$Type<-toupper(Fifth$Type)  
        
      #Output New Files for The First Shapefile  
        library(shapefiles)
        setwd(paste("Z:/Users/Matt/Preparing 1880 Files/", LongName[i], "/Street Grid Without Ranges/", sep=""))
        writeOGR(Fifth, dsn=getwd(), paste(LongName[i],"_StreetGrid",sep=""), driver="ESRI Shapefile")
        detach("package:shapefiles", unload=TRUE)
        
      tab5<-as.data.frame(unique(Cityname[i]))
      rename(tab5, c('unique(Cityname[i])'="City"))
      ispresent5<-rbind(ispresent5,tab5)
  }, error=function(e){cat(conditionMessage(e))})
}

  write.csv(ispresent5, "Z:/Users/Matt/Preparing 1880 Files/Complete5.csv")  
  
#Bring In Libraries
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
  library(data.table)

#Bring in New Student Cleaned File
  m<-read.csv("Z:/Users/Matt/SanAntonio/Micro Data Files/SanAntonioTX_StudAuto_1930.csv")
  
  vars<-names(kids30)
  
  kids<-m[vars]

#Bring in Both Files
  kids30<-read.csv("Z:/Users/Matt/SanAntonio/Micro Data Files/kids30.csv")
  kids40<-read.csv("Z:/Users/Matt/SanAntonio/kids40.csv")
  

#Try to Match 5 year old black kids;
  five30<-subset(kids30, (kids30$age30==5 & kids30$black==1))
  five40<-subset(kids40, ((kids40$age40==15 | kids40$age40==14 | kids40$age40==16) & kids40$black40==1))
  
  
  
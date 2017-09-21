sa<-read.csv("Z:/Users/Matt/SanAntonio/Data Files/SanAntonioTX_AutoCleaned30.csv")
names(sa)
View(sa[124:153])

names(sa)<-tolower(names(sa))

vars<-c("overall_match", "ed", "type", "block","hn")
sa30<-sa[vars]

sa30<-rename(sa30, c(block="Mblk", overall_match="fullname"))
sa30$state<-"TX"
sa30$city<-"San Antonio"
sa30$address<-paste(sa30$hn, sa30$fullname, sep=" ")
names(sa30)
View(sa30)

write.csv(sa30, "Z:/Users/Matt/SanAntonio/Data Files/Add_30.csv")

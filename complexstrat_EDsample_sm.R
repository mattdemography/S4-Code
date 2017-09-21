##This version of the scripts draws proportionally larger samples in smaller EDs, similar to Long-Form

rm(list = ls())
gc()
library(maptools)
library(rgdal)
library(data.table)
library(Hmisc)
library(dtplyr)
library(sampling)
library(survey)

setwd("Z:/Projects/Preparing 1880 Files")

baltdata <- fread("Baltimore/Match Address/Baltimore.csv")
baltdata$english <- 0
baltdata$german <- 0
baltdata$irish <- 0
# baltdata$asian <- 0

baltdata$enumdist <- as.numeric(baltdata$enumdist)
baltdata$english<-ifelse(substr(baltdata$fbp,1,3)=="410" | substr(baltdata$mbp,1,3) == "410" | substr(baltdata$bp,1,3)=="410",1,0) 
baltdata$german<-ifelse(substr(baltdata$fbp,1,3)=="453" | substr(baltdata$mbp,1,3) == "453" | substr(baltdata$bp,1,3)=="453",1,0) 
baltdata$irish<-ifelse(substr(baltdata$fbp,1,3)=="414" | substr(baltdata$mbp,1,3) == "414" | substr(baltdata$bp,1,3)=="414",1,0)
# baltdata$asian<-ifelse(substr(baltdata$fbp,1,2)=="50" | substr(baltdata$mbp,1,2) == "50" | substr(baltdata$bp,1,2)=="50",1,0)
# baltdata$negro <- ifelse(baltdata$race==200 | baltdata$race==210,1,0)
# baltdata$sei <- baltdata$seius
# baltdata$head <- ifelse(baltdata$relate==101,1,0)
baltdata <- subset(baltdata,select=c(V1,serial,enumdist,House_Number,Street,Type,Side, Segment_id,Building_id,SegGroup_id,
                                     ExtGroup_id,head,irish,german,english,negro,sei))

baltdata.head <- baltdata[baltdata$head==1,]
names(baltdata.head) <- c("V1","serial","enumdist","House_Number","Street","Type","Side","Segment_id","Building_id","SegGroup_id", 
                          "ExtGroup_id","head","hirish","hgerman","henglish","hnegro","hsei")

# baltdata.head.unique <- baltdata.head[,c(2,13:17),with=FALSE]
# baltdata.head <- merge(baltdata,baltdata.head.unique,by="serial") ##This is what you do if you want head information attached to everyone
# rm(baltdata.head.unique,baltdata)
gc()

##This is roughly in line with what the Long-Form Census did. https://www.census.gov/history/pdf/Census2000v1.pdf p. 107
## and https://www.census.gov/prod/cen2000/doc/sf3chap8.pdf 8-3 to 8-4
## 1 in 6 sample for under 2000 housing units, 1 in 8 for over

coefs.ed <- list()
res.ed <- list()
fits.ed <- list()
edcor <- list()

coefs.sg2 <- list()
res.sg2 <- list()
fits.sg2 <- list()
sg2cor <- list()

coefs.sg1 <- list()
res.sg1 <- list()
fits.sg1 <- list()
sg1cor <- list()



baltdata.head.order <- baltdata.head[order(baltdata.head$Segment_id),]
baltdata.head.order <- baltdata.head.order[!is.na(baltdata.head.order$Segment_id),]
enumdist.tabs <- as.data.frame(table(baltdata.head.order$enumdist)) ##sample AT segid BASED ON enumdist pop
names(enumdist.tabs) <- c("enumdist","enumdist_pop") ##rename variables which table loses
enumdist.tabs$enumdist <- as.numeric(as.character(enumdist.tabs$enumdist)) #de-factor enumdist
baltdata.head.order <- merge(baltdata.head.order,enumdist.tabs) 
baltdata.head.order <- baltdata.head.order[order(baltdata.head.order$enumdist),]
stratum.counts <- as.data.frame(table(baltdata.head.order$enumdist)) ##Still not sure if this is the right way to go about it. (Sample @ segment v ED)
names(stratum.counts) <- c("enumdist","enum_pop")
stratum.counts$enumdist <- as.numeric(as.character(stratum.counts$enumdist))
ed_counts_to_join <- baltdata.head.order[,c(1,18)]
stratum.counts <- left_join(stratum.counts,ed_counts_to_join,by="enumdist")
stratum.counts <- stratum.counts[order(stratum.counts$enumdist,stratum.counts$enumdist_pop),]
stratum.counts.to.merge <- stratum.counts[!duplicated(stratum.counts$enumdist),]
stratum.counts.to.merge <- stratum.counts.to.merge[order(stratum.counts.to.merge$enumdist),]
sample.sizes <- stratum.counts.to.merge$enumdist_pop
for (i in 1:length(stratum.counts.to.merge$enumdist_pop)) { ######work on this!!!
  if (stratum.counts.to.merge[i,3] >= 1727) {   ##see the acs script for where this # comes from, based on ACS empirical distribution
    sample.sizes[i] = ceiling((1/20)*sample.sizes[i])  ##Note that these are (probably) not the right fractions
  } else {
    sample.sizes[i] = ceiling((1/18)*sample.sizes[i])
  } 
}




for (i in 1:10000) {
  if(i < 10001) {
    complex.stratify.by.seg.15 <- strata(baltdata.head.order,stratanames = "enumdist",size=sample.sizes,method="srswor")
    complex.strata.seg.15 <- getdata(baltdata.head.order,complex.stratify.by.seg.15)
    complex.strata.seg.15$calcweights <- 1/complex.strata.seg.15$Prob
    calcweights <- complex.strata.seg.15$weights
    sampledata.strata.ed.15 <- complex.strata.seg.15[,.(weighted.mean(hirish,calcweights),weighted.mean(hgerman,calcweights),weighted.mean(henglish,calcweights),weighted.mean(hnegro,calcweights),weighted.mean(hsei,calcweights,na.rm = TRUE)),by=enumdist]
    names(sampledata.strata.ed.15) <- c("enumdist","edirish","edgerman","edenglish","ednegro","edsei")
    toedreg.15 <- sampledata.strata.ed.15[!duplicated(sampledata.strata.ed.15), ]
    edcor[[i]] <- rcorr(as.matrix(toedreg.15))
    # fpc <- rep(0.15,length(toedreg$enumdist))
    edsdes.15 <- svydesign(id=~1,data=toedreg.15)
    edreg.15 <- svyglm(edsei ~ edirish + edgerman + ednegro, data=toedreg.15,design=edsdes.15)
    coefs.ed[[i]] <- edreg.15$coefficients
    res.ed[[i]] <- as.vector(edreg.15$residuals)
    fits.ed[[i]] <- as.vector(edreg.15$fitted.values)
    rm(sampledata.strata.ed.15,toedreg.15,edreg.15)
    gc()
    
    # 
    # sampledata.strata.sg1.15 <- complex.strata.seg.15[,.(weighted.mean(hirish,calcweights),weighted.mean(hgerman,calcweights),weighted.mean(henglish,calcweights),weighted.mean(hnegro,calcweights),weighted.mean(hsei,calcweights,na.rm = TRUE)),by=SegGroup_id]
    # names(sampledata.strata.sg1.15) <- c("SegGroup_id","sg1irish","sg1german","sg1english","sg1negro","sg1sei")
    # tosg1reg.15 <- sampledata.strata.sg1.15[!duplicated(sampledata.strata.sg1.15), ]
    # sg1cor[[i]] <- rcorr(as.matrix(tosg1reg.15))
    # # fpc <- rep(0.15,length(tosg1reg$SegGroup_id))
    # sg1des.15 <- svydesign(id=~1,data=tosg1reg.15)
    # sg1reg.15 <- svyglm(sg1sei ~ sg1irish + sg1german + sg1negro, data=tosg1reg.15,design=sg1des.15)
    # coefs.sg1[[i]] <- sg1reg.15$coefficients
    # res.sg1[[i]] <- as.vector(sg1reg.15$residuals)
    # fits.sg1[[i]] <- as.vector(sg1reg.15$fitted.values)
    # rm(sampledata.strata.sg1.15,tosg1reg.15,sg1reg.15)
    # gc()
    # 
    # 
    # 
    # sampledata.strata.sg2.15 <- complex.strata.seg.15[,.(weighted.mean(hirish,calcweights),weighted.mean(hgerman,calcweights),weighted.mean(henglish,calcweights),weighted.mean(hnegro,calcweights),weighted.mean(hsei,calcweights,na.rm = TRUE)),by=ExtGroup_id]
    # names(sampledata.strata.sg2.15) <- c("ExtGroup_id","sg2irish","sg2german","sg2english","sg2negro","sg2sei")
    # tosg2reg.15 <- sampledata.strata.sg2.15[!duplicated(sampledata.strata.sg2.15), ]
    # sg2cor[[i]] <- rcorr(as.matrix(tosg2reg.15))
    # # fpc <- rep(0.15,length(tosg2reg$ExtGroup_id))
    # sg2des.15 <- svydesign(id=~1,data=tosg2reg.15)
    # sg2reg.15 <- svyglm(sg2sei ~ sg2irish + sg2german + sg2negro, data=tosg2reg.15,design=sg2des.15)
    # 
    # coefs.sg2[[i]] <- sg2reg.15$coefficients
    # res.sg2[[i]] <- as.vector(sg2reg.15$residuals)
    # fits.sg2[[i]] <- as.vector(sg2reg.15$fitted.values)
    # rm(sampledata.strata.sg2.15,tosg2reg.15,sg2reg.15)
    # gc()
    # 
  }
}



save(edcor,file="corr_ed_cxstr2sm_10k.Rdata")
save(coefs.ed,file="coefs_ed_cxstr2sm_10k.Rdata")
save(res.ed,file="res_ed_cxstr2sm_10k.Rdata")
save(fits.ed,file="fits_ed_cxstr2sm_10k.Rdata")
rm(coefs.ed,res.ed,fits.ed)
save(sg2cor,file="corr_sg2_cxstr_10k.Rdata")
save(coefs.sg2,file="coefs_sg2_cxstr_10k.Rdata")
save(res.sg2,file="res_sg2_cxstr_10k.Rdata")
save(fits.sg2,file="fits_sg2_cxstr_10k.Rdata")
rm(coefs.sg2,res.sg2,fits.sg2)
save(sg1cor,file="corr_sg1_cxstr_10k.Rdata")
save(coefs.sg1,file="coefs_sg1_cxstr_10k.Rdata")
save(res.sg1,file="res_sg1_cxstr_10k.Rdata")
save(fits.sg1,file="fits_sg1_cxstr_10k.Rdata")
rm(coefs.sg1,res.sg1,fits.sg1)
gc()


load("coefs_ed_cxstr_10k.Rdata")
load("res_ed_cxstr_10k.Rdata")
load("fits_ed_cxstr_10k.Rdata")
load("coefs_sg2_cxstr_10k.Rdata")
load("res_sg2_cxstr_10k.Rdata")
load("fits_sg2_cxstr_10k.Rdata")
load("coefs_sg1_cxstr_10k.Rdata")
load("res_sg1_cxstr_10k.Rdata")
load("fits_sg1_cxstr_10k.Rdata")

baltdata.head.order.edreg <- aggregate(cbind(hirish,hgerman,henglish,hnegro,hsei) ~ enumdist,data=baltdata.head.order,FUN="mean")
names(baltdata.head.order.edreg) <- c("enumdist","edirish","edgerman","edenglish","ednegro","edsei")

balt.edreg.fulldata <- svyglm(edsei ~ edirish+edgerman+ednegro,des=edsdes.15,data=baltdata.head.order.edreg)                                       

##Intercepts
hist(sapply(coefs.sg1,"[[","(Intercept)"))
hist(sapply(coefs.sg2,"[[","(Intercept)"))
hist(sapply(coefs.ed,"[[","(Intercept)"))

#Irish
hist(sapply(coefs.sg1,"[[","sg1irish"))
hist(sapply(coefs.sg2,"[[","sg2irish"))
hist(sapply(coefs.ed,"[[","edirish"))


#German
hist(sapply(coefs.sg1,"[[","sg1german"))
hist(sapply(coefs.sg2,"[[","sg2german"))
hist(sapply(coefs.ed,"[[","edgerman"))

#Black
hist(sapply(coefs.sg1,"[[","sg1negro"))
hist(sapply(coefs.sg2,"[[","sg2negro"))
hist(sapply(coefs.ed,"[[","ednegro"))



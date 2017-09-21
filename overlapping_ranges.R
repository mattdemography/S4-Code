##detect overlapping L/R ranges by street name
#Testing with Philadelphiast_dup
library(stringr)
library(dplyr)
library(foreign)
library(rgeos)
library(rgdal)
library(maptools)
library(ggmap)
library(spdep)
library(tigris)

#list of cities
cities <- list.files("S:/Users/_Exchange/1880 Stuff/AllCities")
cities <- cities[!(1:42 %in% c(17,41))]
cities[26] <- "NewHaven"
cities[27] <- "NewOrleans"

for(z in 25:25){

tab <- read.dbf(paste("S:/Projects/Preparing 1880 Files/Ben Results/", cities[z], "/", cities[z], "_Street_Ranges.dbf", sep = ""), as.is = T)

tab$l_f_range <- as.numeric(tab$l_f_range)
tab$l_t_range <- as.numeric(tab$l_t_range)
tab$r_f_range <- as.numeric(tab$r_f_range)
tab$r_t_range <- as.numeric(tab$r_t_range)

tab$l_f_range[is.na(tab$l_f_range)] <- 0
tab$l_t_range[is.na(tab$l_t_range)] <- 0
tab$r_f_range[is.na(tab$r_f_range)] <- 0
tab$r_t_range[is.na(tab$r_t_range)] <- 0

tab$lr_over <- 0
tab$seg_over <- 0

tab$totalmatch <- 0
tab$totalmatch[duplicated(tab[,c("Street","l_f_range", "l_t_range", "r_f_range", "r_t_range")])] <- 1

for(a in 1:nrow(tab)){
  lt <- max(tab$l_f_range[a], tab$l_t_range[a])
  lf <- min(tab$l_f_range[a], tab$l_t_range[a])
  rt <- max(tab$r_f_range[a], tab$r_t_range[a])
  rf <- min(tab$r_f_range[a], tab$r_t_range[a])
  l.ranges <- seq(from = lf, to = lt, by = 2)
  r.ranges <- seq(from = rf, to = rt, by = 2)
  rows <- 1:nrow(tab)
  rows <- rows[tab$Street == tab$Street[a]]
  rows <- rows[rows != a]
  rows <- rows[!is.na(rows)]
  lrtest <- l.ranges %in% r.ranges
  ltest <- l.ranges %in% c(l.ranges[rows])
  rtest <- r.ranges %in% c(r.ranges[rows])
  if(TRUE %in% lrtest){
    tab$lr_over[a] <- 1
  } else if(TRUE %in% ltest){
    tab$seg_over[a] <- 1
  } else if(TRUE %in% rtest){
    tab$seg_over[a] <- 1
  } else if(TRUE %in% rtest){
    tab$seg_over[a] <- 1
  }
}


#get rid of full ranges with only 0
for(a in 1:nrow(tab)){
  if(tab$l_f_range[a] == 0 &
     tab$l_t_range[a] == 0 &
     tab$r_f_range[a] == 0 &
     tab$r_t_range[a] == 0){
    #tab$l_f_range[a] <- NA
    #tab$l_t_range[a] <- NA
    #tab$r_f_range[a] <- NA
    #tab$r_t_range[a] <- NA
    tab$lr_over[a] <- 0
    tab$seg_over[a] <- 0
    tab$totalmatch[a] <- 0
  } else if(tab$l_f_range[a] == 9999 &
            tab$l_t_range[a] == 9999 &
            tab$r_f_range[a] == 9999 &
            tab$r_t_range[a] == 9999){
    #tab$l_f_range[a] <- NA
    #tab$l_t_range[a] <- NA
    #tab$r_f_range[a] <- NA
    #tab$r_t_range[a] <- NA
    tab$lr_over[a] <- 0
    tab$seg_over[a] <- 0
    tab$totalmatch[a] <- 0
  }
}

#export updated dbf
write.dbf(tab, paste("S:/Projects/Preparing 1880 Files/Ben Results/", cities[z], "/", cities[z], "_Street_Ranges.dbf", sep = ""))

}


summary(as.factor(tab$lr_over))
summary(as.factor(tab$seg_over))
summary(as.factor(tab$totalmatch))

lrover <- filter(tab, lr_over==1)
segrover <- filter(tab, seg_over==1) %>%
  arrange(street)
matches <- filter(tab, totalmatch==1) %>%
  arrange(Street)


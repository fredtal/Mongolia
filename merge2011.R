# Merge 2011 data

# Define directory
datadir <- "~/Dropbox/Rutgers-Dropbox/Mongolia data merge project/2011/csvs"

# Read collection data (283 obs, 29 vars)
collection <- read.csv(paste(datadir, "2011_collection_data.csv", sep="/"))
colnames(collection) <- tolower(colnames(collection))

# Read Mendee morphometric data (492 obs, 42 vars)
Mendee <- read.csv(paste(datadir, "2011_Mendee_data.csv", sep="/"))
colnames(Mendee) <- tolower(colnames(Mendee))

# Read isotope data (74 obs, 7 vars)
isotopes <- read.csv(paste(datadir, "2011_isotope_data.csv", sep="/"))
colnames(isotopes) <- tolower(colnames(isotopes))

# Read tagging data (12 obs, 13 vars)
tagging <- read.csv(paste(datadir, "2011_tagging_data.csv", sep="/"))
colnames(tagging) <- tolower(colnames(tagging))

# Merge individual data with morphometric data
# 579 obs, 70 vars
data1 <- merge(collection, Mendee, by.x="sample_id", all=TRUE)

# ------------- #

#water body check
flagwb <- as.character(data1$water_body) != as.character(data1$water_body.m)
sum(flagwb==T, na.rm=T) #28 mismatches
sum(flagwb==F, na.rm=T) #175 matches

#location check
flagloc <- as.character(data1$location) != as.character(data1$location.m)
sum(flagloc==T, na.rm=T) #28 mismatches
sum(flagloc==F, na.rm=T) #147 matches
flaggedloc <- subset(data1, flagloc, select=c(sample_id, #date, 
                                            #field_id, #field_id.m,
                                            #tl_mm, l, fl_mm, ls #, 
                                            #water_body, water_body.m, 
                                              location, location.m
))
flaggedloc
# ******* 
# there are three location mismatches
# G91: we say Dalbai (and GPS confirms), Mendee says Wood Island, Mendee's GPS says Turag
# G199: we say Turag (and GPS confirms), Mendee says Horoo, Mendee's GPS says Wood Island
# G200: we say Turag (and GPS confirms), Mendee says Horoo, Mendee's GPS says Wood Island
# I am not sure what to do.  I think we should maybe remove the locations completely.
# ******* 

# ******* 
# Mendee's GPS values for Turag don't make sense.
# Mendee's GPS values for Horoo map to Wood Island.
# Mendee's GPS values for Toilogt look like a pelagic site near Hachim.
# Mendee's GPS values for Wood Island map to Turag.
# ******* 


#species check
flagsp <- as.character(data1$field_id) != as.character(data1$field_id.m)
sum(flagsp==T, na.rm=T) #63 mismatches: all grayling names
sum(flagsp==F, na.rm=T) #112 matches
flaggedsp <- subset(data1, flagsp, select=c(sample_id, date, 
                                        field_id, field_id.m
                                        #tl_mm, l, fl_mm, ls #, 
                                        #water_body, water_body.m, location, location.m
))
flaggedsp
# ******* 
# all field_id mismatches are grayling
# and should be set to Mendee's field_id.m, and a comment noted about it.
# ******* 

#gear check
flaggr <- as.character(data1$gear) != as.character(data1$gear.m)
sum(flaggr==T, na.rm=T) #71 mismatches: all grayling names
sum(flaggr==F, na.rm=T) #104 matches
flaggedgr <- subset(data1, flaggr, select=c(sample_id, date, 
                                            field_id, #field_id.m
                                            gear, gear.m
                                            #tl_mm, l, fl_mm, ls #, 
                                            #water_body, water_body.m, location, location.m
))
flaggedgr
# ******* 
# there are 25 meaningful gear mismatches
# G91: we say gillnetH, Mendee says gillnetV
# this conflict corresponds to the location mismatch
#
# the others are all just gear mismatches for Phoxinus
# I think they don't really matter
# (11 dipnet/minnow trap)
# (13 seine/electrofishing)
# ******* 


#date check
flagd <- as.character(data1$date) != as.character(data1$date.m)
sum(flagd==T, na.rm=T) #175 mismatches
sum(flagd==F, na.rm=T) #0 matches
flaggedd <- subset(data1, flagd, select=c(sample_id, date, date.m,
                                            field_id#, #field_id.m
                                            #gear, gear.m
                                            #tl_mm, l, fl_mm, ls #, 
                                            #water_body, water_body.m, location, location.m
))
flaggedd
# ******* 
# I think all date conflicts should go to Mendee's dates
# because Talia's dates are suspect.
# ******* 


#TL check
flagtl <- data1$tl_mm != data1$l
sum(flagtl==T, na.rm=T) #1 mismatch
sum(flagtl==F, na.rm=T) #152 matches
flaggedtl <- subset(data1, flagtl, select=c(sample_id, date, 
                                                   field_id, #field_id.m
                                                   tl_mm, l, fl_mm, ls #, 
                                                   #water_body, water_body.m, location, location.m
))
flaggedtl
# ******* 
# one tl mismatch is 1mm.  set it to mendee's.  
# ******* 

#FL check
flagfl <- data1$fl_mm != data1$ls
sum(flagfl==T, na.rm=T) #1 mismatch
sum(flagfl==F, na.rm=T) #96 matches
flaggedfl <- subset(data1, flagfl, select=c(sample_id, date, 
                                            field_id, #field_id.m
                                            tl_mm, l, fl_mm, ls #, 
                                            #water_body, water_body.m, location, location.m
))
flaggedfl
# ******* 
# one fl mismatch is 1mm.  set it to mendee's.  
# ******* 

#weight check
flagwt <- data1$weight_g != data1$q
sum(flagwt==T, na.rm=T) #13 mismatch
sum(flagwt==F, na.rm=T) #50 matches
flaggedwt <- subset(data1, flagwt, select=c(sample_id, #date, 
                                            field_id, #field_id.m
                                            tl_mm, l, fl_mm, ls, 
                                            weight_g, q
                                            #water_body, water_body.m, location, location.m
))
flaggedwt
# ******* 
# 3 wt mismatches. 
# one is a typing error (79.2 vs. 49.2)
# otherwise i think the heavier measurement is probably correct.  
# ******* 



#sex - NA
#TL - done
#FL - done
#SL - NA
#Weight - done
#Water body - done
#Location - done
#LAT_DD - I think NA
#LONG_DD  - I think NA
#gear - done
#date - done
#species - done
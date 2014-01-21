# Merge 2013 data

# Define directory
datadir <- "~cfree/Dropbox/Mongolia data merge project/2013"

# Read formatted individual data
data <- read.csv(paste(datadir, "2013_mongolia_data_cmf.csv", sep="/"))

# Read formatted Mendee morphometric data
morphs <- read.csv(paste(datadir, "2013_mendee_data_cmf.csv", sep="/"))

# Read formatted Talia isotope data
isotopes <- read.csv(paste(datadir, "2013_isotope_data_cmf.csv", sep="/"))

#Talia just made some changes!
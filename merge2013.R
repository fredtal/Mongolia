# Merge 2013 data

# Define directory
datadir <- "~cfree/Dropbox/Mongolia data merge project/2013"

# Read formatted individual data (401 obs, 23 vars)
data <- read.csv(paste(datadir, "2013_mongolia_data_cmf.csv", sep="/"))
colnames(data) <- tolower(colnames(data))

# Read formatted Mendee morphometric data (229 obs, 51 vars)
morphs <- read.csv(paste(datadir, "2013_mendee_data_cmf.csv", sep="/"))
colnames(morphs) <- tolower(colnames(morphs))

# Read formatted Talia isotope data (129 obs, 8 vars)
isotopes <- read.csv(paste(datadir, "2013_isotope_data_cmf.csv", sep="/"))
colnames(isotopes) <- tolower(colnames(isotopes))

# Merge individual data with morphometric data
# One individual in Mendee's data is not in our data
# so the the samples increase from 401 to 402 individuals
data1 <- merge(data, morphs, by.x="sampleid", by.y="new_id", all=TRUE)

# Download Retrosheet play-by-play data

######### INSTRUCTIONS #########
# Start here: https://baseballwithr.wordpress.com/2014/02/10/downloading-retrosheet-data-and-runs-expectancy/
######### INSTRUCTIONS #########

setwd("~/editing/mlb_pbp_data/")

require(devtools)
require(readr)

source_gist(8892981) # Downloads parse.retrosheet2.pbp function

# Data fields
fields <- read_csv("./download.folder/unzipped/fields.csv")
headers <- fields$Header

seasons <- rep(c(1925, 1927, 1930:2014)) # Seasons to download

for (s in seasons){
  parse.retrosheet2.pbp(s)
  data <- read_csv(paste0("./download.folder/unzipped/all", s, ".csv"), col_names=F)
  print(paste0("Season ", s, " downloaded."))
  names(data) <- headers
  data$season <- s
  write_csv(data, paste0("pbp_data/pbp_", s, ".csv"))
  print(paste0("Season ", s, " written."))
  gc()
}



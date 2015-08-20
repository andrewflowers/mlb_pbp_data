# Merge MLB season data 

setwd("~/editing/mlb_pbp_data/")

require(readr)

pbp_all_seasons <- data.frame()

season_files <- list.files("./data")

for (s in season_files){
  one_season <- read_csv(paste0(getwd(),"/data/", s))  
  pbp_all_seasons <- rbind(pbp_all_seasons, one_season)
  gc()
  print(paste0(s, " uploaded"))
}

write_csv(pbp_all_seasons, "pbp_all_seasons.csv")







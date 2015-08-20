# Tally "quizzes" and "blown quizzes" for pitchers

setwd("~/editing/mlb_pbp_data/")

require(readr)
require(dplyr)

# Read in data for the future
# pbp_all_seasons <- read_csv("pbp_all_seasons.csv")

## Analysis
length(unique(pbp_all_seasons$PIT_ID)) # 6643 unique pitchers

# Examine only plays from 6th inning or later, separated into home and away sequences
home_pitch_6inn <- pbp_all_seasons %>% filter(INN_CT>=6, BAT_HOME_ID==0)
away_pitch_6inn <- pbp_all_seasons %>% filter(INN_CT>=6, BAT_HOME_ID==1)

# Make flag when new pitch enters, then filter for only 7th inning or later plays
home_pitch_chng_7inn <- home_pitch_6inn %>% 
  group_by(GAME_ID) %>% 
  mutate(pit_chng=ifelse(PIT_ID!=lag(PIT_ID), TRUE, FALSE)) %>% 
  ungroup() %>% 
  filter(INN_CT>=7)  

# Filter by score: pitcher's team leading by no more than 2 runs, or tied, or tyring run is at-bat 
home_pitch_chng_7inn <- home_pitch_chng_7inn %>% 
  mutate(home_lead=HOME_SCORE_CT- AWAY_SCORE_CT,
         runners_on_base=sum(BASE1_RUN_ID=="", BASE2_RUN_ID=="", BASE3_RUN_ID[.]==""))

############ THIS IS INCOMPLETE ############



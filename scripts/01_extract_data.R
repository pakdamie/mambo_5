library(dplyr)
source("src/wrangle_ss_names.R")

###We wrangle the different text files of the Social Security name into
###a single data.frame and further subset it to only include the
###names that appear in Mambo Number 5. These are saved as csv outputs.

names_Mambo_5 <- c(
  "Angela",
  "Pamela",
  "Sandra",
  "Rita",
  "Monica",
  "Erica",
  "Tina",
  "Mary",
  "Jessica"
)

###Full name df
full_name_df <- wrangle_ss_names("names/")
write.csv(full_name_df, "output/full_name_df.csv")

###Mambo 5 name df
fem_name_df <- subset(full_name_df, full_name_df$Sex == "F")

fem_name_df <- fem_name_df %>%
  group_by(Year) %>%
  mutate(Prop = Occurrence / sum(Occurrence))

mambo_5_name_df <- subset(fem_name_df, fem_name_df$Name %in% names_Mambo_5)

mambo_5_name_df$Sex[mambo_5_name_df$Sex == "F"] <- "Female"

if (!dir.exists("output")) {
  dir.create("output")
}

write.csv(mambo_5_name_df, "output/mambo_5_name_df.csv")

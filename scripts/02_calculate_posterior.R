mambo_5_name_df <- read.csv("output/mambo_5_name_df.csv")
mambo_5_PD_df <- calculate_posterior(mambo_5_name_df)






plot(mambo_5_PD_df, type = 'b', xlab = "Release Year", ylab = "PD that I haven't divided yet" )
abline(v = 1999, col = 'red')



mambo_5_name_df <- read.csv("output/mambo_5_name_df.csv")
mambo_5_PD_df <- calculate_posterior(mambo_5_name_df)
mambo_5_PD_df$normalized <- mambo_5_PD_df$posterior_distribution/(sum(mambo_5_PD_df$posterior_distribution))


max_PD <- mambo_5_PD_df[which.max(mambo_5_PD_df$posterior_distribution),]

ggplot(mambo_5_PD_df, aes( x= release_years, y = normalized)) + 
  geom_point(size = 1) + 
  geom_line(size = 0.7) + 
  xlab("Release years") + 
  ylab("Posterior distribution of release years") + 
  geom_vline(xintercept = 1999, color = 'red')+
  geom_vline(xintercept = max_PD$release_years, color = 'green' ) + 
  theme_classic()





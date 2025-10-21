library(ggplot2)

###Calculate the posterior distribution
mambo_5_name_df <- read.csv("output/mambo_5_name_df.csv")
mambo_5_PD_df <- calculate_posterior(mambo_5_name_df)
mambo_5_PD_df$normalized <- mambo_5_PD_df$posterior_distribution /
  (sum(mambo_5_PD_df$posterior_distribution))

###Addendum 
max_PD <- mambo_5_PD_df[which.max(mambo_5_PD_df$posterior_distribution),]
max_PD_interval <- calculate_credible_interval(mambo_5_PD_df)

mambo_5_PD_df_sub <- subset(mambo_5_PD_df, mambo_5_PD_df$release_years %in% 
  seq(max_PD_interval$lower,max_PD_interval$upper))


mambo_5_PD_GG <- ggplot(mambo_5_PD_df, aes(x = release_years, y = normalized)) +
  geom_line(size = 0.5) +
  xlab("Release years") +
  ylab("Density") +
  ggtitle("When was Mambo Number 5 released?") + 
  annotate(
    "point",
    x = max_PD$release_years,
    y = max_PD$normalized,
    size = 2.5
  ) +
  geom_vline(
    xintercept = max_PD$release_years,
    color = 'black',
    linetype = 5,
    alpha = 0.5
  ) +
  geom_area(data =mambo_5_PD_df_sub ,
    aes(x=release_years, y = normalized), fill = '#f6941f', alpha = 0.25) + 
  theme_classic() +
  theme(
    axis.text = element_text(size = 12, color = 'black'),
    axis.title = element_text(size = 13)
  )

ggsave(mambo_5_PD_GG, file = "Figure/mambo_5_PD_GG.png", units = "in", 
height = 5, width = 5)

###Calculate the posterior distribution

mambo_5_name_df <- read.csv("output/mambo_5_name_df.csv")
mambo_5_PD_df <- calculate_posterior(mambo_5_name_df)
mambo_5_PD_df$normalized <- mambo_5_PD_df$posterior_distribution /
  (sum(mambo_5_PD_df$posterior_distribution))


max_PD <- mambo_5_PD_df[which.max(mambo_5_PD_df$posterior_distribution), ]







ggplot(mambo_5_PD_df, aes(x = release_years, y = normalized)) +
  geom_line(size = 0.5) +
  xlab("Release years") +
  ylab("Density") +
  ggtitle("When was Mambo Number 5 released?")
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
  theme_classic() +
  theme(
    axis.text = element_text(size = 12, color = 'black'),
    axis.title = element_text(size = 13)
  )

ggsave()
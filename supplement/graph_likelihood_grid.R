library(reshape2)
library(ggplot2)
library(viridis)

###used for making a joint likelihood grid conditioned on 
###age of the women as well as the range of release years.

release_years <- 1980:2010
ages <- 18:35
mambo_5_name_df <- read.csv("output/mambo_5_name_df.csv")


results <- matrix(0, nrow = length(ages), ncol = length(release_years))
min_age <- min(ages)
max_age <- max(ages)

for (year in seq_along(release_years)) {
  #Given our assumption of the year when the song was released, what
  # are the possible years we should be looking at based on our range of ages?
  year_interest = release_years[year]
  birth_years = (year_interest - max_age):(year_interest - min_age)
  names_df_interest <- mambo_5_name_df[
    mambo_5_name_df$Year %in% birth_years,
    ,
    drop = FALSE
  ]

  # Compute joint probabilities where group size == 9
  joint_probs <- tapply(
    names_df_interest$Prop,
    names_df_interest$Year,
    function(x) {
      if (length(x) == 9) prod(x) else NA
    }
  )

  results[, year] <- joint_probs
}

likelihood_grid_df <- data.frame(results)
colnames(likelihood_grid_df) <- release_years
likelihood_grid_df$ages <- ages

likelihood_grid_df_melt <- melt(likelihood_grid_df, id.vars = "ages")

ggplot(likelihood_grid_df_melt, aes(x = variable, y = ages)) +
  geom_tile(aes(fill = value), color = 'black') +
  scale_fill_viridis() +
  xlab("Assumed release year") +
  ylab("Assumed ages") +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_equal() +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5),
    legend.position = 'none'
  )

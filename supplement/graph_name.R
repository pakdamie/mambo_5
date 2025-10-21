library(ggplot2)

mambo_5_name_df <- read.csv("output/mambo_5_name_df.csv")

graph_prop_name <- function(gg_df){
  GG <- ggplot(gg_df, aes(x = Year, y= Occurrence))+ 
    geom_bar(stat = 'identity') + 
    ggtitle(unique(gg_df$Name))+
    theme_classic() + 
    theme(axis.text = element_text(size = 12),
          axis.title = element_text(size = 14))
  
  ggsave(GG, file = paste0("Figure/", unique(gg_df$Name), ".png"))
  
}

Name_Split<- split(mambo_5_name_df ,mambo_5_name_df $Name)

lapply(Name_Split, function(x) graph_prop_name(x))

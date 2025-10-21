#' Calculate the likelihood given the release years and the assumed ages
#'
#' @param df (data.frame) The girl name popularity data.frame
#' @param release_years (vector) our belief of when the songs were released (1980-2005)
#' @param ages (vector) assumption of the women's ages (default: 21-40)
#'
#' @returns The marginalized vector that will then be used to calcualte the posterior
#'
#' @export
#' @examples
calculate_likelihood <- function(name_df, release_years, ages) {
  
  results <- numeric(length(release_years))
  min_age <- min(ages)
  max_age <-  max(ages)

  for (year in seq_along(release_years)) {
    
    #Given our assumption of the year when the song was released, what
    # are the possible years we should be looking at based on our range of ages?
    year_interest = release_years[year]
    birth_years = (year_interest - max_age):(year_interest - min_age)
    names_df_interest <- name_df[name_df$Year %in% birth_years, , drop = FALSE]

    # Compute joint probabilities where group size == 9 (if a name is missing, 
    #it would automatically be 0)
    joint_probs <- tapply(
      names_df_interest$Prop,
      names_df_interest$Year,
      function(x) {
        if (length(x) == 9) prod(x) else 0
      }
    )

    results[year] <- mean(joint_probs, na.rm = TRUE)
  }

  return(results)
}


#' Calculate the posterior distribution
#'
#' Given that you calculated the likelihood, you can then calculate the posterior distribution
#'
#' @param df ("vector") The girl name popularity data.frame
#' @param release_years ("vector") The expected release years
#' @param ages ("vector") The ages that you expect the women will be
#'
#' @returns
#'
#' @export
#' @examples
calculate_posterior <- function(df, release_years = 1970:2020, ages = 18:35) {
  
  likelihood <- calculate_likelihood(
    df,
    release_years = release_years,
    ages = ages
  )
  prior_prob <- 1 / length(release_years) #Assuming a uniform distribution
  posterior = likelihood * prior_prob

  return(cbind.data.frame(
    release_years = release_years,
    posterior_distribution = posterior
  ))
}


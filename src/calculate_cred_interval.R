#' Calculate the credible interval
#'
#' @param results ("data.frame") Output from calculate_posterior() with columns: release_year, posterior
#' @param alpha (numeric) Significance level (default: 0.05 for 95% CI)
#'
#' @returns A list with lower, upper, and width of the interval
#'
#' @export
calculate_credible_interval <- function(results, alpha = 0.05) {
  results <- results[order(results$release_years), ]

  # Calculate cumulative distribution
  results$cumulative <- cumsum(results$normalized)

  lower_bound <- results$release_year[which(results$cumulative >= alpha / 2)[1]]

  # Find upper bound (where CDF >= 1 - alpha/2)
  upper_bound <- results$release_year[which(
    results$cumulative >= 1 - alpha / 2
  )[1]]

  return(list(
    lower = lower_bound,
    upper = upper_bound,
    level = 1 - alpha
  ))
}

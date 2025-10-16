library(stringr)

#' Wrangle social security names
#'
#' The Social Security provides data in multiple text files for each year, this
#' script wrangles them into one csv file to then be used for further analysis.
#' However, I discovered that Hadley Wickham's {babynames} provides the same data.
#' 
#' @param path_file ("character") The path file to the data ("")
#'
#' @returns ("data.frame") Data.frame with "Name", "Sex", "Occurence", and "Year"
#'
#' @export
#' @examples
wrangle_ss_names <- function(path_file = `\names`) {
  
  name_data_list <- list()
  file_names <- list.files(path_file, pattern = ".*txt")
  
  for (file in seq_along(file_names)) {
    full_path_file <- file.path(path_file, file_names[file])
    name_year_data <- read.delim(full_path_file, header = FALSE, sep = ",", stringsAsFactors = FALSE)
    
    # CHECKS HERE:
    if (!is.character(name_year_data[[1]])) {
      stop("The first column should be names (character)")
    }
    if (!is.character(name_year_data[[2]]) || length(unique(name_year_data[[2]])) != 2) {
      stop("The second column should be sex with two levels (e.g. M/F)")
    }
    if (!is.numeric(name_year_data[[3]])) {
      stop("The third column should be occurrence data (numeric)")
    }
    
    colnames(name_year_data) <- c("Name", "Sex", "Occurrence")
    
    name_year_data$year <- as.numeric(str_extract(file_names[file], "\\d{4}"))
    name_year_data$proportional_year <- round(name_year_data$Occurrence / sum(name_year_data$Occurrence), 5)
    
    name_data_list[[file]] <- name_year_data
  }
  
  return(do.call(rbind, name_data_list))
}

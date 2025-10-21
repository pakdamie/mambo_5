library(stringr)

#' Wrangle social security names
#'
#' The Social Security provides data in multiple text files for each year, this
#' script wrangles them into one csv file to then be used for further analysis.
#' Warning: I discovered that Hadley Wickham's {babynames} provides the same data.
#' 
#' @param path_file ("character") The path file to the data (default: names folder)
#'
#' @returns ("data.frame") Data.frame with "Name", "Sex", "Occurrence", and "Year"
#'
#' @export
#' @examples
wrangle_ss_names <- function(path_file = `\names`) {
  
  name_data_list <- list()
  file_names <- list.files(path_file, pattern = "\\.txt$", full.names = FALSE)
  
  for (file in seq_along(file_names)) {
    full_path_file <- file.path(path_file, file_names[file])
    name_year_data <- read.delim(full_path_file, header = FALSE, sep = ",", stringsAsFactors = FALSE)
    
    # CHECKS HERE:
    if (!is.character(name_year_data[[1]])) {
      stop("The first column should be names (character)")
    }
    if (!all(name_year_data[[2]] %in% c("M", "F"))) {
      stop("The second column should contain 'M' or 'F'")
    }
    if (!is.numeric(name_year_data[[3]])) {
      stop("The third column should be occurrence data (numeric)")
    }
    
    colnames(name_year_data) <- c("Name", "Sex", "Occurrence")
    
    name_year_data$Year <- as.numeric(str_extract(file_names[file], "\\d{4}"))
    
    name_data_list[[file]] <- name_year_data
  }
  
  return(do.call(rbind, name_data_list))
}

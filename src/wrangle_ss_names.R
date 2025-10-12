library(stringr)


wrangle_ss_names <- function(path_file){

name_data_list = NULL 

for (file in 1:length(file_path)){
    full_path_file = paste0("names/",path_file[file])
     
     name_year_dat = data.frame(read.delim(full_path_file,
        header = FALSE,sep = ","))

    if (!is.character(a[[1]])) {
      stop("The first column should be names (character)")
    }
    if (!is.character(a[[2]]) || length(unique(a[[2]])) != 2) {
      stop("The second column should be sex with two levels (e.g. M/F)")
    }
    if (!is.numeric(a[[3]])) {
      stop("The third column should be occurrence data (numeric)")
    }

    colnames(name_year_data) <- c("Name", "Sex", "Occurence")
    name_year_data$year <-  str_extract(file_path[file], "\\d{4}") #get the year
    name_year_data$proportional_year <- round(name_year_data$Occurence/sum(name_year_data$Occurence),5)
    name_data_list[[file]] = name_year_data
}
return(do.call(rbind, name_year_data))
}
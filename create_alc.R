####     13.11.2018 / Meeri Seppä / IODS exercises for week three    ####
#### Data is from two questionnaires realated to student performance #####


## Read the data
student_por <- read.table("student-por.csv", header = TRUE, sep = ";")
student_mat <- read.table("student-mat.csv", header = TRUE, sep = ";")


## Dimensions & structure
dim(student_mat)
dim(student_por)
str(student_mat)
str(student_por)


## Join the two data sets
library(dplyr)
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu",
            "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" )
mat_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".math", ".por"))


## Dimensions and structure
dim(mat_por)
str(mat_por)


## Select the columns not used for joining from one of the orginal datasets in order not
## to have the suffixes in it
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]


## Create a new dataset from mat_por with only the joined columns
alc <- select(mat_por, one_of(join_by))


## Combine the duplicated answers
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}


## Create a new variable "alc_use" by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)


## Create a new variable "high_use" which is true if variable alc_use > 2 and false otherwise
alc <- mutate(alc, high_use = alc_use > 2)


## Let's have glimpse
glimpse(alc)


## Everything looks good! We have 382 observations and 35 variables and nothing weird is going 
## on in the dataset. 


## Save the file
getwd()
write.csv(alc, file = "alc.csv", )


## Check that the saved file is readable 
verify <- read.table("alc.csv",header = TRUE, sep= ",")


## Everything still looks good! Let's move on to the analysis excercises :)




#### 9.11.2018 / Meeri Seppa / This is a file for the exercises of week two  ####
#### The data is a part of an international survey of Approaches to Learning ####


# Read data from web
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt ", sep="\t", header=TRUE)

# Examine the data 
dim(lrn14)  
str(lrn14)
# Our table has 60 variables that have 183 integer observations


# Load required packages
library(dplyr)


# Define columns for new variables 
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")


# Select the wanted columns in the dataset
deep <- select(lrn14, one_of(deep_questions))
surface <- select(lrn14, one_of(surface_questions))
strategic <- select(lrn14, one_of(strategic_questions))


# Take the averages of selected variables and add them as new columns to the orginal dataset
lrn14$deep <- rowMeans(deep)
lrn14$surf <- rowMeans(surface)
lrn14$stra <- rowMeans(strategic)


# Define wanted columns and select them from the orginal dataset
columns <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(columns))


# Correct the spelling
columns <- c("gender", "age", "attitude", "deep", "stra", "surf", "points")
colnames(learning2014) <- columns


# Ignore observations with zero points
learning2014 <- filter(learning2014, points > 0)


# Make sure that the right amount of observations and variables
dim(learning2014)


# Set the working directory and save the file as csv
setwd("/home/meeri/ODS/Data")
write.csv(learning2014, "learning2014.csv")


# Read the data again
library(readr)
learning2014_2 <- read_csv("~/ODS/Data/learning2014.csv")

# Make sure that the new data is identical with the orginal
str(learning2014_2)
str(learning2014)
head(learning2014_2)
head(learning2014)


####  23.11.2018 / Meeri Seppä / IODS exercises for week four             
####  There are two datasets; "Human development” and “Gender inequality” 
####  http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt


## Read the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


## Structure and dimensions
dim(hd)
dim(gii)
str(hd)
str(gii)


## Summaries
summary(hd)
summary(gii)


## Print the names of the variables
colnames(hd)
colnames(gii)


## Rename them with better names
names_hd <- c( "HDI.rank", "Country", "HDI", "Life.exp", "Edu.exp", "Edu.mean", "GNI.pc", "GNI.HDI.diff")
names_gii <- c("GII.Rank", "Country", "GII", "Mat.mort", "Ad.birth", "Rep","Edu2.f", "Edu2.m", "Lab.f", "Lab.m" ) 
colnames(hd) <- names_hd
colnames(gii) <- names_gii


## Create two new variables
library(dplyr)
gii <- mutate(gii, Edu.r = Edu2.f / Edu2.m)
gii <- mutate(gii, Lab.r = Lab.f / Lab.m)


## Join the two datasets
human <- inner_join(hd, gii, by = "Country")


## Check the dimensions
dim(human)



#### Week 5 ####



## Transform the variable GNI.pc as numeric
library(stringr)
human$GNI.pc <- str_replace(human$GNI.pc, pattern=",", replace ="") %>% as.numeric
str(human$GNI.pc)  ## Check the result


## Exclude unwanted variables
keep <- colnames(human)[c(2,18,19,4,5,7,11,12,13)]
human <- dplyr::select(human, one_of(keep))


## Exclude rows with missing values
human <- filter(human, complete.cases(human))


## Exclude region observations
last <- nrow(human) - 7
human <- human[1:last, ]


## Change row names and remove the country variable
rownames(human) <- human$Country
human <- select(human, -Country)


## Check the dimensions
dim(human)


## Save the data 
setwd("~/ODS/Data")
write.csv(human, file = "human.csv", row.names = TRUE)


## Check that the saved file is readable 
read.csv("human.csv", row.names = 1)


## Everything looks fine! 


####  23.11.2018 / Meeri Seppä / IODS exercises for week four             
####    There are two datasets; "Human development” and “Gender inequality” 


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
gii <- mutate(gii, Edur.r = Edu2.f / Edu2.m)
gii <- mutate(gii, Lab.r = Lab.f / Lab.m)


## Join the two datasets
human <- inner_join(hd, gii, by = "Country")

## Check the dimensions
dim(human)


## I think the correct number of variables is 18. The two datasets have 11 and 8 = 19  variables, so if
## we use one of them as an identifier there has to be one less variable in the joined dataset. 


## Save the data 
write.csv(human, file = "human.csv")


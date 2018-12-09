


## Read the data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)


## Variable names
colnames(RATS)
colnames(BPRS)


## Explore the data
str(RATS)
str(BPRS)
summary(RATS)
summary(BPRS)


## Factor
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

## Convert to long form
library(tidyr)
library(dplyr)

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3,4))) 


BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks,5,6)))



## Variable names
colnames(RATSL)
colnames(BPRSL)


## Explore the data
str(RATSL)
str(BPRSL)
summary(RATSL)
summary(BPRSL)


## Save the datasets
setwd("~/ODS/Data")
write.csv(RATSL, file = "RATSL.csv")
write.csv(BPRSL, file = "BPRSL.csv")


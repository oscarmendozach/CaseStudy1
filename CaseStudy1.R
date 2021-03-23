#import libraries

library(dplyr)

#load datasets

redwine <- read.csv(file = 'winequality-red.csv', 
                    header = TRUE,
                    sep = ";")
whitewine <- read.csv(file = 'winequality-white.csv',
                      header = TRUE,
                      sep = ";")

#check sizes

dim(redwine)

dim(whitewine)

#check dataframe structures

str(redwine)

str(whitewine)

#check for NA's
sum(is.na(redwine))

sum(is.na(whitewine))

#appending data
redwine$color <- "red"

whitewine$color <- "white"

df_wine <- rbind(redwine, whitewine)


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

#EXPLORATORY DATA ANALYSIS

#fixex acidity histogram
ggplot(data = df_wine, aes(x = fixed.acidity)) + geom_histogram() 

#total sulfur dioxide histogram
ggplot(data = df_wine, aes(x = total.sulfur.dioxide)) + geom_histogram()

#alcohol histogram
ggplot(data = df_wine, aes(x = alcohol)) + geom_histogram()

#pH histogram
ggplot(data = df_wine, aes(x= pH)) + geom_histogram()

#quality vs volatile acidity
ggplot(data = df_wine, aes(x = quality, y = volatile.acidity)) + geom_point()

#quality vs residual sugar
ggplot(data = df_wine, aes(x = quality, y = residual.sugar)) + geom_point()

#quality vs pH
ggplot(data = df_wine, aes(x = quality, y = pH)) + geom_point()

#quality vs alcohol
ggplot(data = df_wine, aes(x = quality, y = alcohol)) + geom_point()

#GROUPING
#means by quality
df_wine %>% group_by(quality) %>% summarise_all(.funs = c(mean = "mean"))

#means by color and quality
df_wine %>% group_by(color, quality) %>% summarise_all(.funs = c(mean = "mean"))

#means by color and quality only using pH
df_wine %>% select(color, quality, pH) %>%
  group_by(quality, color) %>% 
  summarise_all(.funs = c(pH_mean = "mean"))

#means by color
df_wine %>% group_by(color) %>% summarise_all(.funs = c(mean = "mean"))

#what level of acidity receives the highest average rating?
summary(df_wine['pH'])

df3 <- df_wine %>% mutate(acidity.levels = case_when(pH < 3.11 ~ 'High',
                                              pH >= 3.11 & pH < 3.21 ~ 'Mod_high',
                                              pH >= 3.21 & pH < 3.32 ~ 'Medium',
                                              pH >= 3.32 & pH <=4.010 ~ 'Low'))

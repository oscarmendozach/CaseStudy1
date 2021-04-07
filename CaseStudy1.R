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

#DO WINES WITH HIGHER ALCOHOLIC CONTECT RECEIVER BETTER RATINGS?

df3 %>% select(acidity.levels, quality) %>% 
  group_by(acidity.levels) %>%
  summarise(mean_quality = mean(quality))

#Get the median amount of alcohol content

median(df3$alcohol)

#get the mean quality of samples with alcohol content less than the median
low_alcohol_mean_quality <- mean(df3$quality[df3$alcohol < median(df3$alcohol)])

#get the mean quality of samples with alcohol content more than the median
high_alcohol_mean_quality <- mean(df3$quality[df3$alcohol >= median(df3$alcohol)])

print(c(low_alcohol_mean_quality, high_alcohol_mean_quality))

#DO SWEETER WINES RECEIVE BETTER RATINGS?

#get the mean quality of samples with residual sugar less than the median
low_sugar_mean_quality <- mean(df3$quality[df3$residual.sugar < median(df3$residual.sugar)])

#get the mean quality of samples with residual sugar more or equal than the median
high_sugar_mean_quality <- mean(df3$quality[df3$residual.sugar >= median(df3$residual.sugar)])

print(c(low_sugar_mean_quality, high_sugar_mean_quality))

#PLOTS
#DO WINES WITH HIGHER ALCOHOLIC CONTENT RECEIVE BETTER RATINGS?

wines_alcohol_quality <- data.frame(Average_Quality_Ratings = c(low_alcohol_mean_quality, high_alcohol_mean_quality), 
                                    Alcohol_Content = c('Low', 'High'))

ggplot(data = wines_alcohol_quality, aes(y = Average_Quality_Ratings, x = Alcohol_Content)) + 
  geom_col()

#DO SWEETER WINES RECEIVE HIGHER RATINGS?
wines_sugar_quality <- data.frame(Average_Quality_Ratings = c(low_sugar_mean_quality, high_sugar_mean_quality),
                                  Residual_Sugar = c('Low', 'High'))

ggplot(data = wines_sugar_quality, aes(x = Residual_Sugar, y = Average_Quality_Ratings)) +
  geom_col()

#WHAT LEVELS OF ACIDITY RECEIVE THE HIGHEST AVERAGE RATINGS

wines_acidity_quality <- df3 %>% 
  group_by(acidity.levels) %>% 
  summarise(mean_quality = mean(quality))

ggplot(data = wines_acidity_quality, 
       aes(x = reorder(acidity.levels, desc(mean_quality)), y = mean_quality)) +
  geom_col() + 
  coord_cartesian(ylim = c(5.7, 5.9)) +
  xlab('Acidity Levels')


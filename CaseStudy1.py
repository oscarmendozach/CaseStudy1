#import libraries

import pandas as pd
import numpy as np
#% matplotlib inline

#first read data
df_redwine = pd.read_csv(filepath_or_buffer = 'winequality-red.csv')
df_whitewine = pd.read_csv(filepath_or_buffer = 'winequality-white.csv')

#see first five rows of data
df_redwine.head()
df_whitewine.head()

#see tail of data
df_redwine.tail(n=20)
df_whitewine.tail(n = 20)

#see the dimensions
df_redwine.shape
df_whitewine.shape

#see the dataframe data types
df_redwine.dtypes
df_whitewine.dtypes

## DATA WRANGLING

# 1. MISSING DATA
df_redwine.info()

df_whitewine.info()

# 2. duplicated values
sum(df_redwine.duplicated())

sum(df_whitewine.duplicated())

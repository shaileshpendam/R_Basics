library(dplyr)
library(ggplot2)
library(summarytools)

##### THIS WEEK

### Plot Features of both Data Types
# 1/ Categorical X 3 
# 2/ Numerical - Binning or Grouping X 3

### Insights

## Data Sanity
# 1/ Missing Value Treatment - Numerical - Replace by Median, Categorical - replace by Mode
# 2/ Transformation of Numerical/Categorical - Log Transformation, StandardScaler, one hot encoding

## Advanced
# 1/ Outlier Detection and Removal - Box Plot - Treat with Quartile 

##### Transition to ML
# Hopefully Build a Log Reg

##### Referances
# https://www.kaggle.com/rhythmcam/r-titanic-nn-80
# Ref : https://statsandr.com/blog/descriptive-statistics-in-r/

##### Import & Clean
setwd("D:\\GitHub\\R_Basics\\IPBA 13")

#Data Import
data <- read.csv("insurance_claims.csv")

# Drop Features
drop <- c("X_c39")
data = data[,!(names(data) %in% drop)]


##### Check Summary (summarytools)
summary(data)

descr(data,
      headings = FALSE, # remove headings
      stats = "common" # most common descriptive statistics
)

dfSummary(data)

# Categorical
chisq.test(data$policy_state, data$fraud_reported)

chisq.test(data$insured_sex, data$fraud_reported)

chisq.test(data$insured_occupation, data$fraud_reported)

chisq.test(data$insured_education_level, data$fraud_reported)

chisq.test(data$insured_hobbies, data$fraud_reported)

# Variable that is Categorical but Numeric Data Type

#Conversion 
data$umbrella_limit <- as.factor(data$umbrella_limit)
chisq.test(data$umbrella_limit, data$fraud_reported)

# Numerical
ggplot(data, aes(x=months_as_customer, y=age)) + geom_point()
cor(data$age, data$months_as_customer)

t.test(data$age, data$months_as_customer)

# Numerical to Categorical
summary(aov(data = data, age ~ as.factor(fraud_reported)))

boxplot(data$age~factor(data$fraud_reported))

summary(aov(data = data, age ~ as.factor(auto_make)))

boxplot(data$age~factor(data$auto_make))

## Logistic Regression

lr <- glm(factor(fraud_reported) ~ age + auto_make + insured_hobbies + months_as_customer, data = data,family = "binomial")
summary(lr)

##### Add Features

# 1/ Add Fraud_Flag
data <- data %>% mutate(fraud_flag = IF_ELSE(fraud_reported == "Y", 1, 0))

# 2/ Add Row Number
data <- data %>% mutate(row_count = 1)



##### First Code - Plot Number of Frauds Chart 

# 1/ Convert Categorical feature As Factor
data$fraud_reported <- as.factor(data$fraud_reported)

# 2/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()
g <- ggplot(data, aes(fraud_reported))

# 3/ Then add a Bar Plot
g + geom_bar()

##### Categorical Features

### policy_state
# 1/ Convert Categorical feature As Factor
data$policy_state <- as.factor(data$policy_state)

# 2/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()
g <- ggplot(data, aes(policy_state)) 

# 3/ Then add a Bar Plot
g + geom_bar()

# Other Type of Plots
mosaicplot(table(data$policy_state, data$fraud_reported),
           color = TRUE,
           xlab = "policy_state", # label for x-axis
           ylab = "Fraud" # label for y-axis
)



### policy_deductable
# 1/ Convert Categorical feature As Factor
data$policy_deductable <- as.factor(data$policy_deductable)

# 2/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()
g <- ggplot(data, aes(policy_deductable)) + geom_bar()
g


### auto_make
# 1/ Convert Categorical feature As Factor


# 2/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()



### auto_make - with "y"
# 





##### Numerical Features


### age
# 1/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()
g <- ggplot(data, aes(age)) 

# 2/ Then add a Bar Plot
g+ geom_histogram(binwidth = 4)

### months_as_customer
# 1/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()
g <- ggplot(data, aes(months_as_customer)) 

# 2/ Then add a Bar Plot
g + geom_histogram(bins = 50) 

### age - outlier
# 1/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()


# 2/ Then add a Bar Plot


### months_as_customer
# 1/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()
g <- ggplot(data, aes(age)) 

# 2/ Then add a Bar Plot
g + geom_boxplot()


### policy_annual_premium
# 1/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()

g <- ggplot(data, aes(policy_annual_premium)) 

### property_claim
# 1/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()
g + geom_boxplot()


### injury_claim
# 1/ Set the Chart Canvas with Required Features - For Categorical just use one Feature in aes()




##### Check Missing Values
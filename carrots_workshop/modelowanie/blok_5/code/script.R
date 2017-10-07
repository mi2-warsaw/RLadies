# load libraries
library(sparklyr)
library(MASS)
library(dplyr)
library(DBI)

##### WORKFLOW #####
# connect to Spark
Sys.setenv(JAVA_HOME = "/usr/lib/jvm/java-8-openjdk-amd64")
conn <- spark_connect(master = "local")

# do some work -here check if connection is established
spark_connection_is_open(conn)

# disconnect
spark_disconnect(conn)


##### GETTING DATA #####
# setting connection once more
conn <- spark_connect(master = "local")

# read data from csv (make sure you have correct path)
spark_read_csv(conn, "titanic", "data/titanic_spark.csv")

# copy data.frame from R
data("Boston")
copy_to(conn, Boston, "house_prices")

# check all available tables stored in Spark
src_tbls(conn)


##### EXPLORING DATA #####
# create reference to Spark table without loading it into memory
house_prices_tbl <- tbl(conn, "house_prices")

# is tibble?
is.tbl(house_prices_tbl)

# print data (default number of rows = 10)
print(house_prices_tbl)

# print first 5 rows with the width of 25 characters
print(house_prices_tbl, n = 5, width = 25)

# examine the stucture with str() function
# it's not what we expected
str(house_prices_tbl)
str(Boston)

# examine the structure with glimpse() function
glimpse(house_prices_tbl)

# the size of data stored in R
object.size(Boston)

# the size of data stored in R as a tibble
object.size(house_prices_tbl)

##### MANIPULATING DATA WITH DPLYR #####
### Select columns ###
 
# select columns crim, age, medv
house_prices_tbl %>% 
  select(crim, age, medv)

# note that square bracket indexing is not supported 
house_prices_tbl[, c("crim", "age", "medv")]

# choose all but crim, age, medv
house_prices_tbl %>% 
  select(-crim, -age, -medv)

# select columns between nox and tax
house_prices_tbl %>% 
  select(nox:tax)

# select all columns starting from "r"
house_prices_tbl %>% 
  select(starts_with("r"))

# select all columns containing "rat" 
house_prices_tbl %>% 
  select(contains("rat"))

# select all columns matching regular expression (ends with "s")
house_prices_tbl %>% 
  select(matches("s$"))

# select all columns matching regular expression (two "t"s with some letter(s) between)
house_prices_tbl %>% 
  select(matches("t.+t"))


### Filter rows ###
# rm > 8
house_prices_tbl %>% 
  filter(rm > 8)

# ptratio o < 15 and crim < 0.005
house_prices_tbl %>% 
  filter(ptratio < 15, crim < 0.02)


### Arrange rows ###
# arrange by age in ascending order
house_prices_tbl %>% 
  arrange(age)

# arrange by crim in ascending order and by rm in descending order
house_prices_tbl %>% 
  arrange(crim, desc(rm))


### Change or add columns ###
# change tax column by multiplying it by 10 000
house_prices_tbl %>% 
  mutate(tax = tax * 10000)

# create new column is_cheap which is transformation of medv column
house_prices_tbl %>% 
  mutate(is_cheap = ifelse(medv < 25, "cheap", "expensive"))

# create new column crim_medv_ratio which is crim to medv proportion
house_prices_tbl %>% 
  mutate(crim_medv_ratio = crim / medv)


### Calculate summary statistics ###
# calculate mean medv
house_prices_tbl %>% 
  summarise(mean_medv = mean(medv))

# calculate min dis and sd of tax
house_prices_tbl %>% 
  summarise(min_dis = min(dis), sd_tax = sd(tax))


### Select distinct rows ###
# select ditinct values for column chas
house_prices_tbl %>% 
  distinct(chas)

# select distinct combinations of columns rad and chas
house_prices_tbl %>% 
  distinct(rad, chas)

### Count unique combinations ###
# count how many of each value from column chas we have
house_prices_tbl %>% 
  count(chas)

# count how many combinations of values from columns rad and chas we have
house_prices_tbl %>% 
  count(rad, chas, sort = TRUE)

# now take five the most common values of rad
house_prices_tbl %>% 
  count(rad, sort = TRUE) %>% 
  top_n(5)


### Group by the same value ###
# calculate average mean of medv in each group by rad
house_prices_tbl %>% 
  group_by(rad) %>% 
  summarise(medv_mean = mean(medv))

# mutate age by group-specific normalization (by chas)
house_prices_tbl %>% 
  group_by(chas) %>% 
  mutate(age_norm = (age - mean(age)) / sd(age)) %>% 
  select(chas, age, age_norm)

### Collect and compute data ###
# assign results to new tibble
# results in a tiblle
# lazy valuation - no computation here!
results <- house_prices_tbl %>% 
  filter(medv < 10) %>% 
  count(rad, chas)

class(results)

# collect the results
# collected is an R data.frame
# Spark had to done computation to return results to R
collected <- results %>% collect()

# check class of two objects
class(results)
class(collected)

# compute the intermediate results and store in Spark
# house_prices_filteres is in Spark
house_prices_tbl %>% 
  filter(medv < 10) %>%
  compute("house_prices_filtered")

# check if new object was created
src_tbls(conn)


##### MANIPULATING DATA USING SQL #####
# take only nox, rm and age columns and return only 10 first rows
# it collects data directly to R as data.frame (no need of collect())
result2 <- dbGetQuery(conn, "SELECT nox, rm, age FROM house_prices LIMIT 10")

# check the class of result object
class(result2)


##### MACHINE LEARNING TECHNIQUES #####
### ML transformers ###

# sparklyr feature transformation interface
# a_tibble %>%
#   ft_some_transformation("x", "y", some_other_args)


## Transform continuous variable to binary ##
# creating tibble for new dataset
data("iris")
copy_to(conn, iris, "iris")
iris_tbl <- tbl(conn, "iris")

# be careful - dots in the columns' names have been replaced by underscores!
glimpse(iris_tbl)

# convert continuous column into logical
iris_tbl %>% 
  ft_binarizer("Petal_Length", "petal_is_long", 4)

# when collecting to R
collected <- iris_tbl %>% 
  ft_binarizer("Petal_Length", "petal_is_long", 4) %>% 
  collect() %>% 
  mutate(petal_is_long = as.logical(petal_is_long))


## Transform continuous variable to caterogical ##
# convert continuous column into categorical
# [0, 5) - 0, [5, 6) - 1, [6, 7) - 2 ...
iris_tbl %>% 
  ft_bucketizer("Sepal_Length", "sepal_length_level", splits = c(0, 5, 6, 7, Inf))

# when collecting to R
splits <- c(0, 5, 6, 7, Inf)
collected <- iris_tbl %>% 
  ft_bucketizer("Sepal_Length", "sepal_length_level", splits = splits) %>% 
  collect() %>% 
  mutate(sepal_length_level = factor(sepal_length_level))

# convert continuous column into categorical by quantiles
iris_tbl_buckets <- iris_tbl %>%
  ft_bucketizer("Sepal_Length", "sepal_length_level", splits = c(0, 5, 6, 7, Inf)) %>% 
  ft_quantile_discretizer("Sepal_Length", "sepal_length_level_q", n.buckets = 4) 

print(iris_tbl_buckets)

iris_tbl_buckets %>% 
  count(sepal_length_level)

# roughly equal parts
iris_tbl_buckets %>% 
  count(sepal_length_level_q)


## Encode character column into numerical column ##
encoded <- iris_tbl %>% 
  ft_string_indexer("Species", "species_ind")

print(encoded)

encoded %>% 
  distinct(Species, species_ind)


## Transform a data using SQL ##
# use SQL query with ft_sql_transformer() function
# we get the same result as from the `dbGetQuery()` function
result <- iris_tbl %>% 
  ft_sql_transformer("SELECT Sepal_Length, Sepal_width FROM iris WHERE Petal_Width < 1 LIMIT 10")

# but this is not a data frame!
class(result)


## Split data to training and test set ##
# first we add column 'species_ind'
iris_tbl_ind <- iris_tbl %>% 
  ft_string_indexer("Species", "Species_ind")

# split data on training and testing set
train_test <- iris_tbl_ind %>% 
  sdf_partition(training = 0.7, testing = 0.3, seed = 123)

class(train_test)

names(train_test)

# you can split data set into more than two sets!
# if the fractions don't add up to one they will be scaled
iris_tbl %>% 
  sdf_partition(set_a = 0.3, set_b = 0.3, set_c = 0.6)

# use indexing operator to access the subset
training_tbl <- train_test$training
testing_tbl <- train_test[["testing"]]

class(training_tbl)
class(testing_tbl)


### Machine learning functions ###
# equivalent statements
# ml_linear_regression(z ~ -1 + x + y)
# ml_linear_regression(intercept = FALSE, response = "z", features = c("x", "y"))

## Linear regression ##
# train linear regression model
model_lr <- iris_tbl %>% 
  select(Petal_Width, Petal_Length) %>%
  ml_linear_regression(Petal_Length ~ Petal_Width)

# check model summary
summary(model_lr)

# how well the model fits?
library(ggplot2)
iris_tbl %>%
  select(Petal_Width, Petal_Length) %>%
  collect() %>%
  ggplot(aes(Petal_Length, Petal_Width)) +
  geom_point(aes(Petal_Width, Petal_Length)) +
  geom_abline(aes(slope = coef(model_lr)[2], intercept = coef(model_lr)[1]), color = "red") +
  labs(x = "Petal Width", y = "Petal Length")


## Logistic regression ##
# prepare dataset - iris but only with two classes
# we have to operate on "indexed" classes 
iris_tbl_ind2 <- iris_tbl %>% 
  filter(Species != "virginica") %>% 
  ft_string_indexer("Species", "Species_ind")

train_test2 <- iris_tbl_ind2 %>% 
  sdf_partition(training = 0.7, testing = 0.3, seed = 123)

training_tbl2 <- train_test2$training
testing_tbl2 <- train_test2$testing

# train logistic regression model
model_logr <- training_tbl2 %>%
  ml_logistic_regression(Species_ind ~ Petal_Length + Petal_Width)

# check model summary
summary(model_logr)

# predict classes for testing set
pred_logr <- sdf_predict(model_logr, testing_tbl2) 

print(pred_logr)

# compare predicted classes with real classess (in R)
result_logr <- pred_logr %>% 
  select("Species_ind", "prediction") %>% 
  collect()
table(result_logr$prediction, result_logr$Species_ind)

# model evaluation
pred_logr %>% 
  mutate(Species_ind = as.double(Species_ind)) %>% 
  ml_binary_classification_eval("Species_ind", "prediction", metric = "areaUnderROC")


## Decision tree ##
# train decision tree model
model_dt <- training_tbl %>%
  ml_decision_tree(Species_ind ~ Petal_Length + Petal_Width, type = "classification")

# predict classes for testing dataset
predict_dt <- sdf_predict(model_dt, testing_tbl)

# compare predicted classes with real classess (in R)
result_dt <- predict_dt %>% 
  select("Species_ind", "prediction") %>% 
  collect()
table(result_dt$prediction, result_dt$Species_ind)

# feature importance
ml_tree_feature_importance(conn, model_dt)

# evaluate model
ml_classification_eval(predict_dt, "Species_ind", "prediction", metric = "accuracy")

## Random forests ##
# train random forest model
model_rf <- testing_tbl %>%
  ml_random_forest(Species_ind ~ Petal_Length + Petal_Width, type = "classification")

# predict classes for testing dataset
predict_rf <- sdf_predict(model_rf, testing_tbl)

# compare predicted classes with real classess (in R)
result_rf <- predict_rf %>% 
  select("Species_ind", "prediction") %>% 
  collect()
table(result_rf$prediction, result_rf$Species_ind)

# feature importance
ml_tree_feature_importance(conn, model_rf)

# evaluate model
ml_classification_eval(predict_rf, "Species_ind", "prediction", metric = "accuracy")

### Utilities ###
# ml_binary_classification_eval() 
# ml_classification_eval() 
# ml_tree_feature_importance() 


##### WORKING FLOW #####

# perform SQL queries through the `sparklyr` `dplyr` interface,
# use the `sdf_*()` and `ft_*()` family of functions to generate new columns, or partition your data set,
# choose an appropriate machine learning algorithm from the `ml_*()` family of functions to model your data,
# inspect the quality of your model fit, and use it to make predictions with new data.
# collect the results for visualization and further analysis in R

# read data from csv 
spark_read_csv(conn, "titanic", "data/titanic_spark.csv")
titanic_tbl <- tbl(conn, "titanic")

# inspect the data
glimpse(titanic_tbl)

# tidy the data
titanic_final_tbl <- titanic_tbl %>% 
  mutate(Parch = as.numeric(Parch), Fare = as.numeric(Fare), Survived = as.double(Survived)) %>% 
  mutate(family_size = SibSp + Parch + 1) %>% 
  filter(!is.na(Embarked)) %>% 
  mutate(Age = if_else(is.na(Age), mean(Age), Age)) %>% 
  ft_bucketizer("family_size", "family_bucket", splits = c(1,2,5,12)) %>% 
  mutate(family_bucket = as.character(as.integer(family_bucket))) %>% 
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare, Embarked, family_size) 

glimpse(titanic_final_tbl)

# split data
partition <- titanic_final_tbl %>% 
  sdf_partition(train = 0.7, test = 0.3, seed = 123)
train_tbl <- partition$train
test_tbl <- partition$test

# train the models
ml_formula <- formula(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + family_size)

ml_logr <- ml_logistic_regression(train_tbl, ml_formula)
ml_dt <- ml_decision_tree(train_tbl, ml_formula, type = "classification")
ml_rf <- ml_random_forest(train_tbl, ml_formula, type = "classification")

# test data
ml_models <- list(
  "Logistic" = ml_logr,
  "Decision Tree" = ml_dt,
  "Random Forest" = ml_rf
)

score_test_data <- function(model, data = test_tbl) {
  pred <- sdf_predict(model, data)
  select(pred, Survived, prediction)
}

ml_score <- lapply(ml_models, score_test_data)
ml_score

# compare results (AUC and accuracy)
# function for calculating accuracy
calc_accuracy <- function(data) {
  data %>% 
    ml_classification_eval("prediction", "Survived", "accuracy")
}

# calculate AUC and accuracy
perf_metrics <- data.frame(
  model = names(ml_score),
  AUC = 100 * sapply(ml_score, ml_binary_classification_eval, "Survived", "prediction"),
  Accuracy = 100 * sapply(ml_score, calc_accuracy),
  row.names = NULL, stringsAsFactors = FALSE)

perf_metrics

# plot results
library(tidyr)
library(ggplot2)
gather(perf_metrics, metric, value, AUC, Accuracy) %>%
  ggplot(aes(reorder(model, value), value, fill = metric)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  coord_flip() +
  xlab("") +
  ylab("Percent") +
  ggtitle("Performance Metrics")

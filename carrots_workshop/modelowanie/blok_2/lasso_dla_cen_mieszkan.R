prices_mm <- model.matrix(sale_price ~., prices_train)
lasso_prices <- cv.glmnet(prices_mm, log(prices_train$sale_price))
plot(lasso_prices)
biggest_good_lambda <- lasso_prices$lambda.1se
sparse_good_model <- glmnet(prices_mm, log(prices_train$sale_price), lambda = biggest_good_lambda)

# ---------- lasso
prices_mm_test <- model.matrix(sale_price ~., prices_test)
lasso_prices_prediction <- predict(sparse_good_model, newx = prices_mm_test)
mse(log(prices_test$sale_price), lasso_prices_prediction)

# --------- random forest


# --------- boosting
dtrain <- xgb.DMatrix(prices_mm, 
                      label = log(prices_train$sale_price))
param <- list(max_depth = 3, # maksymalna głębokość pojedynczego drzewa
              eta = 0.1, # wielkość kroku boostingu
              nthread = 2, # liczba wątków
              objective = "reg:linear") # do wyboru także "binary:logistic"

nrounds <- 100 # maksymalna liczba iteracji
nfold <- 10 # liczba podzbiorów kroswalidacji
set.seed(44)
xgb_cv <- xgb.cv(param, dtrain, 
                 nrounds = nrounds,
                 nfold = nfold, 
                 metrics = "rmse",
                 verbose = TRUE) # nie wypisuj wyników pośrednich do konsoli
xgb_cv$evaluation_log$test_rmse_mean %>% min()


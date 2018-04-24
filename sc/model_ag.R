

data_m <- as.data.frame(initial_data)

# --- 不含杠杆倍数
ret <- returns(data_m$GBP.USD)*100 
ret <- na.omit(ret)

# ---
VaR(initial_data)
VaR(ret)


# ---
ar_fit = armaFit(~ arma(2, 1), data = ret, method = "mle")
ar_pred <- predict(ar_fit, 5)


# ---
g_fit <- garchFit(formula = ~ garch(2, 1),ret)
g_pred <- predict(g_fit, 1)

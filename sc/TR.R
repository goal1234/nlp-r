data_aroon1 <- apply.weekly(initial_data, max)
data_aroon2 <- apply.weekly(initial_data, min)

a <- as.data.frame(data_aroon1)
b <- as.data.frame(data_aroon2)
cbind(a, b)




# ---
aroon(cbind(a, b))




# ---
RSI(initial_data)
CMO(initial_data)



# ---
MACD(initial_data, nFast = 12, nSlow = 26, nsig =9)




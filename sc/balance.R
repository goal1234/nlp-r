DataSource <- getFX("EUR/USD")
getFX("USD/JPY")
getFX("EUR/JPY")

USDJPY[date]
EURJPY[date]
EURUSD[date]

implication <- EURJPY/USDJPY
colnames(implication) <- "impli_eu"
I <- cbind(implication, EURUSD)


# ---
runCor(EURJPY, USDJPY)
runCor(EURJPY, EURUSD)

runCov(EURJPY, USDJPY)
runCov(EURJPY, EURUSD)

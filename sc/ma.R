DataSource <- getFX("EUR/USD")
initial_data <- EURUSD$EUR.USD

DataSource <- getFX("GBP/USD")
initial_data <- GBPUSD$GBP.USD

# ---ma:3, 5, 7


dma3 <- EMA(initial_data, 3)
dma5 <- EMA(initial_data, 5)
dma7 <- EMA(initial_data, 7)

date <- Sys.Date() - 1

Judge <- function(ma1, ma2, ma3, da) {  
  # ma, da-> date
  if(objects(ma1) != "EMA") warning("ma_data should be a xts!")
  if(objects(ma2) != "EMA") warning("ma_data should be a xts!")
  if(objects(ma3) != "EMA") warning("ma_data should be a xts!")
  
  if_1 <- ma1[da]
  if_2 <- ma2[da]
  if_3 <- ma3[da]
  
  Condition1 <-  if(if_1 > if_2 & if_1 > if_3) {
    TRUE
  }else {
    FALSE
  }

  return(Condition1)      
}

# ---
week <- apply.weekly(initial_data, mean)
wma3 <- EMA(week, 3)
wma5 <- EMA(week, 5)
wma7 <- EMA(week, 7)

dateGMT<-timeDate(date, FinC = "GMT")
dayOfWeek(dateGMT)


get_week <-   switch (weekdays(Sys.Date()),
          "星期一" = Sys.Date() - 1,
          "星期二" = Sys.Date() - 2,
          "星期三" = Sys.Date() - 3,
          "星期四" = Sys.Date() - 4,
          "星期五" = Sys.Date() - 5,
          "星期六" = Sys.Date() - 6
  )


Judge(wma3, wma5, wma7, get_week)
Judge(dma3, dma5, dma7, date)







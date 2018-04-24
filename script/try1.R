filepath <- 'E:/toolkit/nlp/Rnlp/NLPinR/data/articles1.csv'

input <- read.csv(filepath,stringsAsFactors = F)
input <- input[1:1000, ]

library(tokenizers)
options(max.print = 25)



get_list <- function(x) {
  # 得到一个list
  t <- list()
  len <- length(input$content)
  for(i in 1:len){
    t[i] <- input$content[i]
  }
  return(t)
}

test <- get_list(input$content)

sapply(test, tokenize_words)s

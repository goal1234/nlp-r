
require(rJava)
require(Rwordseg)

text <- "自然语言处理时什么鬼，你知道吗？"
segmentCN(text)

# 创建新的词汇
insertWords(c('菜鸟', '公主号'), save = TRUE)
deleteWords(c("菜鸟","公众号"),save=TRUE)  

#载入字典
installDict("热门电影大全.scel","movie")   
uninstallDict("movie") 

#参数isNameRecognition  可用来人的名字识别，  
getOption("isNameRecognition") #默认是不进行人名识别,输出false  
segmentCN("梅超风不是是桃花岛岛主")  
segment.options(isNameRecognition = TRUE)  
getOption("isNameRecognition")  
segmentCN("梅超风是桃花岛岛主") 

#2、数字识别（isNumRecognition ，默认为TRUE，默认识别数字）；
#3、量词识别（isQuantifierRecognition，默认为TRUE，默认识别量词）。



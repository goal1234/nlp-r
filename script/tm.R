
library(NLP)
library(tm)
data("acq")
acq

data("crude")
crude[[1]]
(f <- content_transformer(function(x, pattern) gsub(pattern, "", x)))
tm_map(crude, f, "[[:digit:]]+")[[1]]

data("crude")
crude


# ---变为docs了
docs <- data.frame(doc_id = c("doc_1", "doc_2"),
                   text = c("This is a text.", "This another one."),
                   dmeta1 = 1:2, dmeta2 = letters[1:2],
                   stringsAsFactors = FALSE)
(ds <- DataframeSource(docs))
x <- Corpus(ds)
inspect(x)
meta(x)

#---Create a directory source
DirSource(directory = ".",
          encoding = "",
          pattern = NULL,
          recursive = FALSE,
          ignore.case = FALSE,
          mode = "text")

DirSource(system.file("texts", "txt", package = "tm"))

# Docs Access Document IDs and Terms

data("crude")
tdm <- TermDocumentMatrix(crude)[1:10,1:20]
Docs(tdm)
nDocs(tdm)
nTerms(tdm)
Terms(tdm)

# findAssocsFind Associations in a Term-Document Matrix


data("crude")
tdm <- TermDocumentMatrix(crude)
findAssocs(tdm, c("oil", "opec", "xyz"), c(0.7, 0.75, 0.1))
findFreqTerms(x, lowfreq = 0, highfreq = Inf)

data("crude")
tdm <- TermDocumentMatrix(crude)
findFreqTerms(tdm, 2, 3)

# ---findMostFreqTerms Find Most Frequent Terms

data("crude")
## Term frequencies:
tf <- termFreq(crude[[14L]])
findMostFreqTerms(tf)
## Document-term matrices:
dtm <- DocumentTermMatrix(crude)
## Most frequent terms for each document:
findMostFreqTerms(dtm)
## Most frequent terms for the first 10 the second 10 documents,
## respectively:
findMostFreqTerms(dtm, INDEX = rep(1 : 2, each = 10L))

# foreign Read Document-Term Matrices
read_dtm_Blei_et_al(file, vocab = NULL)
read_dtm_MC(file, scalingtype = NULL)

# hpc Parallelized ‘lapply’

data("crude")
inspect(crude[1:3])
inspect(crude[[1]])
tdm <- TermDocumentMatrix(crude)[1:10, 1:10]
inspect(tdm)


# ---
data("crude")
meta(crude[[1]])
DublinCore(crude[[1]])
meta(crude[[1]], tag = "topics")
meta(crude[[1]], tag = "comment") <- "A short comment."
meta(crude[[1]], tag = "topics") <- NULL
DublinCore(crude[[1]], tag = "creator") <- "Ano Nymous"
DublinCore(crude[[1]], tag = "format") <- "XML"
DublinCore(crude[[1]])
meta(crude[[1]])
meta(crude)
meta(crude, type = "corpus")
meta(crude, "labels") <- 21:40
meta(crude)

txt <- system.file("texts", "txt", package = "tm")
## Not run: PCorpus(DirSource(txt),
dbControl = list(dbName = "pcorpus.db", dbType = "DB1"))
## End(Not run

#PlainTextDocument
#Plain Text Documents

PlainTextDocument(x = character(0),
                  author = character(0),
                  datetimestamp = as.POSIXlt(Sys.time(), tz = "GMT"),
                  description = character(0),
                  heading = character(0),
                  id = character(0),
                  language = character(0),
                  origin = character(0),
                  ...,
                  meta = NULL,
                  class = NULL)

# Visualize a Term-Document Matrix
(ptd <- PlainTextDocument("A simple plain text document",
                          heading = "Plain text document",
                          id = basename(tempfile()),
                          language = "en"))
meta(ptd)


# readDataframe
# Read In a Text Document from a Data Frame
docs <- data.frame(doc_id = c("doc_1", "doc_2"),
                   text = c("This is a text.", "This another one."),
                   stringsAsFactors = FALSE)
ds <- DataframeSource(docs)
elem <- getElem(stepNext(ds))
result <- readDataframe(elem, "en", NULL)
inspect(result)
meta(result)

# readDOC Read In a MS Word Document
readDOC(engine = c("antiword", "executable"), AntiwordOptions = "")

# readPDF Read In a PDF Document
readPDF(engine = c("pdftools", "xpdf", "Rpoppler",
                   "ghostscript", "Rcampdf", "custom"),
        control = list(info = NULL, text = NULL))


uri <- sprintf("file://%s",
               system.file(file.path("doc", "tm.pdf"), package = "tm"))
engine <- if(nzchar(system.file(package = "pdftools"))) {
  "pdftools"
} else {
  "ghostscript"
}
reader <- readPDF(engine)
pdf <- reader(elem = list(uri = uri), language = "en", id = "id1")
cat(content(pdf)[1])
VCorpus(URISource(uri, mode = ""),
        readerControl = list(reader = readPDF(engine = "ghostscript")))

# readPlain Read In a Text Document
docs <- c("This is a text.", "This another one.")
vs <- VectorSource(docs)
elem <- getElem(stepNext(vs))
(result <- readPlain(elem, "en", "id1"))
meta(result)

f <- system.file("texts", "rcv1_2330.xml", package = "tm")
f_bin <- readBin(f, raw(), file.info(f)$size)
rcv1 <- readRCV1(elem = list(content = f_bin), language = "en", id = "id1")
content(rcv1)
meta(rcv1)


readReut21578XML(elem, language, id)
readReut21578XMLasPlain(elem, language, id)
stopwords("en")
stopwords("SMART")
stopwords("german")

# 这种组织的形式利于进行数据挖掘
data("acq")
data("crude")
meta(acq, "comment", type = "corpus") <- "Acquisitions"
meta(crude, "comment", type = "corpus") <- "Crude oil"
meta(acq, "acqLabels") <- 1:50
meta(acq, "jointLabels") <- 1:50
meta(crude, "crudeLabels") <- letters[1:20]
meta(crude, "jointLabels") <- 1:20
c(acq, crude)
meta(c(acq, crude), type = "corpus")
meta(c(acq, crude))
c(acq[[30]], crude[[10]])
c(TermDocumentMatrix(acq), TermDocumentMatrix(crude))

# tm_filter Filter and Index Functions on Corpora
data("crude")
# Full-text search
tm_filter(crude, FUN = function(x) any(grep("co[m]?pany", content(x))))

# tm_map Transformations on Corpora
data("crude")
## Document access triggers the stemming function
## (i.e., all other documents are not stemmed yet)
tm_map(crude, stemDocument, lazy = TRUE)[[1]]
## Use wrapper to apply character processing function
tm_map(crude, content_transformer(tolower))
## Generate a custom transformation function which takes the heading as new content
headings <- function(x)
  PlainTextDocument(meta(x, "heading"),
                    id = meta(x, "id"),
                    language = meta(x, "language"))
inspect(tm_map(crude, headings))


# tm_reduce Combine Transformations
data(crude)
crude[[1]]
skipWords <- function(x) removeWords(x, c("it", "the"))
funs <- list(stripWhitespace,
             skipWords,
             removePunctuation,
             content_transformer(tolower))
tm_map(crude, FUN = tm_reduce, tmFuns = funs)[[1]]


# tm_term_score
# Compute Score for Matching Terms

data("acq")
tm_term_score(acq[[1]], c("company", "change"))
## Not run: ## Test for positive and negative sentiments
## install.packages("tm.lexicon.GeneralInquirer", repos="http://datacube.wu.ac.at", type="source")
require("tm.lexicon.GeneralInquirer")
sapply(acq[1:10], tm_term_score, terms_in_General_Inquirer_categories("Positiv"))
sapply(acq[1:10], tm_term_score, terms_in_General_Inquirer_categories("Negativ"))
tm_term_score(TermDocumentMatrix(acq[1:10],
                                 control = list(removePunctuation = TRUE)),
              terms_in_General_Inquirer_categories("Positiv"))
## End(Not run)

# tokenizer
# Tokenizers
data("crude")
Boost_tokenizer(crude[[1]])
MC_tokenizer(crude[[1]])
scan_tokenizer(crude[[1]])
strsplit_space_tokenizer <- function(x)
  unlist(strsplit(as.character(x), "[[:space:]]+"))
strsplit_space_tokenizer(crude[[1]])


loremipsum <- system.file("texts", "loremipsum.txt", package = "tm")
ovid <- system.file("texts", "txt", "ovid_1.txt", package = "tm")
us <- URISource(sprintf("file://%s", c(loremipsum, ovid)))
inspect(VCorpus(us))

# weightSMART
# SMART Weightings

data("crude")
TermDocumentMatrix(crude,
                   control = list(removePunctuation = TRUE,
                                  stopwords = TRUE,
                                  weighting = function(x)
                                    weightSMART(x, spec = "ntc"))
                   
# weightTf
# Weight by Term Frequency
# weightTfIdf

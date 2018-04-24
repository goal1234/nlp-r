# tidytext

data("sentiments")  # <---内置的字典还是不错的

library(dplyr)
library(janeaustenr)
book_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE) %>%
  ungroup()

book_words
# find the words most distinctive to each document
book_words %>%
  bind_tf_idf(word, book, n) %>%
  arrange(desc(tf_idf))


# sparse Matrix稀疏矩阵
dat <- data.frame(a = c("row1", "row1", "row2", "row2", "row2"),
                  b = c("col1", "col2", "col1", "col3", "col4"),
                  val = 1:5)
cast_sparse(dat, a, b)
cast_sparse(dat, a, b, val)

## Tidiers for LDA objects from the topicmodels package
if (requireNamespace("topicmodels", quietly = TRUE)) {
  set.seed(2016)
  library(dplyr)
  library(topicmodels)
  data("AssociatedPress", package = "topicmodels")
  ap <- AssociatedPress[1:100, ]
  lda <- LDA(ap, control = list(alpha = 0.1), k = 4)
  # get term distribution within each topic
  td_lda <- tidy(lda)
  td_lda
  library(ggplot2)
  # visualize the top terms within each topic
  td_lda_filtered <- td_lda %>%
    filter(beta > .004) %>%
    mutate(term = reorder(term, beta))
  ggplot(td_lda_filtered, aes(term, beta)) +
    geom_bar(stat = "identity") +
    facet_wrap(~ topic, scales = "free") +
    theme(axis.text.x = element_text(angle = 90, size = 15))
  # get classification of each document
  td_lda_docs <- tidy(lda, matrix = "gamma")
  td_lda_docs
  doc_classes <- td_lda_docs %>%
    group_by(document) %>%
    top_n(1) %>%
    ungroup()
  doc_classes
  # which were we most uncertain about?
  doc_classes %>%
    arrange(gamma)
}

# mallet_tidiers Tidiers for Latent Dirichlet Allocation models from the mallet package
## Not run:
library(mallet)
library(dplyr)
data("AssociatedPress", package = "topicmodels")
td <- tidy(AssociatedPress)
# mallet needs a file with stop words
tmp <- tempfile()
writeLines(stop_words$word, tmp)
# two vectors: one with document IDs, one with text
docs <- td %>%
  group_by(document = as.character(document)) %>%
  summarize(text = paste(rep(term, count), collapse = " "))
docs <- mallet.import(docs$document, docs$text, tmp)
# create and run a topic model
topic_model <- MalletLDA(num.topics = 4)
topic_model$loadDocuments(docs)
topic_model$train(20)
# tidy the word-topic combinations
td_beta <- tidy(topic_model)
td_beta
# Examine the four topics
td_beta %>%
  group_by(topic) %>%
  top_n(8, beta) %>%
  ungroup() %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta)) +
  geom_col() +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()
# find the assignments of each word in each document
assignments <- augment(topic_model, td)


library(dplyr)
parts_of_speech
parts_of_speech %>%
  count(pos, sort = TRUE)



# stm_tidiers Tidiers for Structural Topic Models from the stm package

## Not run:
if (requireNamespace("stm", quietly = TRUE)) {
  library(dplyr)
  library(ggplot2)
  library(stm)
  library(janeaustenr)
  austen_sparse <- austen_books() %>%
    unnest_tokens(word, text) %>%
    anti_join(stop_words) %>%
    count(book, word) %>%
    cast_sparse(book, word, n)
  topic_model <- stm(austen_sparse, K = 12, verbose = FALSE, init.type = "Spectral")
  # tidy the word-topic combinations
  td_beta <- tidy(topic_model)
  td_beta
  # Examine the topics
  td_beta %>%
    group_by(topic) %>%
    top_n(10, beta) %>%
    ungroup() %>%
    ggplot(aes(term, beta)) +
    geom_col() +
    facet_wrap(~ topic, scales = "free") +
    coord_flip()
  # tidy the document-topic combinations, with optional document names
  td_gamma <- tidy(topic_model, matrix = "gamma",
                   document_names = rownames(austen_sparse))
  td_gamma
}
## End(Not run)

# tidy.Corpus Tidy a Corpus object from the tm package

library(dplyr)   # displaying tbl_dfs
if (requireNamespace("tm", quietly = TRUE)) {
  library(tm)
  #'
  # tm package examples
  txt <- system.file("texts", "txt", package = "tm")
  ovid <- VCorpus(DirSource(txt, encoding = "UTF-8"),
  readerControl = list(language = "lat"))
  ovid
  tidy(ovid)
  # choose different options for collapsing text within each
  # document
  tidy(ovid, collapse = "")$text
  tidy(ovid, collapse = NULL)$text
  # another example from Reuters articles
  reut21578 <- system.file("texts", "crude", package = "tm")
  reuters <- VCorpus(DirSource(reut21578),
  readerControl = list(reader = readReut21578XMLasPlain))
  reuters
  tidy(reuters)
  tidytext
}



# unnest_tokens Split a column into tokens using the tokenizers package
library(dplyr)
library(janeaustenr)
d <- data_frame(txt = prideprejudice)
d
d %>%
  unnest_tokens(word, txt)
d %>%
  unnest_tokens(sentence, txt, token = "sentences")
d %>%
  unnest_tokens(ngram, txt, token = "ngrams", n = 2)
d %>%
  unnest_tokens(chapter, txt, token = "regex", pattern = "Chapter [\\d]")
d %>%
  unnest_tokens(shingle, txt, token = "character_shingles", n = 4)
# custom function
d %>%
  unnest_tokens(word, txt, token = stringr::str_split, pattern = " ")
# tokenize HTML
h <- data_frame(row = 1:2,
                text = c("<h1>Text <b>is</b>", "<a href='example.com'>here</a>"))
h %>%
  unnest_tokens(word, text, format = "html")


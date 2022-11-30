tweets_cleaner_tm <- function(clean_tweet, custom_stopwords = c("bla bla")){
  
  docs <- Corpus(VectorSource(clean_tweet))
  #inspect(docs)
  
  
  docs <- tm_map(docs, content_transformer(tolower)) # Convert the text to lower case
  docs <- tm_map(docs, removeNumbers) # Remove numbers
  docs <- tm_map(docs, removeWords, stopwords("english")) # Remove english common stopwords
  docs <- tm_map(docs, removeWords, custom_stopwords)  # Remove your own stop word
  docs <- tm_map(docs, removePunctuation) # Remove punctuations
  docs <- tm_map(docs, stripWhitespace) # Eliminate extra white spaces
  # docs <- tm_map(docs, stemDocument) # Text stemming
  docs
}

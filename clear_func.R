
tweets_cleaner <- function(tweet.df){
  
  tweets_txt <- unique(tweet.df$text)
  clean_tweet = gsub("&amp", "", tweets_txt) # Remove Amp
  clean_tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", clean_tweet) # Remove Retweet
  clean_tweet = gsub("@\\w+", "", clean_tweet) # Remove @
  clean_tweet = gsub("#", " ", clean_tweet) # Before removing punctuations, add a space before every hashtag
  clean_tweet = gsub("[[:punct:]]", "", clean_tweet) # Remove Punct
  clean_tweet = gsub("[[:digit:]]", "", clean_tweet) # Remove Digit/Numbers
  clean_tweet = gsub("http\\w+", "", clean_tweet) # Remove Links
  clean_tweet = gsub("[ \t]{2,}", " ", clean_tweet) # Remove tabs
  clean_tweet = gsub("^\\s+|\\s+$", " ", clean_tweet) # Remove extra white spaces
  clean_tweet = gsub("^ ", "", clean_tweet)  # remove blank spaces at the beginning
  clean_tweet = gsub(" $", "", clean_tweet) # remove blank spaces at the end
  clean_tweet = gsub("[^[:alnum:][:blank:]?&/\\-]", "", clean_tweet) # Remove Unicode Char
  
  
  clean_tweet <- str_replace_all(clean_tweet," "," ") #get rid of unnecessary spaces
  clean_tweet <- str_replace_all(clean_tweet, "https://t.co/[a-z,A-Z,0-9]*","") # Get rid of URLs
  clean_tweet <- str_replace_all(clean_tweet, "http://t.co/[a-z,A-Z,0-9]*","")
  clean_tweet <- str_replace(clean_tweet,"RT @[a-z,A-Z]*: ","") # Take out retweet header, there is only one
  clean_tweet <- str_replace_all(clean_tweet,"#[a-z,A-Z]*","") # Get rid of hashtags
  clean_tweet <- str_replace_all(clean_tweet,"@[a-z,A-Z]*","") # Get rid of references to other screennames
  
  clean_tweet
}
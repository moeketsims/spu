function(input, output, session){
  set.seed(123)
  source("clear_func.R")
  source("tweets_cleaner_tm.R")
  
  df_twiter <- read_excel("twitter_data.xlsx")
  mystopwords <- c("south", "africa")
  df_twiter$text <- as.character(df_twiter$text)
  corp <- corpus(df_twiter$text)
  tweet_dfm <- tokens(corp, remove_punct = TRUE) %>% 
                          tokens_remove(stopwords("en")) %>%
                          tokens_remove(pattern = phrase(mystopwords), valuetype = 'fixed') %>% 
                          dfm()
  
  quant_dfm <- dfm_trim(tweet_dfm, min_termfreq = 4, max_docfreq = 10)
  my_lda_fit20 <- stm(quant_dfm, K = 20, verbose = FALSE)
  
  
  fcmat <- fcm(corp, context = "window", tri = FALSE)
  feat <- names(topfeatures(tweet_dfm, 30))

  
  
  
  df_tweet <- reactive({
    df_twiter$text <- as.character(df_twiter$text)
    cleaned_tweets <- tweets_cleaner(df_twiter)
    docs <- tweets_cleaner_tm(cleaned_tweets, custom_stopwords = c("south","africa"))
    dtm <- TermDocumentMatrix(docs)
    matrix <- as.matrix(dtm) 
    words <- sort(rowSums(matrix),decreasing=TRUE) 
    df <- data.frame(word = names(words),freq=words)
    return(df)
  })
  
  output$wordcloud2 <- renderWordcloud2({
    wordcloud2(df_tweet(), color='random-dark', size = input$size, shape = 'pentagon')
    
  })
  
  
  output$plot1 <- renderPlot({
    p <- df_tweet() %>% 
      filter(freq>250) %>% 
      mutate(word=fct_reorder(word, freq)) %>% 
      ggplot( aes(x=word, y=freq)) +
      geom_segment( aes(xend=word, yend=0)) +
      geom_point( size=4, color="orange") +
      theme_bw()+
      coord_flip()+
      theme(axis.title.y = element_blank(), axis.text.x = element_text(size = 20))
    
    p
  })
  
  
  output$plot2 <- renderPlot({
    set.seed(100)
    plot(my_lda_fit20)
    
  })
  
  output$plot3 <- renderPlot({
    fcm_select(fcmat, pattern = feat) %>%
    textplot_network(min_freq = 0.8)
  })

    
  }
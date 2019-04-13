install.packages("twitteR")
install.packages("ROAuth")
library("twitteR")
library("ROAuth")
download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")
cred <- OAuthFactory$new(consumerKey='3lIVWBg5BXyHEovIiZapJgNua', consumerSecret='C6EjMkLTQKPNbjNl4l23f4EgrKwjWl42Y9zSwjjqEBjolDwzAN',requestURL='https://api.twitter.com/oauth/request_token',accessURL='https://api.twitter.com/oauth/access_token',authURL='https://api.twitter.com/oauth/authorize')

cred$handshake(cainfo="cacert.pem")
save(cred, file="twitter authentication.Rdata")


load("twitter authentication.Rdata")
#registerTwitterOAuth(cred)
setup_twitter_oauth('3lIVWBg5BXyHEovIiZapJgNua', 'C6EjMkLTQKPNbjNl4l23f4EgrKwjWl42Y9zSwjjqEBjolDwzAN', '1113916078273519622-5PonkGGePI4rNE1hx1VjkMCcjG5lFG', 'Am2hvcf4uyLIM7VOQkP6uwdVJtg5QKDx8Ug14QzcA16G9')
search.string <- "#globalwarming"
no.of.tweets <- 100
tweets <- searchTwitter(search.string, n=no.of.tweets, lang="en")
tweets

tweets.text <- sapply(tweets, function(x) x$getText())
#convert all text to lower case
tweets.text <- tolower(tweets.text)
# Replace blank space ("rt")
tweets.text <- gsub("rt", "", tweets.text)

# Replace @UserName
tweets.text <- gsub("@\\w+", "", tweets.text)
# Remove punctuation
tweets.text <- gsub("[[:punct:]]", "", tweets.text)
# Remove links
tweets.text <- gsub("http\\w+", "", tweets.text)
# Remove tabs
tweets.text <- gsub("[ |\t]{2,}", "", tweets.text)
# Remove blank spaces at the beginning
tweets.text <- gsub("^ ", "", tweets.text)
# Remove blank spaces at the end
tweets.text <- gsub(" $", "", tweets.text)

#install tm - if not already installed
install.packages("tm")
library("tm")
#create corpus
tweets.text.corpus <- Corpus(VectorSource(tweets.text))
#clean up by removing stop words
tweets.text.corpus <- tm_map(tweets.text.corpus, function(x)removeWords(x,stopwords()))

#install wordcloud if not already installed
install.packages("wordcloud")
library("wordcloud")
#generate wordcloud
wordcloud(tweets.text.corpus,min.freq = 2, scale=c(7,0.5),colors=brewer.pal(8, "Dark2"),  random.color= TRUE, random.order = FALSE, max.words = 150)


# Install packages for sentiment analysis
install.packages("ggplot2")
install.packages("plyr")
install.packages("gridExtra")
library("ggplot2")
library("plyr")
library("gridExtra")


# Load ScoreSentiment.R file that contains our specific sentiment scoring
# algorithm described in this post
source("ScoreSentiment.R")

# Load positive and negative lexicon files used to score individual words
pos = scan(file="positive-words.txt",what="charcter", comment.char=";")
neg = scan(file="negative-words.txt",what="charcter", comment.char=";")
#read tweets into data frame from file
Globalwarmingdf  

#Loading the packages used in the project
library(dplyr)
library(data.table) 
library(stringi)
library(scales)
library(RWeka)
library(quanteda)
library(tm)
library(R.utils)

# Setting the working directory
setwd("C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/finalR")
# sourceDirectory("finalR/", modifiedOnly=TRUE)

#source files containing functions used in this project
source('builtngram.R', chdir=T)
source('calprob.R', chdir=T)
source('clean-sentences.R', chdir=T)
source('extract_history.R', chdir=T)
source('genmodel.R', chdir=T)
source('last-word.R', chdir=T)
source('predictnexword.R', chdir=T)
source('splittosentence.R', chdir=T)
source('splittoword.R', chdir=T)




#Fixing the sample percentage to 0.01
sampleValue <- 0.1

#loading files blog texts
inputtext <- file("D:/Big_data/Coursera/Capstone data science/Coursera-SwiftKey/final/en_US/en_US.blogs.txt", "rb")
blogtext <- readLines(inputtext, encoding="UTF-8")
blogtext <- iconv(blogtext, 'UTF-8', 'ASCII')
close(inputtext)

#loading files news texts
inputtext <- file("D:/Big_data/Coursera/Capstone data science/Coursera-SwiftKey/final/en_US/en_US.news.txt", "rb")
newstext <- readLines(inputtext, encoding="UTF-8")
newstext <- iconv(newstext, 'UTF-8', 'ASCII')
close(inputtext)

#loading files twitter texts
inputtext <- file("D:/Big_data/Coursera/Capstone data science/Coursera-SwiftKey/final/en_US/en_US.twitter.txt", "rb")
twittertext <- readLines(inputtext, encoding="UTF-8")
twittertext <- iconv(twittertext, 'UTF-8', 'ASCII')
close(inputtext)


#Building Corpus
myCorpusNews <- corpus(newstext)
myCorpusTwitter <- corpus(twittertext)
myCorpusBlog <- corpus(blogtext)

rm(twittertext,newstext,blogtext,inputtext)

#Sampling 1% of news texts
corpusnews <- myCorpusNews[sample(nrow(myCorpusNews$documents),nrow(myCorpusNews$documents)*sampleValue)]
saveRDS(corpusnews, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/corpusnews.RDS")
rm(myCorpusNews)

#Sampling 1% of blog texts
corpusblog <- myCorpusBlog[sample(nrow(myCorpusBlog$documents),nrow(myCorpusBlog$documents)*sampleValue)]
saveRDS(corpusblog, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/corpusblog.RDS")
rm(myCorpusBlog)

#Sampling 1% of twitter texts
corpustwitter <- myCorpusTwitter[sample(nrow(myCorpusTwitter$documents),nrow(myCorpusTwitter$documents)*sampleValue)]
saveRDS(corpustwitter, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/corpustwitter.RDS")
rm(myCorpusTwitter)

#Reading the blog corpus  file
#corpusblog <- readRDS( file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/corpusblog.RDS")
# build ngram data table from blog text
ngramsblog <-builtngram (corpusblog, N = 1:3, start_tag = "debutdephrase", end_tag ="findephrase")
saveRDS(ngramsblog, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ngramsblog.RDS")
rm(corpusblog)

#Reading the news corpus  file
#corpusnews <- readRDS( file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/corpusnews.RDS")
# build ngram data table from news text
ngramsnews <-builtngram (corpusnews, N = 1:3,start_tag = "debutdephrase", end_tag ="findephrase")
saveRDS(ngramsnews, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ngramsnews.RDS")
rm(corpusnews)

#Reading the twitter corpus  file
#corpustwitter <- readRDS( file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/corpustwitter.RDS")
# build ngram data table from twitter text
ngramstwit <-builtngram (corpustwitter, N = 1:3,start_tag = "debutdephrase", end_tag ="findephrase")
saveRDS(ngramstwit, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ngramstwit.RDS")
rm(corpustwitter)


#ngramsblog <- readRDS( file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ngramsblog.RDS")
#ngramsnews <- readRDS( file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ngramsnews.RDS")
#ngramstwit <- readRDS( file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ngramstwit.RDS")


myngram <- rbind(ngramsblog,ngramsnews,ngramstwit)

#removing unecessary objects to free space
rm(ngramsblog,ngramsnews,ngramstwit)

myngram[, history_frequency := sum(history_frequency), by = phrase]

# Filtering out duplicate values
myngram <- unique(myngram)
saveRDS(myngram, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/myngram.RDS")


#myngram <- readRDS(file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/myngram.RDS")

#building the model
mymodel <- genmodel(myngram, N = 1:3,freq_cutoff = 10,rank_cutoff = 5, delimiters  = ' \r\n\t.,;:\\"()?!', start_tag = "debutdephrase", end_tag ="findephrase")

#removing object from memory to free more space
rm(myngram)


saveRDS(mymodel, file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/shinydir/mymodel.RDS")

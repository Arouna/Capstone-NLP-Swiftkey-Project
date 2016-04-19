#
#' @description
#' Transform a sample text into N-grams.  The function accepts a range
#' of N values over which to create the N-grams.
#'
#' @param Sampletext The text used to generate the language model.
#' @param N The type of N-Gram models to fit; unigram, bigram, trigram, etc.
#' @param start_tag The tag used to mark the beginning of a sentence.
#' @param end_tag The tag used to mark the end of a sentence.
#' @return A data.table containing n-grams.
#'

builtngram <- function (Sampletext, N = 1:3, start_tag = "debutdephrase", end_tag = "findephrase") {
  
  # sanity checks
  stopifnot (is.character (Sampletext))
  stopifnot (length (Sampletext) > 0)
  stopifnot (is.numeric (N))
  
  
  #Splits text into 1 or more sentences
  splitsentence <- splittosentence(Sampletext)
  
  # transform the text input into clean sentences
  cleansentence <- clean_sentences (splitsentence, start_tag, end_tag)
  
  #List of profanity words to be removed
  #profanityList <- readLines("D:/Big_data/Coursera/Capstone data science/profanity/badwords.txt",encoding="UTF-8", warn=FALSE, skipNul=TRUE)

  
  # use quanteda package to create the document feature matrix myDfm
  myDfm <- dfm(cleansentence,
               ngrams=N,
               concatenator=" ",
               stem=F)


  
  # convert myDfm to a data.frame
  mydf <- data.frame(phrase = features(myDfm), history_frequency = colSums(myDfm), 
                     row.names = NULL, stringsAsFactors = FALSE)
  # convert a data frame to data table
  myngram <- data.table(mydf)
  
  #remove all unsed object from memory
  rm(mydf,myDfm)
  
  return(myngram)
  
}

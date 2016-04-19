#' @description#'
#' Calculate MLE of N-gram Probability
#'
#' Calculates the maximum liklihood estimate of the probability of any
#' N-gram based on the training corpus.
#'
#'      p (we love you) = count (we love you) / count (we love)
#'      p (we love)     = count (we love)     / count (we)
#'      p (we)          = count (we)          / count (<start-of-sentence>)
#'
#' @param ngrams A data.table containing all historys in the corpus.
#' @return The maximum liklihood estimate of the probability of each n-gram.

calprob <- function (ngrams) {
  
  #create a data set that contains the number of times each history occurs in the text
  historytngram <- ngrams [, sum (history_frequency), by = history]
  setnames (historytngram, c("history", "historygram_frequency"))
  
  # through merging of historytngram and ngrams, calculate the probability
  setkeyv (historytngram, "history")
  setkeyv (ngrams, "history") 
  
  # calculate the maximum liklihood estimate
  ngrams [historytngram, p := history_frequency/historygram_frequency]
}
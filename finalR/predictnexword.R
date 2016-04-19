#' @description
#' Predicts the next most likely word using an N-Gram language model.
#'
#' @param object The N-gram model to use for prediction.
#' @param newdata A phrase to predict the next word for.
#' @param rank The top 'rank' most likely words are returned.
#' @return The next mostly likely word(s).
#' @export
#'
#' @examples
#' \dontrun{
#' data (blogs)
#' fit <- ngram (blogs)
#' predict (fit, "What")
#' }
#'
predictnexword <- function (object, newdata, rank = 5) {
    phrase <- newdata

    # sanity checks
    stopifnot (is.character (phrase))
    stopifnot (length (phrase) == 1)
    stopifnot (is.numeric (rank))
    
    #Profanity words for filtering the prediction
    profanityList <- readLines("D:/Big_data/Coursera/Capstone data science/profanity/badwords.txt",encoding="UTF-8", warn=FALSE, skipNul=TRUE)
    
    # clean and split the input phrase
    words <- splittoword (clean_sentences (splittosentence (phrase)))

    # HACK only remove the 'end of sentence marker' if the phrase
    # did not end with a period.  currently difficult to tell if
    # the phrase has an explicit sentence ending or if the clean_sentences
    # function is assuming there should be one.
    if (!stri_detect (phrase, regex = ".*[\\.!?][[:blank:]]*findephrase"))
        words <- head (words, -1)

    predictions <- NULL
    for (n in sort (object$N, decreasing = TRUE)) {

        # ensure there are enough previous words
        # for example, a trigram ngrams needs 2 previous words
        if (length (words) >= n-1) {

            # grab the necessary history; last 'n-1' words
            ctx <- paste (tail (words, n-1), collapse = " ")

            # find matching history in the model
            predictions <- object$ngrams [ history == ctx, list (history, word, p, n, rank)]
            if (nrow (predictions) > 0) {

               
                # No prediction for the end of the sentence symbol
                predictions [word == "findephrase", word := "."]
                predictions [history == "", word := "."]
                
              
                
                # Removing profanity words in prediction
                predictions [word %in% profanityList, word := "."]
              

                # exclude any missing predictions
                predictions <- predictions [complete.cases (predictions)]

                # only keep the top 'rank' predictions
                predictions <- predictions [rank <= rank]

                break
            }
        }
    }

    return (predictions$word)
}

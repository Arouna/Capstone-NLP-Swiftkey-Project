#' @description
#' Performs pre-processing on text input that has been already been split
#' into sentences.  Each element of the character vector input should
#' denote a single sentence.
#'
#' @param sentences The sentences to pre-process.
#' @param start_tag The tag used to mark the beginning of a sentence.
#' @param end_tag The tag used to mark the end of a sentence.
#' @return A vector of cleaned, pre-processed sentences.
#'
#'
clean_sentences <- function (sentences, start_tag = "debutdephrase", end_tag = "findephrase") {

    # sanity checks
    stopifnot (is.character (sentences))
    stopifnot (length (sentences) > 0)

    # lower case
   
    sentences <- tolower (sentences)
    
    #sentences <-rm_words(sentences, tm::stopwords("en"))
    
   
    # remove anything that is not alpha, numeric, whitespace or ' (for contractions)
    sentences <- stri_replace_all_regex (sentences, "[^A-Za-z0-9 ']+", " ")

    # replace all digits with space
    sentences <- stri_replace_all_regex (sentences, "[[:digit:]]+", " ")


    # add starting/ending tag to each sentence
    sentences <- stri_paste (start_tag, sentences, end_tag, sep = " ")

    # trim whitespace
    sentences <- stri_enc_toutf8(sentences)

    return (sentences)
}

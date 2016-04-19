#' @description
#' Given a phrase of text the function will return the last word.
#'
#' @param text The phrase containing words.
#' @return A character vector containing only the last word in the phrase.
#'
#' @export
#'
last_word <- function (text) {

    stopifnot (is.character (text))
    stopifnot (length (text) == 1)

    # split the phrase into words
    words <- splittoword (text)

    # the last word only
    words [length (words)]
}

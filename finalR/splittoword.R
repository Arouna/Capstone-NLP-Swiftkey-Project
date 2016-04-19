#' @description
#' Splits text into 1 or more words.
#'
#' @param The raw text to split into words.
#' @return A character vector containing 1 or more words.
#'
#' @export
#'
splittoword <- function (text) {

    stopifnot (is.character (text))

    words <- unlist (strsplit (text, split = "[ ]+"))
    words [nchar (words) > 0]
}

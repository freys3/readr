#' Retrieve parsing problems.
#'
#' Readr functions will only throw an error if parsing fails in an unrecoverable
#' way. However, there are lots of potential problems that you might want to
#' know about - these are stored in the \code{problems} attribute of the
#' output, which you can easily access with this function.
#'
#' @param x An data frame (from \code{read_*}) or a vector
#'   (from \code{parse_*}).
#' @return A data frame with one row for each problem and four columns:
#'   \item{row,col}{Row and column of problem}
#'   \item{expected}{What readr expected to find}
#'   \item{actual}{What it actually got}
#' @export
#' @examples
#' x <- parse_integer(c("1X", "blah", "3"))
#' problems(x)
problems <- function(x) {
  probs <- attr(suppressWarnings(x), "problems")
  if (is.null(probs)) {
    data.frame(
      row = integer(),
      col = integer(),
      expected = character(),
      actual = character(),
      stringsAsFactors = FALSE
    )
  } else {
    probs
  }
}

n_problems <- function(x) {
  probs <- attr(x, "problems")
  if (is.null(probs)) 0 else nrow(probs)
}

warn_problems <- function(x, name = "input") {
  n <- n_problems(x)
  if (n == 0)
    return(x)

  warning(n, " problems parsing ", name, ". ",
    "See problems(...) for more details.", call. = FALSE)
  x
}

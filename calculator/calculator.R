calculate <- function(request) {
  if ("a" %in% names(request) && "b" %in% names(request)) {
    ans <- as.numeric(request[["a"]]) + as.numeric(request[["b"]])
    if (is.na(ans)) {
      paste("a and b need to be numbers")
    } else {
      paste("The answer is:", ans)
    }
  } else {
    "Calculate the sum of two values a and b by given them as arguments in the URL."
  }
}


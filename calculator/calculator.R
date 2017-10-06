calculate <- function(resp, request, params) {
  resp[["body"]] <- if ("a" %in% names(params) && "b" %in% names(params)) {
    ans <- as.numeric(params[["a"]]) + as.numeric(params[["b"]])
    if (is.na(ans)) {
      paste("a and b need to be numbers")
    } else {
      paste("The answer is:", ans)
    }
  } else {
    "Calculate the sum of two values a and b by given them as arguments in the URL."
  }
  resp[["status"]] <- 200L
  resp
}


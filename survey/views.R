library(mattR)
library(shiny)

plotPage <- function(resp, req, params) {
  slope <- as.numeric(params[["slope"]])
  intercept <- as.numeric(params[["intercept"]])

  imageUrl <- if (!is.na(slope) && !is.na(intercept)) {
    plotFun <- function() {
      x <- 1:10
      y <- x * slope + intercept
      plot(x, y)
    }
    outFile <- plotPNG(plotFun)
    on.exit(unlink(outFile))
    fileUrl(outFile, "image/png")
  } else {
    ""
  }
  resp[["body"]] <- renderTemplate(file.path(getwd(),
                                             "static", "plot.html"),
                                   list(image = imageUrl))
  resp[["status"]] <- 200L
  resp
}



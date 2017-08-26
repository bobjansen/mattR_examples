library(mattR)
library(shiny)

plotPage <- function(params) {
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
  renderTemplate(file.path(getwd(), "static", "plot.html"),
                 list(image = imageUrl))
}



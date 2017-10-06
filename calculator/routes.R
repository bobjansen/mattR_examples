# Put your routes here.
source("calculator.R")

routes <- list(
  c("^/.*$", mattR::genericView(calculate))
)


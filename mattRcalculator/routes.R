# Put your routes here.
source("calculator.R")

routes <- mattR::createRoutes(
  c("^/.*$", mattR::genericView(calculate))
)


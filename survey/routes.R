# Put your routes here.
source('views.R')

routes <- list(
  c("^/$", mattR::templateView(file.path(getwd(), "static", "index.html"))),
  c("^/plot$", mattR::genericView(plotPage)),
  c("^/.*$", mattR::staticView(file.path(getwd(), "static/"), "/"))
)


# Put your routes here.

routes <- list(
  c("^/.*$", mattR::staticView(file.path(getwd(), "static/"), "/"))
)


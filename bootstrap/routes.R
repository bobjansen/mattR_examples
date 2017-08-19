# Put your routes here.

routes <- mattR::createRoutes(
  c("^/.*$", mattR::staticView(file.path(getwd(), "static/"), "/"))
)


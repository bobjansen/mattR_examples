library(knitr) # knit
library(mattR)
library(markdown) # renderMarkdown
library(whisker) # iteratelist
library(withr) # with_dir

blogPath <- 'blogs'

# Knit the blogs.
prepareFiles <- function(directory) {
  # Changing the working directory is the recommend way to knit files (assets
  # such as figures will be a subfolder of the working directory.
  withr::with_dir(directory, {
    rmds <- tools::file_path_sans_ext(list.files(pattern = '\\.Rmd$'))
    lapply(rmds, function(rmd) {
      knitr::knit(paste0(rmd, '.Rmd'), paste0(rmd, '.md'))
    })
  })
}

# Read in the partial templates for whisker.
partials <- readPartials('partials')
listBlogs <- function(resp, request, params) {
  directories <- basename(list.dirs(blogPath, recursive = FALSE))
  names(directories) <- directories
  resp[["body"]] <- renderTemplate(
    file.path("templates", "index.html"),
    list(arr = whisker::iteratelist(directories), title = 'Index'),
    partials)
  resp
}

blog <- genericView(function(resp, request, params) {
  blogPath <- file.path(blogPath, paste0(params[['title']]))
  rdFileName <- file.path(blogPath,
                          paste0(params[['title']], '.md'))
  if (!file.exists(rdFileName)) {
    return(notFoundResponse("Blog not found"))
  }

  page <- markdown::renderMarkdown(rdFileName)

  resp[["body"]] <- renderTemplate(file.path("templates", "page.html"),
                                   list(title = basename(blogPath),
                                        page = page),
                                   partials = partials)
  resp
})

# Knit the files.
lapply(list.dirs(blogPath), prepareFiles)

routes <- list(
  c("^/blog/(?<title>[A-z0-9]+)/figure/.*",
    staticView(paste0(blogPath, '/'), '/blog/')),
 c("^/blog/(?<title>[A-z0-9]+)/", blog),
  c("^/blog$", listBlogs),
  c("^.*/", listBlogs)
)


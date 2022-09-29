library(tidyverse)
library(knitr)

# This doesn't seem to work in Quarto

hook_output <- knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
  lines <- options$output.lines
  if (is.null(lines)) {
    return(hook_output(x, options))  # pass to default hook
  }
  x <- unlist(strsplit(x, "\n"))
  
  if(length(lines)==1) {
    lines_displayed <- lines
  } else {
    lines_displayed <- 0
  }
  
  more <- paste("... ", length(x) - lines_displayed, " Zeilen sind ausgeblendet.")
  if (length(lines)==1) {        # first n lines
    if (length(x) > lines) {
      # truncate the output, but add ....
      x <- c(head(x, lines), more)
    }
  } else {
    x <- c(more, x[lines], more)
  }
  # paste these lines together
  x <- paste(c(x, ""), collapse = "\n")
  hook_output(x, options)
})
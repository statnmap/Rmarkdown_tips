#' Simple color Format functions 
#'
#' @param x 
#' @param colorname 
#' @param type 
#' @return
#' @export
colFmt <- function(x, colorname, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    paste0("\\textcolor{", colorname, "}{", x, "}")
  else if (outputFormat == 'html')
    paste0("<", type, " class='", colorname, "'>", x, "</", type, ">")
  else
    x
}

#' Style format function, not specific for textcolor
#'
#' @param x 
#' @param textstyle 
#' @param type 
#' @return
#' @export
styleFmt <- function(x, textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    paste0("\\", textstyle, "{", x, "}")
  else if (outputFormat == 'html')
    paste0("<", type," class='", textstyle, "'>", x, "</", type, ">")
  else
    x
}

#' Style format options for longer text output
#'
#' @param textstyle 
#' @param type 
#' @return
#' @export
beginStyleFmt <- function(textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    if (type == "div") {
      cat("\\begin{", textstyle, "}\n", sep = "")
    } else {
      paste0("\\", textstyle, "{")
    }
  } else if (outputFormat == 'html') {
    if (type == "div") {
      cat("<", type, " class='", textstyle, "'>", sep = "")
    } else {
      paste0("<", type, " class='", textstyle, "'>")
    }
  } else {
    ""
  }
}

#' Title
#'
#' @param textstyle 
#' @param type 
#'
#' @return
#' @export
#'
#' @examples
endStyleFmt <- function(textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    if (type == "div") {
      cat("\n\\end{", textstyle, "}", sep = "")
    } else {
      paste0("}")
    }
  } else if (outputFormat == 'html') {
    if (type == "div") {
      cat("</", type, ">", sep = "")
    } else {
      paste0("</", type, ">")
    }
  } else {
    ""
  }
}

#' Specific to verbatim environment 
#' to be able to show you 'asis' chunks with background color.
#' @return
#' @export
beginVerbatim <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    cat("\\begin{blueShaded}\n\\begin{verbatim}\n")
  } else if (outputFormat == 'html') {
    cat("<div class='blueShaded'>\n```\n", sep = "")
  } else {
    ""
  }
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
endVerbatim <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    cat("\\end{verbatim}\\end{blueShaded}")
  } else if (outputFormat == 'html') {
    cat("\n```\n</div>", sep = "")
  } else {
    ""
  }
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
beginCentering <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    cat("\n\\begin{center}\n", sep = "")
  else if (outputFormat == 'html')
    cat('\n<p style="text-align: center">\n', sep = "")
  else
    ""
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
endCentering <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    cat("\n\\end{center}\n", sep = "")
  else if (outputFormat == 'html')
    cat("\n</p>\n", sep = "")
  else
    ""
}

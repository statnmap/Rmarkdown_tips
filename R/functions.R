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
    paste0("<", type, " style='color:", colorname, "'>", x, "</", type, ">")
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

#' @rdname styleFmt
#' @details
#' # This function need to be used with an additional in_header file
#' # For a PDF, this needs to be included in your header.tex file
#' \\definecolor{advertcolor}{HTML}{FF8929}
#' \\newcommand{\\advert}[1]{\\textit{\\textcolor{advertcolor}{#1}}}
#'      % -- command for pandoc trick with \begin and \end -- %
#' \\newcommand{\\nopandoc}[1]{#1} 
#' 
#' @export
beginStyleFmt <- function(textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    if (type %in% c("div", "p")) {
      cat("\\nopandoc{\\begin{", textstyle, "}}\n", sep = "")
    } else {
      paste0("\\nopandoc{\\", textstyle, "{")
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

#' @rdname styleFmt
#'
#' @export
#'
endStyleFmt <- function(textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    if (type %in% c("div", "p")) {
      cat("\n\nopandoc{\\end{", textstyle, "}}", sep = "")
    } else {
      paste0("}}")
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
#' to be able to show 'asis' chunks with background color.
#'
#' @param x 
#' @param type "span" or "p" for html output
#' @details codebox has to be defined in header.tex or css file
#' % Here for lateX %
#' \\newsavebox{\\selvestebox}
#' \\newenvironment{codebox}{
#'   \\begin{lrbox}{\\selvestebox}%
#' }{
#'   \\end{lrbox}%
#'   \\colorbox[HTML]{E0E0E0}{\\usebox{\\selvestebox}}
#' }

#' @return environment for specific format defined in header.tex or css file
#' @export
verbatimFmt <- function(x, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    paste0("\\nopandoc{\\begin{codebox}}\\verb|", x, "|\\nopandoc{\\end{codebox}}")
  else if (outputFormat == 'html')
    # http://stackoverflow.com/questions/20409172/how-to-display-verbatim-inline-r-code-with-backticks-using-rmarkdown
    paste0("<", type," class='codebox'>`` ", x, " ``</", type, ">")
  else
    x
}

#' @rdname verbatimFmt
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

#' @rdname verbatimFmt
#'
#' @export
#'
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

#' Center text on HTML or PDF output
#'
#' @return
#' @export
#'
#' @examples
beginCentering <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    cat("\n\\nopandoc{\\begin{center}}\n", sep = "")
  else if (outputFormat == 'html')
    cat('\n<p style="text-align: center">\n', sep = "")
  else
    ""
}

#' @rdname beginCentering
#'
#' @return
#' @export
#'
#' @examples
endCentering <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    cat("\n\\nopandoc{\\end{center}}\n", sep = "")
  else if (outputFormat == 'html')
    cat("\n</p>\n", sep = "")
  else
    ""
}

#' Simple color format functions
#'
#' @param x texte to be formatted
#' @param colorname colorname as known by latex or html (red, blue, ...)
#' @param type html output format. Default to span.
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

#' Style format function
#' 
#' Style is not only for textcolor
#'
#' @param x texte to be formatted
#' @param textstyle name of the style as defined in lateX header file and/or in css
#' @param type html output format. Default to span. "div" and "p" also act
#' differently with lateX outputs by using \\begin and \\end environments
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
#' For a correct rendering, this function may need to be used in a "cat"
#' environment
#' 
#' This function need to be used with an additional in_header file.\cr
#' For a PDF, this needs to be included in your header.tex file:\cr
#' \\definecolor\{advertcolor\}\{HTML\}\{FF8929\}\cr
#' \\newcommand\{\\advert\}[1]\{\\textit\{\\textcolor\{advertcolor\}\{#1\}\}\}\cr
#'      \% -- command for pandoc trick with \\begin and \\end --  \%\cr
#' \\newcommand\{\\nopandoc\}[1]\{#1\}
#' @examples
#' \dontrun{
#' cat(
#'   beginStyleFmt("formattype"), "texte to format",
#'   endStyleFmt("formattype"),
#' sep = "")
#' }
#' @export
beginStyleFmt <- function(textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    if (type %in% c("div", "p")) {
      paste0("\\nopandoc{\\begin{", textstyle, "}}\n")
    } else {
      paste0("\\nopandoc{\\", textstyle, "{")
    }
  } else if (outputFormat == 'html') {
      paste0("<", type, " class='", textstyle, "'>")
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
      paste0("\n\\nopandoc{\\end{", textstyle, "}}")
    } else {
      paste0("}}")
    }
  } else if (outputFormat == 'html') {
      paste0("</", type, ">")
  } else {
    ""
  }
}

#' Specific to verbatim environment 
#' to be able to show 'asis' chunks with background color.
#'
#' @param x text to be formatted
#' @param type "span" or "p" for html output
#' @details codebox has to be defined in header.tex or css file\cr
#' \% Here for lateX \%\cr
#' \\newsavebox\{\\selvestebox\}\cr
#' \\newenvironment\{codebox\}\{\cr
#'   \\begin\{lrbox\}\{\\selvestebox\}\%\cr
#' \}\{\cr
#'   \\end\{lrbox\}\%\cr
#'   \\colorbox[HTML]\{E0E0E0\}\{\\usebox\{\\selvestebox\}\}\cr
#' \}

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
#' @export
#'
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
#' @export
#'
endCentering <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    cat("\n\\nopandoc{\\end{center}}\n", sep = "")
  else if (outputFormat == 'html')
    cat("\n</p>\n", sep = "")
  else
    ""
}

# R-script to run it all and choose options
rm(list = ls())

# Options for rendering --------------------------------------------------------
# Choose language
lang <- c("EN", "FR")[1]
# Choose render output
render <- c("html", "pdf")[1]
# Choose to render or to produce R script only
output <- c("knit", "purl")[1]
# Choose version
version <- c("student", "teacher")[2]

# Render -----------------------------------------------------------------------
lang.latex <- ifelse(lang == "EN", "en", "fr")
title.lang <- ifelse(
  lang == "EN", 
  "Rmarkdown conditional chunks to create multilingual pdf and html with images",
  "Rmarkdown avec conditions pour créer des pdf et html en différentes langues et avec des images")
# Adapt ouput to your system:
  # Here I use firefox to open html and evince for pdf
if (output == "knit") {
  purlT <- TRUE; purlS <- FALSE
  if (render == "html") {
    filename <- paste0("Rmd_tips_", lang, ".html")
    rmarkdown::render(
      "Rmd_tips.Rmd", output_format = "html_document",
      output_file = filename)
    system(paste("firefox", filename, "&"))
    if (file.exists("Rmd_tips_EN.md")) {
      file.rename(from = "Rmd_tips_EN.md", to = "README.md")   
    }
  } else if (render == "pdf") {
    filename <- paste0("Rmd_tips_", lang, ".pdf")
    rmarkdown::render(
      "Rmd_tips.Rmd", output_format = "bookdown::pdf_document2",
      output_file = filename, clean = FALSE)
    system(paste("evince", filename, "&"))
  }
}
if (output == "purl") {
  knitr::opts_chunk$set(
    purl = FALSE
  )
  if (version == "teacher") {
    purlT <- TRUE; purlS <- FALSE 
  } else {
    purlT <- FALSE; purlS <- TRUE
  }
  filename <- paste0("ScriptR_", version, ".R")
  if (file.exists(filename)) {file.remove(filename)}
  knitr::purl("Rmd_tips.Rmd", documentation = 0)
  file.rename(from = "Rmd_tips.R", to = filename)   
}

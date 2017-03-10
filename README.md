# `r title.lang`
Sébastien Rochette - StatnMap  
`r format(Sys.time(), "%d %B, %Y")`  


<img src="./myfigdirectory/gb.png" width="24" /> This version is the english version.  

<!-- english -->
# Knit with multiple rendering options
I want to be able to knit my rmarkdown documents in different speaking language (english and french). I also want them to give similar rendering in html and in latex pdf so that I can use them in my courses as html version on the laptop, but also as printed version through the latex pdf. By the way, I also have a teacher and a student version for the R-scripts that I can purl from the Rmd file.  
This means many options for a **unique** rmarkdown document. Using a unique document allow me to directly modify things for the different versions at the same place. I do not have to jump from a file to another and verify that I copied every modification in the R-script or other...  
I personnaly use an external _"run-all"_ R-script to choose options to run the different versions and rename output files.

## A non exhaustive list
In this article, I list some of the tips I have to use to make this work and some bonus:

- Use chunks options to render text according to speaking language chosen,
- Use functions to render text color, background or format similar in pdf and html outputs,
- Print inline (or not) images depending on speaking language,
    + Render two images side by side and centered on the page for html and pdf,
- Allow verbatim chunk environment with background color for html and pdf,
- Output R-script included in chunks for tutorials, with different versions for teacher and students.

I will modify this list if I face new difficulties or I find better ways to do things.  
Files needed to create this article are stored [here on my github](https://github).
<!-- french -->



```r
packageVersion("knitr")
```

```
## [1] '1.15.1'
```

<!-- english -->
## Functions for html or pdf specific rendering
Because some text and background colors are not written in the same way for html and lateX outputs, I need to use functions that will add either html formatting or latex formatting:  

- "colFmt" is used directly with color names like blue, red, ...
- "styleFmt" is used in combination with definition of a style in external files.
- "beginStyleFmt" and "endStyleFmt" are a separated variante of "styleFmt" to be used if your text contain special characters (like underscore) that may be misinterpretated by lateX.  
Option "type" can be defined to use "div" instead of "span" to allow multiple lines with html output. Similarly for latex, if $type == "div"$ is defined, command will be used with "begin" and "end".  
- "beginVerbatim" and "endVerbatim" are specific to embed verbatim code text with background color, which is not implemented by default in lateX.
<!-- français -->


```r
# Simple color Format functions 
colFmt <- function(x, colorname, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    paste0("\\textcolor{", colorname, "}{", x, "}")
  else if (outputFormat == 'html')
    paste0("<", type, " class='", colorname, "'>", x, "</", type, ">")
  else
    x
}
# Style format function, not specific for textcolor
styleFmt <- function(x, textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    paste0("\\", textstyle, "{", x, "}")
  else if (outputFormat == 'html')
    paste0("<", type," class='", textstyle, "'>", x, "</", type, ">")
  else
    x
}
# Style format options for longer text output
beginStyleFmt <- function(textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    if (type == "div") {
      cat("\\begin{", textstyle, "}", sep = "")
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
endStyleFmt <- function(textstyle, type = "span") {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer')) {
    if (type == "div") {
      cat("\\end{", textstyle, "}", sep = "")
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
# Specific to verbatim environment 
# to be able to show you the 'asis' chunks with background color.
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
```

<!-- english -->
The definition of different styles are in external lateX header file for pdf outputs and should be called in the YAML header of your rmarkdown file <span class='codecommand'>in\_header: header.tex</span>. This lateX file should include the definition of all colors and format to be used with the previous functions. For instance, here:
<!-- french -->


```latex
  \usepackage{color}
  \definecolor{blueSeb}{RGB}{30,115,190}
  \definecolor{advertcolor}{HTML}{FF8929}
  
  \definecolor{backcolor}{RGB}{235, 235, 235}
  \newcommand{\mybox}[1]{\par\noindent\colorbox{backcolor}
    {\parbox{\dimexpr\textwidth-2\fboxsep\relax}{#1}}}
  
  \newcommand{\advert}[1]{\textit{\advertcolor{#1}}}
  \newcommand{\codecommand}[1]{\texttt{\colorbox{backcolor}{#1}}}
```
<!-- english -->
Similarly, for html rendering, functions should be used in an external css file with option <span class='codecommand'>css: style.css</span> in the YAML header of your rmarkdown file. Here for instance the css file includes:
<!-- french -->


```css
  .advert {
    color: #FF8929;
    font-style: italic;
  }
  .codecommand {
    background-color:#E0E0E0;
    font-family: Courier New, Courier, monospace;
  }
  .Shaded {
    background-color:#E0E0E0;
    font-family: Courier New, Courier, monospace;
  }
```

<!-- english -->
# Choose a language to knit
If you want to be able to knit your documents in different language without using two different rmarkdown files, here are my tips.
<!-- french -->


<div class='blueShaded'>
```
    ```{r R-Lang, echo=TRUE, eval=FALSE}
    # Choose the language at the beginning of your script or knit from external file
    lang <- c("EN", "FR")[1]
    ```
```
</div>

<!-- english -->
## Embed text in 'asis' chunks
In 'asis' chunks, with option <span class='codecommand'>echo=TRUE</span>, you can write rmarkdown syntax which produces text (partially) in the correct format. The aim is to use the command <span class='codecommand'>eval</span> to render the text according to the chosen language:  
<!-- french -->


<div class='blueShaded'>
```
  <!-- english -->
  ```{asis, eval=(lang == "EN"), echo=TRUE}
  ### For titles and subtitles when at the beginning
  This above chunk allow for markdown syntax  
  
  ### And for titles in the middle if there is space line above
  And you can use it for normal text or _italic_ or **other**
  ```
  <!-- french -->
  ```{asis, eval=(lang == "FR"), echo=TRUE}
  ### Pour les titres et sous-titres au début du "chunk"
  Le "chunk" ci-dessus permet d'utiliser la syntaxe markdown
  
  ### Et les titres en milieu de "chunk" s'il y a une ligne vide avant
  Et vous pouvez utiliser le texte normal, _italic_ ou **autre**
  ```
```
</div>
<!-- english -->
### For titles and subtitles when at the beginning
This above chunk allow for markdown syntax  

### And for titles in the middle if there is space line above
And you can use it for normal text or _italic_ or **other**
<!-- french -->


<!-- english -->
## Conditional images and path
### When images are in a defined directory and are shown in paragraph different that text
<!-- french -->


<div class='blueShaded'>
```
  ```{asis, eval=(lang == "EN")}
  ![](./myfigdirectory/gb.png) Directory for english version
  ```
  ```{asis, eval=(lang == "FR")}
  ![](./myfigdirectory/fr.png) Fichier pour la version française
  ```
```
</div>




<!-- english -->
### When images are in a changing directory and are shown inline
Only code of the last point is shown here, but you can find the others in the raw Rmarkdown file used to create this page.
<!-- french -->



```r
figWD <- paste0("./myfigdirectory", lang)
```

- ![](./myfigdirectoryEN/fr.png) Image without condition
- <img src="./myfigdirectoryEN/fr.png" width="24" /> No condition but allow to resize image (if <span class='codecommand'>out.width</span> is not set in general knitr options).  

<div class='blueShaded'>
```
  - `r 
    if (lang == "EN") {
      knitr::include_graphics(paste0(figWD, '/gb.png'), dpi = 400)
    } else if (lang == "FR") {
      knitr::include_graphics(paste0(figWD, '/fr.png'), dpi = 400)
    }`
    `r 
    if (lang == "EN") {
      "Conditionnal image: English flag shown if 'lang' is 'EN'"
    } else if (lang == "FR") {
      "Image avec condition : Le drapeau français est affiché si 'lang' est 'FR'"
    }`
```
</div>
- <img src="./myfigdirectoryEN/gb.png" width="24" /> Conditionnal image: English flag shown if 'lang' is 'EN'

<!-- Conditional title -->
## Include R outputs in conditional chunk

<!-- english -->
<div class='blueShaded'>
```
    ```{r CodeInChunkEN, echo=(lang == "EN"), eval=(lang == "EN"), results='asis'}
    cat(
    '### Example of title in a chunk
    #### Example of subtitle in a chunk
    - ', styleFmt("cat", "codecommand"), ' should be used with ',
    styleFmt("sep = \"\"", "codecommand"), ' otherwise a space will be added 
    before "##subtitle", which avoid it to be recognised as a subtitle in markdown.
    - ', styleFmt("eval", "codecommand"), ' can be used with R object to knit 
    chunk specific to language. Here ', styleFmt("lang", "codecommand"), 
    ' is ', lang,  '\n',
    '- Double space should work to define new paragraph, but when using R
    functions, it may require "\\\\n" 
    _(Note the number of backslash in the code here to print "\\\\n" correctly...)_.
        + ', styleFmt("For instance when using the format function,
                      following two spaces won\'t work:", "advert"), '  ',
    '    + This sentence won\'t be on a new line.',
    sep = "")
    ```
```
</div>### Example of title in a chunk
#### Example of subtitle in a chunk
- <span class='codecommand'>cat</span> should be used with <span class='codecommand'>sep = ""</span> otherwise a space will be added 
before "##subtitle", which avoid it to be recognised as a subtitle in markdown.
- <span class='codecommand'>eval</span> can be used with R object to knit 
chunk specific to language. Here <span class='codecommand'>lang</span> is EN
- Double space should work to define new paragraph, but when using R
functions, it may require "\\n" 
_(Note the number of backslash in the code here to print "\\n" correctly...)_.
    + <span class='advert'>For instance when using the format function,
                  following two spaces won't work:</span>      + This sentence won't be on a new line.
<!-- french -->


<!-- english -->
# Two images side-by-side and centered
A problem while using two images side by side using  <span class='codecommand'>knitr::include_graphics</span>  in the same chunk is that option  <span class='codecommand'>fig.align = 'center'</span>  applies separately to the two images, so that there are one under the other, in two different paragraphs:
<!-- french -->


<img src="./myfigdirectoryEN/fr.png" width="25%" style="display: block; margin: auto;" /><img src="./myfigdirectoryEN/gb.png" width="25%" style="display: block; margin: auto;" />

<!-- english -->
Here, we use two functions to be place before and after the chunk with  <span class='codecommand'>results='asis'</span>  and a space between images:
<!-- french -->


```r
beginCentering <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    cat("\n\\begin{center}\n", sep = "")
  else if (outputFormat == 'html')
    cat('\n<p style="text-align: center">\n', sep = "")
  else
    ""
}
endCentering <- function() {
  outputFormat <- knitr:::pandoc_to()
  if (outputFormat %in% c('latex', 'beamer'))
    cat("\n\\end{center}\n", sep = "")
  else if (outputFormat == 'html')
    cat("\n</p>\n", sep = "")
  else
    ""
}
```
<!-- Simple conditional text -->
The chunk is then written as follows:

<div class='blueShaded'>
```
  ```{r, echo=FALSE, out.width='25%', fig.align='default', results='asis'}
  beginCentering()
  knitr::include_graphics(paste0(figWD, "/fr.png"))
  cat("\vspace{1cm}")
  cat(" ")
  knitr::include_graphics(paste0(figWD, "/gb.png"))
  endCentering()
  ```
```
</div>
<!-- We can not echo this with the two include_graphics functions -->

<p style="text-align: center">
<img src="./myfigdirectoryEN/fr.png" width="25%" />\vspace{1cm} <img src="./myfigdirectoryEN/gb.png" width="25%" />
</p>

<!-- english -->
# Student and teacher versions
## Create the tutorial roadmap
This one is pretty easy. You only have to set your <span class='codecommand'>purl</span> option depending if your chunk is for student or teacher. I personnally use <span class='codecommand'>eval=TRUE</span> with the teacher version that should produce the result targeted by students. And I use <span class='codecommand'>eval=FALSE</span> with the student version because this version should not work.

### Exercise example
Reproduce the following figure from the "cars" dataset.
<!-- french -->


<!-- teacher -->

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```

<img src="Rmd_tips_EN_files/figure-html/unnamed-chunk-6-1.png" width="50%" />
<!-- student -->


<!-- english -->
## Purl the rmarkdown file
If you purl this rmarkdown file using the "teacher" option, you'll get this R script:
<!-- french -->



```r
# A script for teacher with solutions ------------------------------------------
summary(cars)
# Plot pressure against temperature
plot(pressure)
```

<!-- Simple conditional text -->
And this R script if you purl with the "student" option:


```r
# A script for students without solutions --------------------------------------
summary(cars)
# Plot pressure agains temperature
plot(...)
```

<!-- english -->
# Try this script !
All files necessary to produce this page are available on my github. All outputs in french and english, in pdf and html, as well as student and teacher R-script are also in the repository. Use the <span class='advert'>"Run\_all\_and\_choose\_options.R"</span> file to produce them on your own.  

## Some limits
One of the drawback of this kind of multilingual rmarkdown script is that code highlighting is messy in Rstudio... This specific one in very messy because I wanted to show you the complete chunks in the output file, but it is quite difficult to do it in a clean way as "asis" chunks do not allow for "echo" and "verbatim" options.
If you have any better way to do it, you can comment here or in the github repository itself.  
**By the way, if your file starts to be too big like the present one, do not hesitate to work with child Rmd files.**

# Supplemental tips
LateX default template of rmarkdown load several packages and defines several parameters to format the final text output. If you do not want to create your own template, you can define, like here a tex file to load <span class='codecommand'>"in\_header"</span>.  
However, you may encounter some error messages due to incompatible options. In the "header_tips.tex" file provided with the present templates, you will find different modifications of the pdf template:

- Find which language is loaded with lateX package babel and define new commands according to language chosen. This is useful here because we have a multilingual template that uses parameter <span class='codecommand'>lang</span> in the YAML, which I parameterized according to language to knit.   
- Formatting section titles to be colored or defined as you want with package "titlesec" requires to unload section format that rmarkdown provided and revert it back.  
- Modify background color of rmarkdown verbatim box.  

***
More tips on [R, models and spatial things on my website](https://statnmap.com/en/)

***

_Because my website uses two languages with q-translateX plugin in wordpress, I cheated a little with the images included in this page. However, the full html page produced by rstudio is visible here: [https://statnmap.com/](https://statnmap.com/)_
<!-- french -->


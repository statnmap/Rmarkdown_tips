# Rmarkdown conditional chunks to create multilingual pdf and html with images
[https://statnmap.com/](https://statnmap.com/2017/03/rmarkdown-conditional-chunks-to-create-multilingual-pdf-and-html-with-images/)  

<img src="./myfigdirectory/gb.png" width="24" /> This version is the english version.  

# Knit with multiple rendering options
I want to be able to knit my rmarkdown documents in different speaking language (english and french). I also want them to give similar rendering in html and in latex pdf so that I can use them in my courses as html version on the laptop, but also as printed version through the latex pdf. By the way, I also have a teacher and a student version for the R-scripts that I can purl from the Rmd file.  
This means many options for a **unique** rmarkdown document. Using a unique document allow me to directly modify things for the different versions at the same place. I do not have to jump from a file to another and verify that I copied every modification in the R-script or other...  
I personnaly use an external _"run-all"_ R-script to choose options to run the different versions and rename output files.

# A non exhaustive list
In this article, I list some of the tips I have to use to make this work and some bonus:

- Use chunks options to render text according to speaking language chosen,
- Use functions to render text color, background or format similar in pdf and html outputs,
- Print inline (or not) images depending on speaking language,
    + Render two images side by side and centered on the page for html and pdf,
- Allow verbatim chunk environment with background color for html and pdf,
- Output R-script included in chunks for tutorials, with different versions for teacher and students.

# Table of content
<ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#knit-with-multiple-rendering-options"><span class="toc-section-number">1</span> Knit with multiple rendering options</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#a-non-exhaustive-list"><span class="toc-section-number">1.1</span> A non exhaustive list</a></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#functions-for-html-or-pdf-specific-rendering"><span class="toc-section-number">1.2</span> Functions for html or pdf specific rendering</a></li>
</ul></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#choose-a-language-to-knit"><span class="toc-section-number">2</span> Choose a language to knit</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#embed-text-in-asis-chunks"><span class="toc-section-number">2.1</span> Embed text in ‘asis’ chunks</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#for-titles-and-subtitles-when-at-the-beginning"><span class="toc-section-number">2.1.1</span> For titles and subtitles when at the beginning</a></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#and-for-titles-in-the-middle-if-there-is-space-line-above"><span class="toc-section-number">2.1.2</span> And for titles in the middle if there is space line above</a></li>
</ul></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#conditional-images-and-path"><span class="toc-section-number">2.2</span> Conditional images and path</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#when-images-are-in-a-defined-directory-and-are-shown-in-paragraph-different-that-text"><span class="toc-section-number">2.2.1</span> When images are in a defined directory and are shown in paragraph different that text</a></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#when-images-are-in-a-changing-directory-and-are-shown-inline"><span class="toc-section-number">2.2.2</span> When images are in a changing directory and are shown inline</a></li>
</ul></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#include-r-outputs-in-conditional-chunk"><span class="toc-section-number">2.3</span> Include R outputs in conditional chunk</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#example-of-title-in-a-chunk"><span class="toc-section-number">2.3.1</span> Example of title in a chunk</a></li>
</ul></li>
</ul></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#two-images-side-by-side-and-centered"><span class="toc-section-number">3</span> Two images side-by-side and centered</a></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#student-and-teacher-versions"><span class="toc-section-number">4</span> Student and teacher versions</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#create-the-tutorial-roadmap"><span class="toc-section-number">4.1</span> Create the tutorial roadmap</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#exercise-example"><span class="toc-section-number">4.1.1</span> Exercise example</a></li>
</ul></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#purl-the-rmarkdown-file"><span class="toc-section-number">4.2</span> Purl the rmarkdown file</a></li>
</ul></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#try-this-script"><span class="toc-section-number">5</span> Try this script !</a><ul>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#some-limits"><span class="toc-section-number">5.1</span> Some limits</a></li>
</ul></li>
<li><a href="https://statnmap.com/wp-content/uploads/rmarkdown/Rmd_tips_EN.html#supplemental-tips"><span class="toc-section-number">6</span> Supplemental tips</a></li>
</ul>


***
More tips on [R, models and spatial things on my website](https://statnmap.com/en/)


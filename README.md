# Rmarkdown conditional chunks to create multilingual pdf and html with images
[https://statnmap.com/](https://statnmap.com/2017-03-11-rmarkdown-conditional-chunks-to-create-multilingual-pdf-and-html-with-images)  

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

# Output files in pdf, html, french and english
The [tutorial is presented on my website](https://statnmap.com/2017-03-11-rmarkdown-conditional-chunks-to-create-multilingual-pdf-and-html-with-images), but the complete outputs are here on this github repository:

- Rmd_tips_EN.html: HTML english version
- Rmd_tips_FR.html: HTML french version
- Rmd_tips_EN.pdf: PDF english version
- Rmd_tips_FR.pdf: PDF french version


# Table of content
1. Knit with multiple rendering options
    - 1.1 A non exhaustive list
    - 1.2 Functions for html or pdf specific rendering
2. Choose a language to knit
    - 2.1 Embed text in 'asis' chunks
        + 2.1.1 For titles and subtitles when at the beginning
        + 2.1.2 And for titles in the middle if there is space line above 
    - 2.2 Include R outputs in conditional chunk
        + 2.2.1 Example of title in a chunk
    - 2.3 Conditional images and path
        + 2.3.1 When images are in a defined directory and are shown in paragraph different that text
        + 2.3.2 When images are in a changing directory and are shown inline
3. Two images side-by-side and centered
4. Student and teacher versions
    - 4.1 Create the tutorial roadmap
        + 4.1.1 Exercise example
    - 4.2 Purl the rmarkdown file
5. Try this script !
    - 5.1 Some limits
6. Supplemental tips

***
More tips on [R, models and spatial things on my website](https://statnmap.com/)


# Rmarkdown conditional chunks to create multilingual pdf and html with images
Sébastien Rochette - StatnMap  

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

***
More tips on [R, models and spatial things on my website](https://statnmap.com/en/)


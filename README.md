This repository contains the introduction and demo files used for "Statistical Methods for Time Series Analysis of Rhythms" (SMTSA) workshop in 2016 SRBR meeting. 

## Introduction
The SMTSA workshop will be hosted by Dr. Tanya Leise and Dr. John Hogenesch. This 90 minute workshop will firstly give an overview of various statistical methods used for analyzing biological time-series data. The respective strengths and limitations of each mentioned approach will also be discussed. Then the workshop will give a demo of evaluating periodicity in large scale data. During the demo, we will show how to analyze time-series datasets with various sampling patterns using [MetaCycle](http://biorxiv.org/content/early/2016/02/19/040345) and do phase enrichment analysis with [PSEA](http://jbr.sagepub.com/content/31/3/244.long). At last, all participants are welcome to bring their own datasets and/or questions of analyzing time-series datasets into the workshop. We will leave 10 to 15 minutes in this workshop to try your own dataset or answering your questions.

## Before the workshop

##### 1. Pre-installed software
* Please visit [CRAN](https://cran.cnr.berkeley.edu) to download the latest R(3.3.0) and install it on your notebook computer.
* Please visit [RStudio](https://www.rstudio.com/products/rstudio/download/)(an Integrated Development Environment that makes programming easier) to download the latest RStudio Desktop and install it on your notebook computer.
* Please visit [Java](http://java.com/en/download/manual.jsp) website to download the latest Java(≥ 1.5) and install it on your notebook computer.
* If there is only Internet Explorer(IE) web browser on your laptop, please download and install another web browser (eg. [Chrome](https://www.google.com/chrome/browser/desktop/) or [Firefox](https://www.mozilla.org/en-US/firefox/new/)) on your notebook computer. 

##### 2. Pre-installed R packages

Open the RStudio, look at the 'Console' part and make sure the listed R version is 'R version 3.3.0'. If there are multiple R versions installed on your laptop, please follow [Using Different Versions of R](https://support.rstudio.com/hc/en-us/articles/200486138-Using-Different-Versions-of-R) to switch R version to the latest one. Then in the 'Console' part, type below command to install required packages.

```r
# install 'shiny' package
install.packages("shiny")
# type below command to install 'MetaCycle' package
install.packages("MetaCycle")
# install 'dplyr' package
install.packages("dplyr")
# install 'ggplot2' package
install.packages("ggplot2")
# install 'cowplot' package
install.packages("cowplot")
# install 'Bioconductor'
# try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()

```

Please contact the workshop assistant (Gang Wu: wggucas@gmail.com) if you have problems in installing softwares, packages to your notebook computer.

##### 3. A little knowledge about R language

Knowing a little knowledge about R language will be great helpful for touring this workshop. If you have not used R before and are interested with learning R, taking a quick tour in [DataCamp](https://www.datacamp.com/home), or [Try R](http://tryr.codeschool.com/levels/1/challenges/3) or [R tutorials](http://www.r-bloggers.com/how-to-learn-r-2/) may save your time. If you are not interested with learning R language except those commands frequently used in this workshop, please try below command in the RStudio.

```r
# If there is a directory named 'SRBR_SMTSAworkshop' in the 'Desktop' directory of your laptop, 
# you could change the working directory to 'SRBR_SMTSAworkshop' through
# clicking 'Session | Set Working Directory | Choose Directory...', or by typing below command
setwd("~/Desktop/SRBR_SMTSAworkshop") 

# how to load an installed package
library(MetaCycle)

# how to find the help documentation about a function (eg. 'filter' function in 'dplyr' package)
library(dplyr)
?filter

# how to use the function by following the example part in the documentation file
filter(mtcars, cyl < 6)

# how to write the data to a file
write.csv(mtcars, file="mtcars.csv")

# how to read a file into a data frame
dataD <- read.csv("mtcars.csv")
# look at the top six rows of a data frame
head(dataD)

```

##### 4. Take a look at the demo files

The demo files will be uploaded under 'demo' directory of this repository, five days before this workshop. 

##### 5. Download three repositories to your notebook computer

Click [SRBR_SMTSAworkshop](https://github.com/gangwug), [MetaCycleApp](https://github.com/gangwug/MetaCycleApp) and [PSEA](https://github.com/ranafi/PSEA) one by one, and click 'Download ZIP' button within each repository. 

##### 6. Prepare your own datasets if you hope to try your them at the end of this workshop.

##### 7. Keep track of this page, which will show update news at the end of this page.


## Day of the workshop
* Bring a fully charged notebook computer to the workshop.
* If your default web browser is IE, please [set default web browser](https://support.google.com/chrome/answer/95417?hl=en) to Chrome, Firefox or another one (IE does not work well with 'shiny' package). 

## Update news


---
title: R/RStudio
layout: default
active: r-rstudio
permalink: /r-rstudio/
---

# {{ page.title }}

<!-- ![RStudio](/images/rstudio.jpg){:. width="30%"} -->

{% include image.html url="/images/rstudio.jpg" caption="RStudio" width=350 align="right" %}

The lab sessions themselves will take place in rooms with computers in them for the student to use, though there is a (reasonable, implicit) assumption that the student has a personal computer. Tablets are not advised for these purposes as it is difficult to install the required third-party software needed for this course, which would be a major issue no matter the third-party software the student used for statistical analysis. Tablets will also typically lack the kind of memory and processing power for computational uses like this. 

Lab sessions and problem sets (more in the next section) will all be done in the `R` programming language. Students should download this free software programming language at [cran.r-project.org](http://cran.r-project.org) and install it on their personal computer. Binaries are available for Windows and Mac (even Linux, if that is the weapon of choice for the student). The instructor will be teaching around R version 4.1.2. It's fine if you have a more current version that you install. If you have an older version than this, you should really upgrade to a more current version (just in case).

- The `R` scripts I provide are designed to work on the student’s computer with minimal maintenance. This should be clear in each particular script.
- The lab instructor *strongly* encourage students to contact him to learn about the language. He will assume that not discussing `R` with him means the student is fluent with the software and capable of proceeding through the course without additional oversight.
- Though not strictly mandatory for the course, consider getting a graphical user interface (GUI) front-end for `R` to learn it better. The instructor recommends (and will use) RStudio, which is available for free at [`posit.co`](https://posit.co/download/rstudio-desktop/). Do note there is a paid option of Rstudio that you *do **not** want.* The paid version is for servers. You want the basic open source integrated development environment (IDE). *This is **free***. Do not pay for anything related to R or Rstudio since you do not need whatever product is available for purchase.

The lab instructor published a [beginner's guide to using `R`](http://svmiller.com/blog/2014/08/a-beginners-guide-to-using-r/) in 2014 when he first started to teach courses that forced students to use the `R` programming language. He has since streamlined the `R` requirements for this class, making that guide somewhat dated. You will need to install the following packages, which are illustrated here with the `R` commands to install them. 

```r
install.packages("tidyverse")      # for most things workflow
# ^ This is a huge installation. It should take a while.
install.packages("stevedata")      # for toy data sets to use in-class
install.packages("stevemisc")      # for some helper functions
install.packages("stevethemes")    # for theme elements and example data
install.packages("modelsummary")   # For presenting data/models
install.packages("stevetemplates") # OPTIONAL: for preparing reports
```

The aforementioned `R` packages are not exhaustive of all packages a student may use this semester, and the lab instructor reserves the right to ask students to install additional packages along the way (though these requests will ideally be rare). He will make this clear in each lab session and problem set. `{stevetemplates}` is an optional package, though students should find it useful for preparing presentation-quality documents that include R code.

The `{tidyverse}` package will easily be the most time-consuming package to install, and the one most likely to give some students a potential problem during the course of its installation. In the strictest sense of the word "mandatory", this package is not "mandatory". It is possible to achieve the same results of this package by using either other packages in R or some functions that are default in R. However, not using this singular package---itself a wrapper for package for dozens of other R packages---would require the student to either download and install other R packages or require the student to learn code that is *much* less legible and intuitive than `{tidyverse}` code. Downloading and installing `{tidyverse}` is ultimately worth the effort, especially for beginners.

Based on experience, students may expect the following issues if the installation of this package results in an installation error ("non-zero exit status"), contingent on their operating system.

- *Mac*: You probably need to update Xcode. Xcode is a developer tool suite for Apple, and many of the `{tidyverse}` packages require access to developmental libraries that, to the best of my understanding, are available in Xcode. In all likelihood, you’re a first-time user who has not had to think about software development (and so you haven’t updated Xcode since you first got your Macbook). You might have to do that here. 
- *Windows*: The Windows corollary to Xcode is Rtools, which you don’t have installed by default (because it’s not a Microsoft program, per se). You’ll need to install it. First, take inventory of what version of R you have (for the university’s computer labs, it should be 4.0.5). [Go to this website](https://cran.r-project.org/bin/windows/Rtools/) and download the version of Rtools that corresponds with the version of R you have. Just click through all the default options so that it can install.
- *Linux*: If you self-select into being a Linux user, you are aware of the consequences of your actions and that you may need to install various developmental libraries by yourself. The saving grace is that R packages that fail to install for the absence of developmental libraries they need will explicitly tell you what libraries you need, which are (practically) always in your package manager for you to install. This will very much depend on what particular distribution of Linux you're using. If your distribution of Linux is a fork of Debian, [I have this guide for you](http://svmiller.com/blog/2019/07/notes-to-self-new-linux-installation-r-ubuntu/) based on his trials and tribulations over the years.

Past experiences with teaching students how to install R, RStudio, and these R packages have led to an appreciation of assorted difficulties and idiosyncrasies that are 1) solvable but 2) often more trouble than it's worth. If you have an anti-virus program that's blocking third-party software downloads, you should know you have that. It's really not possible for the instructor to know that because the instructor would have to respect your privacy and your personal property. If you are a Mac user, you should really take inventory of what exactly your Mac is (i.e. you should know what version your operating system is and what your chipset is). Click the Applie icon at the top left of your screen to find out more. There is only so much the instructor can do on your behalf because they are not also paid as IT professionals.

If, for some reason, you are unable to install R, RStudio, or a package that I'll be using, [sign up for a *free* account on Posit Cloud](https://posit.cloud/plans/free). Posit Cloud will give you 25 project hours a month, which should be more than enough when combined with the resources available in the computer lab.[^webr]

[^webr]: [`WebR`](https://docs.r-wasm.org/webr/latest/) can help you with a few things but it's not as capable. You can experiment with it, though.

### Dollar Signs (`$`) and Tildes (`~`)

There is not a way of learning R without accessing characters that are not common or intuitive on a Scandinavian keyboard. R uses dollar sign (`$`) as a separator in a data frame, connecting to a particular column in the data frame. For example, `Data$gdppc` would be a vector referring to a column called `gdppc` in an object in the R session, an assumed data frame, called `Data`. Likewise, there is just no way to do any regression analysis or *t*-test without the tilde (`~`). The tilde even features in statistical notation in textbooks, communicating that some out variable is regressed on (`~`) some variable(s). These are a little easier to find on American keyboards, but not so easy to find or locate on a Scandinavian keyboard.

- **Mac users**: the dollar sign (`$`) should be `⌥ Option (Alt) + 4`. The (`~`) should be `⌥ Option (Alt) + "` (the key to the right of `Å`). For the latter, you may have to hit space for it to appear (which you should be doing anyway).
- **Other users (not Mac)**: the operator you want is the `Alt Gr` key (the right-hand Alt key). `Alt Gr + 4` gives you the dollar sign (`$`). `Alt Gr + "` (just right of `Å`) gives you the tilde (`~`).



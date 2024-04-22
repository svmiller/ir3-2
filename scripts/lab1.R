#' ---
#' title: "Getting Started in R and Rstudio"
#' layout: lab
#' permalink: /lab-scripts/lab-1/
#' active: lab-scripts
#' abstract: "This is a lab script for [EH6105](http://eh6105.svmiller.com), a graduate-level quantitative 
#' methods class that I teach at Stockholm University. It will not be the most sophisticated 
#' R-related write-up of mine---check [my blog](http://svmiller.com/blog) for those---but it should be useful 
#' for discussion around the associated R script for the week's 'lab' session."
#' output:
#'    md_document:
#'      variant: gfm
#'      preserve_yaml: TRUE
#' ---

#+ setup, include=FALSE
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
#+
# ==============================
# Lab 1: Getting Started in R and Rstudio
#  - Steven V. Miller (EH 1903)
# ==============================
#    \
#      \
#        \
#     /\-/\
#    /a a  \                     _
#   =\ Y  =/-~~~~~~-,___________/ )
#     ‛^--‛          ___________/ /
#      \           /
#      ||  |---‛\  \
#     (_(__|   ((__|


#' Notice the pound sign/hashtag (#) starting every line? That starts a comment.
#' Lots of programming languages have comment tags. In HTML, for example, it's
#' a bracket of <!-- comment -->. In CSS, it's /* comment */. In LaTeX, it's
#' a percentage sign (%). In R, it's this character. Make liberal use of this as
#' it allows you to make comments to yourself and explain what you're doing.
#' Every line that starts with it is ignored in execution by R. Sometimes you
#' want that, especially when you're having to explain yourself to your future
#' self (or to new students).
#' 
#' If you're using Rstudio, might I recommend the following cosmetic change to 
#' Rstudio. Go to Tools -> Global Options and, in the pop-up, select "Pane
#' Layout". Rearrange it so that “Source” is top left, “Console” is top right, 
#' and the files/plots/packages/etc. is the bottom right. Thereafter: apply the 
#' changes. You should see something like what I have. In the bottom left pane 
#' you see, which is the one that has the Environment and History tabs, 
#' minimize the pane by pressing that minimize button you see near the top 
#' right of that bottom left pane (it'll look like a minus sign). This isn't 
#' mandatory, but it makes the best use of space for how you'll end up using 
#' RStudio. Now, let's get started.
#' 
#' The syllabus prompted you to install some R packages, and the hope is you have
#' already. This particular function will effectively force you to install the
#' packages if you have not already. Let it also be a preview of what a function
#' looks like in the R programming language. I won't belabor the specifics of what
#' each line of this function is doing, but I want you to use your mouse/trackpad
#' and click on the first line (assuming you are using Rstudio). Wait for your 
#' cursor to blink. Then, for you Mac users, hit Cmd-Enter. For you Windows or
#' Linux users: Ctrl-Enter. Congratulations! You just defined your first function
#' in R and loaded your first "object" in R. If you re-open the "Environment"
#' pane, you'll see it listed there as a user-defined function.

if_not_install <- function(packages) {
  new_pack <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_pack)) install.packages(new_pack)
}

#' This hasn't done anything yet. It's just defined a function that will do 
#' something once you've run it. Let's run it now. Same as before, move your 
#' cursor over the piece of code you see below. Click on it. Now hit Cmd-Enter
#' or Ctrl-Enter on your keyboard.

if_not_install(c("tidyverse","stevedata","stevemisc", 
                 "stevethemes", "stevetemplates"))

#' In my case: this did nothing. Ideally in your case it did nothing too. That would
#' be because you already have these packages installed. If you don't have one or
#' more of these packages installed, it will install them. I'm going to load
#' {tidyverse} because I'm going to use it downstream in this script.
#' 

library(tidyverse)

#' ## Get Acclimated in R
#' 
#' Now that you've done that, let's get a general sense of where you are in an R 
#' session. 
#' 
#' ### Current Working Directory
#' 
#' First, let's start with identifying the current working directory. You should 
#' know where you are and this happens to be where I am, given the location of 
#' this script.

getwd()

#' Of note: by default, R's working directory is the system's "home" directory. 
#' This is somewhat straightforward in Unix-derivative systems, where there is 
#' an outright "home" directory.  Assume your username is "steve", then, in 
#' Linux, your home directory will be "/home/steve". In Mac, I think it's 
#' something like "/Users/steve". Windows users will invariably have something 
#' clumsy like "C:/Users/steve/Documents". Notice the forward slashes. R, like 
#' everything else in the world, uses forward slashes. The backslashes owe to 
#' Windows' derivation from DOS.
#' 
#' ## Create "Objects" in the Environment
#' 
#' One thing you'll need to get comfortable doing in most statistical programming
#' applications, but certainly this one, is creating objects in your working
#' environment. R has very few built-in, so-called "internal" objects. For example,
#' here's one.
#' 

pi

#' Most things you have to create and assign yourself. For example, let's assume
#' we wanted to create a character vector of the Nordic countries using their
#' three-character ISO codes. It would be something like this.
#' 

c("SWE", "FIN", "NOR", "ISL", "DNK")

#' If we run this, we get a character vector corresponding to those countries'
#' ISO codes. However, it's basically lost to history. It doesn't exist in the
#' environment because we did not assign it to anything. In R, you have to "assign"
#' the objects you create to something you name if you want to keep returning to 
#' it. It'd go something like this.

Norden <- c("SWE", "FIN", "NOR", "ISL", "DNK")
Norden

#' You can go nuts here with object assignment and the world is truly your oyster.
#' You have multiple assignment mechanisms here too. In many basic applications,
#' something like this is equivalent.
#' 

c("SWE", "FIN", "NOR", "ISL", "DNK") -> Norden
Norden = c("SWE", "FIN", "NOR", "ISL", "DNK")

#' FWIW, the equal sign is one you want to be careful with as it's not how R
#' wants to think or encourage you to think about assignment. I encourage you
#' to get comfortable with arrow assignment, using `<-` or `->`.
#' 

#' Some caution, though. First, don't create objects with really complex names. 
#' To call them back requires getting every character right in the console or 
#' script.  Why inconvenience yourself? Second, R comes with some default 
#' objects that are kinda important and can seriously ruin things downstream. I 
#' don't know off the top of my head all the default objects in R, but there are 
#' some important ones like `TRUE`, and `FALSE` that you DO NOT want to overwrite. 
#' `pi` is another one you should not overwrite, and `data` is a function that 
#' serves a specific purpose (even if you probably won't be using it a whole lot).
#' You can, however, assign some built-in objects to new objects.


this_Is_a_long_AND_WEIRD_objEct_name_and_yOu_shoUld_not_do_this <- 5
pi # notice there are a few built-in functions/objects
d <- pi # you can assign one built-in object to a new object.
# pi <- 3.14 # don't do this....

#' If you do something dumb (like overwrite `TRUE` with something), all hope is 
#' not lost. Remove the object in question (e.g. `rm(TRUE)`). Restart R and 
#' you'll reclaim some built-in object that you overwrote.
#' 
#' 
#' ### Load Data
#' 
#' Problem sets and lab scripts will lean on data I make available in `{stevedata}`,
#' or have available for you in Athena. However, you may often find that you 
#' want to download a data set from somewhere else and load it into R. Example 
#' data sets would be stuff like European Values Survey, European Social Survey, 
#' or Varieties of Democracy, or whatever else. You can do this any number of 
#' ways, and it will depend on what is the file format you downloaded. Here are 
#' some commands you'll want to learn for these circumstances:
#' 
#' - `haven::read_dta()`: for loading Stata .dta files
#' - `haven::read_spss()`: for loading SPSS binaries (typically .sav files)
#' - `read_csv()`: for loading comma-separated values (CSV) files
#' - `readxl::read_excel()`: for loading MS Excel spreadsheets.
#' - `read_tsv()`: for tab-separated values (TSV) files
#' - `readRDS()`: for R serialized data frames, which are awesome for file compression/speed.
#' 
#' Notice that functions like `read_dta()`, `read_spss()`, and `read_excel()` 
#' require some other packages that I didn't mention. However, these other 
#' packages/libraries are part of the `{tidyverse}` and are just not loaded 
#' directly with them. Under these conditions, you can avoid directly loading a 
#' library into a session by referencing it first and grabbing the function you 
#' want from within it separated by two colons (`::`). Basically, 
#' `haven::read_dta()` could be interpreted as a command saying "using the 
#' `{haven}` library, grab the `read_dta()` command in it". 
#' 
#' These wrappers are also flexible with files on the internet. For example, 
#' this will work. Just remember to assign them to an object.

# Note: hypothetical data
# Source: https://stats.oarc.ucla.edu/stata/dae/ordered-logistic-regression/
Apply <- haven::read_dta("https://stats.idre.ucla.edu/stat/data/ologit.dta")

#' Because we loaded these data and assigned it to an object, we can ask for it
#' using default methods available in R and look at what we just loaded.

Apply

#' The "tibble" output tells us something about our data. We can observe that
#' there are 400 observations (or rows, if you will) and that there are four
#' columns in the data. It's incidentally the case that because we loaded a 
#' Stata .dta file, there is value label information for them. So, the `apply`
#' variable is just 0, 1, and 2, but 0 means "unlikely", 1 means "somewhat 
#' likely", and 2 means "very likely". That's situationally useful, especially 
#' for beginners, but we're going to ignore it for now.
#' 
#' There are other ways to find the dimension of the data set (i.e. rows and 
#' columns). For example, you can ask for the dimensions of the object itself.
#' 
dim(Apply)

#' Convention is rows-columns, so this first element in this numeric vector tells
#' us there are 400 rows and the second one tells us there are four columns.
#' You can also do this.

nrow(Apply)
ncol(Apply)

#' ### Learn Some Important R/"Tidy" Functions
#' 
#' I want to spend most of our time in this lab session teaching you some basic 
#' commands you should know to do basically anything in R. These are so-called 
#' "tidy" verbs. We'll be using this Apply data that we just loaded from the 
#' internet.


#' I want to dedicate the bulk of this section to learning some core functions 
#' that are part of the `{tidyverse}`. My introduction here will inevitably be 
#' incomplete because there's only so much I can teach within the limited time 
#' I have. That said, I'm going to focus on the following functions available in 
#' the `{tidyverse}` that totally rethink base R. These are the "pipe" (`%>%`), 
#' `glimpse()` and `summary()`, `select()`, `group_by()`, `summarize()`, 
#' `mutate()`, and `filter()`.
#' 
#' #### The Pipe (`%>%`)
#' 
#' I want to start with the pipe because I think of it as the most 
#' important function in the `{tidyverse}`. The pipe---represented as `%>%`---allows 
#' you to chain together a series of functions. The pipe is especially useful 
#' if you're recoding data and you want to make sure you got everything 
#' the way you wanted (and correct) before assigning the data to 
#' another object. You can chain together *a lot* of `{tidyverse}` 
#' commands with pipes, but we'll keep our introduction here rather minimal 
#' because I want to use it to teach about some other things.
#' 
#' #### `glimpse()` and `summary()`
#' 
#' `glimpse()` and `summary()` will get you basic descriptions of your data. 
#' Personally, I find `summary()` more informative than `glimpse()` though
#' `glimpse()` is useful if your data  have a lot of variables and you want to 
#' just peek into the data without spamming the R console without output. 
#' 
#' Notice, here, the introduction of the pipe (`%>%`). In the commands below,
#' `Apply %>% glimpse()` is equivalent to `glimpse(Apply)`, but I like to 
#' lean more on pipes than perhaps others would. My workflow starts with (data) 
#' objects, applies various functions to them, and assigns them to objects. I 
#' think you'll get a lot of mileage thinking that same way too.

Apply %>% glimpse() # notice the pipe
Apply %>% summary()

#' Of note: notice the summary function (alternatively `summary(Apply)`) gives you
#' basic descriptive statistics. You can see the mean and median, which are routinely
#' statistics of central tendency that we care about. In this hypothetical data, we can see
#' that the mean of the `public` variable is .1425. Because this is a dummy variable,
#' it tells us that 14.25% of the observations are 1. We can see that the mean GPA
#' is 2.999 and the median is 2.99. This gives us some preliminary insight that
#' there isn't a major distribution/skew problem here.
#' 
#' #### `select()`
#' 
#' `select()` is useful for basic (but important) data management. You can use it to grab 
#' (or omit) columns from data. For example, let's say I wanted to grab all the columns 
#' in the data. I could do that with the following command.

Apply %>% select(everything())  # grab everything

#' Do note this is kind of a redundant command. You could just as well spit the entire data
#' into the console and it would've done the same thing. Still, here's if I wanted everything 
#' except wanted to drop the labor share of income variable.
#' 
Apply %>% select(-public) # grab everything, but drop the public variable.

#' Here's a more typical case. Assume you're working with a large data object and you 
#' just want a handful of things. In this case, we have these four variables,
#' but we want just the first three columns and want to drop everything else. Here's 
#' how we'd do that in the `select()` function, again with some assistance from the pipe.

Apply %>% select(apply:public) # grab just these three columns.


#' #### Grouped functions using `.by` arguments
#' 
#' I think the pipe is probably the most important function in the `{tidyverse}` 
#' even as a critical reader might note that the pipe is 1) a port from another 
#' package (`{magrittr}`) and 2) now a part of base R in a different terminology. 
#' Thus, the critical reader (and probably me, depending on my mood) may note 
#' that grouped functions/arguments serve as probably the most important 
#' component of the `{tidyverse}`. It used to be `group_by()` that did this, but 
#' now most functions in the `{tidyverse}` have `.by` arguments that are 
#' arguably more efficient for this purpose. Basically, grouping the data---either 
#' with the deprecated `group_by()` or `.by` argument---allows you to  "split" 
#' the data into various subsets, "apply" various functions to them, and 
#' "combine" them into one output. You might see that terminology "split-apply-combine" 
#' as you learn more about the `{tidyverse}` and its development.
#' 
#' Here, let's do a simple exercise : `slice()`. `slice()` lets you index rows by
#' integer locations and can be useful for peeking into the data or curating it (by
#' doing something like removing duplicate observations). In this simple case, 
#' we're going to slice the data by the first observation at each level of the `apply` 
#' variable.

# Notice we can chain some pipes together
Apply %>%
  # Get me the first observation, by group.
  slice(1, .by=apply)

# This is the older way of doing it. It still works, but the presentation of what
# it did slightly differs.

Apply %>%
  group_by(apply) %>%
  slice(1) %>%
  ungroup() # practice safe group_by()

#' Compare the above outputs with this
#' 
Apply

#' If you don't group-by the category first, `slice(., 1)` will just return the first 
#' observation in the data set.

Apply %>%
  # Get me the first observation for each values of the apply variable
  slice(1) # womp womp. Forgot to use the .by argument

#' I offer one caveat here. If you're applying a group-specific function (that you 
#' need just once), it's generally advisable to "ungroup()" (i.e. `ungroup()`) as the 
#' next function in your pipe chain if you are using the `group_by()` approach. 
#' As you build together chains/pipes, the intermediate  output you get will 
#' advise you of any "groups" you've declared in your data. Don't
#' lose track of those.
#' 
#' ### `summarize()`
#' 
#' `summarize()` creates condensed summaries of your data, for whatever it is 
#' that you want. Here, for example, is a kind of dumb way of seeing how many 
#' observations are in the data. `nrow(Apply)` works just as well, but alas...

Apply %>%
  # How many observations are in the data?
  summarize(n = n())

# How many observations are there by levels of the apply variable?

Apply %>%
  summarize(n = n(), .by=apply)

# What you did, indirectly here, was find the mode of the apply variable. This is
# the most frequently occurring value in a variable, which is really only of interest
# to unordered-categorical or ordered-categorical variables. Statisticians really
# don't care about the mode, and it's why there is no real built-in function in base
# R that says "Here's the mode." You have to get it indirectly.

#' More importantly, `summarize()` works wonderfully with `group_by()`. For example, 
#' for each country (`group_by(apply)`), let's get the mean and median GPA by 
#' each value of apply

Apply %>%
  # Give me the average GPA by each value of `apply`
  summarize(mean_gpa = mean(gpa, na.rm = TRUE),
            median_gpa = median(gpa, na.rm = TRUE),
            .by = apply)

#' One downside (or feature, depending on your perspective) to `summarize()` is 
#' that it  condenses data and discards stuff that's not necessary for creating 
#' the condensed output. In the case above, notice we didn't ask for anything 
#' else about the data, other than the average GPA by each value of how likely 
#' they are to apply for graduate school. Thus, we didn't get anything else, 
#' beyond the average GPA by how likely applicants are to apply for grad school.
#' 
#' #### `mutate()`
#' 
#' `mutate()` is probably the most important `{tidyverse}` function for data 
#' management/recoding. It will allow you to create new columns while retaining 
#' the original dimensions of the data. Consider it the sister function to 
#' `summarize()`. But, where `summarize()` discards, `mutate()` retains.
#' 
#' Let's do something simple with `mutate()`. For example, we can create a new variable
#' that just counts the length of the data frame. We can think of this as a kind
#' of identifier variable. The first row is the first respondent. The second row
#' is the second respondent, and so on.

Apply %>%
  mutate(id = 1:n()) %>%
  select(id, everything()) -> Apply

#' Again, the world is your oyster here. We can also recode that apply
#' variable to be a dummy variable that equals 1 if and only if the respondent
#' is very likely to apply to grad school.


Apply %>%
  mutate(vlapply = ifelse(apply == 2, 1, 0)) -> Apply

#' We can use the distinct() function (also in {tidyverse}) to see that it worked.
Apply %>% distinct(vlapply, apply)

#' #### `filter()`
#' 
#' `filter()` is a great diagnostic tool for subsetting your data to look at 
#' particular observations. Notice one little thing, especially if you're new to 
#' programming. The use of double-equal signs (`==`) is for making logical 
#' statements where as single-equal signs (`=`) is for object assignment or 
#' column creation. If you're using `filter()`, you're probably wanting to find 
#' cases where something equals something (`==`), is greater than something (`>`), 
#' equal to or greater than something (`>=`), is less than something (`<`), or 
#' is less than or equal to something (`<=`).
#' 

#' The benefit of the ID variable that we created, though, is we can do something
#' like find the highest GPA per value of how likely they are to apply to grad
#' school.

Apply %>%
  filter(gpa == max(gpa),
         .by = apply)


#' This tells us, for example, that the third respondent in the data incidentally
#' has the highest GPA for someone who says they are very unlikely to apply
#' for grad school.

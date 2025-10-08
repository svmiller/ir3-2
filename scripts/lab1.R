#' ---
#' title: "An Intro to R, RStudio, and {tidyverse}"
#' layout: lab
#' permalink: /lab-scripts/lab-1/
#' active: lab-scripts
#' abstract: "This lab scripts offers what I think to be a gentle introduction
#' to R and RStudio. It will try to acclimate students with R as programming 
#' language and RStudio as IDE for the R programming language. There will be
#' a few recurring themes here that are subtle but deceptively critical. 1) You
#' really must know where you are on your computer without referencing to icons
#' you can push (i.e. know your working directory and the path to it). 2) You 
#' can push any number of buttons in RStudio, but everything is still a command
#' in a terminal/console. Pay careful attention to that information as it's
#' communicated to you."
#' output:
#'    md_document:
#'      variant: gfm
#'      preserve_yaml: TRUE
#' ---

#+ setup, include=FALSE
knitr::opts_chunk$set(collapse = TRUE, 
                      fig.path = "figs/lab-1/",
                      cache.path = "cache/lab-1/",
                      fig.width = 11,
                      comment = "#>")
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
#' {tidyverse} because I'm going to use it downstream in this script. In anything
#' you do, whether for a problem set in this course or for your own projects,
#' you'll typically be loading your libraries like this at the top of your script.
#' Be mindful of that too when you're working interactively in a given lab session
#' with me, but then need to do an assignment where I have to assume you're starting
#' from scratch. Be explicit; load your libraries, and typically at the very
#' top of your script.
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
pi <- 3.14 # don't do this....

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

Data <- haven::read_dta("http://svmiller.com/extdata/eu2019.dta")
# Data <- readRDS(url("http://svmiller.com/extdata/eu2019.rds"))
# ^ this will work too, but readRDS() requires url() for wrapping the location of the file.
# Doing this just in case something goes haywire with the wireless. Eduroam can
# be finicky.
# Data <- readRDS("~/Koofr/svmiller.github.io/extdata/eu2019.rds")


#' As a quick aside, I want you to use this as an opportunity to be sure you've
#' read [a recent guide I put on my blog](https://svmiller.com/blog/2024/10/make-simple-cross-sectional-world-bank-data-wdi/) 
#' about how to use the `{WDI}` package to access 
#' [World Bank Open Data](https://data.worldbank.org/). I won't belabor these
#' data in too great a detail, but these are all European Union states in 2019 
#' by various metrics. These are income inequality (`gini`), FDI net inflows
#' as a percentage of GDP (`fdipgdp`), exports as a percentage of GDP (`exppgdp`),
#' the real effective exchange rate (`reer`), tax revenue as a percentage of
#' GDP (`taxrevpgdp`), GDP in constant 2015 USD (`gdp`), and population size (`pop`).
#' The `wp` variable communicates whether the European Union state was in the
#' Warsaw Pact or not. Former republics of the Soviet Union (e.g. Estonia) and
#' Poland, for example, would both be 1s. France and the United Kingdom would 
#' both be 0.[^de]
#' 
#' [^de]: Germany is in the not-Warsaw Pact group by my discretion. It's not
#' important for the sake of this exercise but I'll tell you that I did this.
#' 
#' Because we loaded these data and assigned it to an object, we can ask for it
#' using default methods available in R and look at what we just loaded.

Data

#' The "tibble" output tells us something about our data. We can observe that
#' there are 28 observations (or rows, if you will) and that there are 12
#' columns in the data.
#' 
#' There are other ways to find the dimension of the data set (i.e. rows and 
#' columns). For example, you can ask for the dimensions of the object itself.
#' 
dim(Data)

#' Convention is rows-columns, so this first element in this numeric vector tells
#' us there are 28 rows and the second one tells us there are 11 columns.
#' You can also do this.

nrow(Data)
ncol(Data)

#' ## Learn Some Important R/"Tidy" Functions
#' 
#' I want to spend most of our time in this lab session teaching you some basic 
#' commands you should know to do basically anything in R. These are so-called 
#' "tidy" verbs. We'll be using the data that we just loaded from the internet.


#' I want to dedicate the bulk of this section to learning some core functions 
#' that are part of the `{tidyverse}`. My introduction here will inevitably be 
#' incomplete because there's only so much I can teach within the limited time 
#' I have. That said, I'm going to focus on the following functions available in 
#' the `{tidyverse}` that totally rethink base R. These are the "pipe" (`%>%`), 
#' `glimpse()` and `summary()`, `select()`, `summarize()`, 
#' `mutate()`, and `filter()`. Most of these---certainly the important ones---have
#' a `.by` argument that will also get special attention.
#' 
#' ### The Pipe (`%>%`)
#' 
#' I want to start with the pipe because I think of it as the most 
#' important function in the `{tidyverse}`. The pipe---represented as `%>%`---allows 
#' you to chain together a series of functions. Its innovation fundamentally
#' changed R's default behavior, which other wants to go line-by-line or work
#' inside out for nested functions. The pipe instead allows you to think and do
#' things in a more intuitive way. Rather than work inside out, or copy-paste
#' functions, the pipe gives you the flexibility to thin left-to-right, and 
#' top-to-bottom (for reasons you'll see soon). The pipe is especially useful 
#' if you're recoding data and you want to make sure you got everything 
#' the way you wanted (and correct) before assigning the data to 
#' another object. You can chain together *a lot* of `{tidyverse}` 
#' commands with pipes, but we'll keep our introduction here rather minimal 
#' because I want to use it to teach about some other things.
#' 
#' ### `glimpse()` and `summary()`
#' 
#' `glimpse()` and `summary()` will get you basic descriptions of your data. 
#' Personally, I find `summary()` more informative than `glimpse()` though
#' `glimpse()` is useful if your data  have a lot of variables and you want to 
#' just peek into the data without spamming the R console without output. 
#' 
#' Notice, here, the introduction of the pipe (`%>%`). In the commands below,
#' `Data %>% glimpse()` is equivalent to `glimpse(Data)`, but I like to 
#' lean more on pipes than perhaps others would. My workflow starts with (data) 
#' objects, applies various functions to them, and assigns them to objects. I 
#' think you'll get a lot of mileage thinking that same way too.

Data %>% glimpse() # notice the pipe
Data %>% summary()

#' Of note: notice the summary function (alternatively `summary(Data)`) gives you
#' basic descriptive statistics. You can see the mean and median, which are routinely
#' statistics of central tendency that we care about. Notice the `wp` variable, 
#' which is binary and communicates whether a European Union state was previously
#' in (or covered by) the Warsaw Pact. Here, the median is 0 (which tells you
#' most European states weren't previously in the Warsaw Pact) but the mean
#' tells you about 32.14% of the European Union in 2019 was previously in the
#' Warsaw Pact.
#' 
#' ### `select()`
#' 
#' `select()` is useful for basic (but important) data management. You can use it 
#' to grab  (or omit) columns from data. For example, let's say I wanted to grab 
#' all the columns in the data. I could do that with the following command.

Data %>% select(everything())  # grab everything

#' Do note this is kind of a redundant command. You could just as well spit the 
#' entire data into the console and it would've done the same thing. Still, here's 
#' if I wanted everything  except the two-character ISO code. I'm more of a 
#' three-character guy myself.
#' 
Data %>% select(-iso2c) # grab everything, but drop the public variable.

#' Here's a more typical case. Assume you're working with a large data object and you 
#' just want a handful of things. In this case, we have these variables,
#' but we want just the identifier variables and the `gini` column for income
#' inequality. We want to drop everything else. Here's how we'd do that in the 
#' `select()` function, again with some assistance from the pipe.

Data %>% select(country:gini) # grab country, gini, and everything in between it.


#' ### Grouped functions using `.by` arguments
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
#' integer locations (or through other means) and can be useful for peeking into 
#' the data or curating it (by doing something like removing duplicate 
#' observations). In this simple case, we're going to slice the data by the first 
#' observation at each level of the `wp` variable. The `wp` variable communicates 
#' whether an observation was in the Warsaw Pact (or was a state covered by the 
#' Warsaw Pact by way of being a former republic of the Soviet Union).

# Notice we can chain some pipes together
Data %>%
  # Get me the first observation, by group.
  slice(1, .by=wp)

#' If you don't group-by the category first, `slice(., 1)` will just return the 
#' first observation in the data set.

Data %>%
  # Get me the first observation for each values of the Warsaw Pact variable
  slice(1) # womp womp. Forgot to use the .by argument

#' I think `slice()` is a hidden gem and offer it the way I often use it (mostly
#' by row indexing), but you can also use it as you would `filter()` later in the
#' script. For example, here's how you can use it to identify the highest GDP
#' by levels of the `wp` variable. For time constraints, I'm going to leave it
#' to you to understand what's happening here in more detail.
#' 
Data %>% slice(which(gdp == max(gdp)), .by=wp)

#' `filter()` would be more efficient, but `slice()` can do some of that too.
#' 
#' ### `summarize()`
#' 
#' `summarize()` creates condensed summaries of your data, for whatever it is 
#' that you want. Here, for example, is a kind of dumb way of seeing how many 
#' observations are in the data. `nrow(Data)` works just as well, but alas...

Data %>%
  # How many observations are in the data?
  summarize(n = n())

# How many observations are there by levels of the Warsaw Pact variable?

Data %>%
  summarize(n = n(), .by=wp)

#' What you did, indirectly here, was find the mode of the Warsaw Pact variable. This 
#' is the most frequently occurring value in a variable, which is really only of 
#' interest to unordered-categorical or ordered-categorical variables. 
#' Statisticians really don't care about the mode, and it's why there is no real 
#' built-in function in base R that says "Here's the mode." You have to get it 
#' indirectly.

#' More importantly, `summarize()` works wonderfully with the `.by` argument. For 
#' example, for each country in the EU, by their former Warsaw Pact status, let's
#' identify the average GINI and the average exports as a % of GDP.

Data %>%
  # Give me the median GINI and Exports/GDP by each value of `wp`
  # notice the `na.rm = TRUE` argument here. A lot of summary statistics in base
  # R fail in the presence of missing data. Often times, you want the summary
  # anyway. `na.rm = TRUE` tells the function to shut up in the presence of
  # missing data and just use what's available.
  summarize(medgini = median(gini, na.rm = TRUE),
            medexppgdp = median(exppgdp, na.rm = TRUE),
            .by = wp)

#' This summary tells you that European Union states generally have the same 
#' level of income inequality whether they were previously in the Warsaw Pact or
#' not, but exports are a larger share of GDP for states that were formerly
#' in the Warsaw Pact compared to states that were not. That's not terribly 
#' surprising to me, given what we know about the endowments of the former
#' Warsaw Pact states relative to states in the EU that are more "Western".

#' One downside (or feature, depending on your perspective) to `summarize()` is 
#' that it  condenses data and discards stuff that's not necessary for creating 
#' the condensed output. In the case above, notice we didn't ask for anything 
#' else about the data, other than the average GINI and exports/GDP by each value 
#' of the `wp` variable. Thus, we didn't get anything else. Use it with that in
#' mind.
#' 
#' ### `mutate()`
#' 
#' `mutate()` is probably the most important `{tidyverse}` function for data 
#' management/recoding. It will allow you to create new columns while retaining 
#' the original dimensions of the data. Consider it the sister function to 
#' `summarize()`. But, where `summarize()` discards, `mutate()` retains.
#' 
#' Let's do something simple with `mutate()`. For example, we can create a new 
#' variable for GDP per capita based on the information we have. We have GDP. We
#' have population size. They are both in the same units. We just need to divide
#' one over the other. Watch how we'd do that here.

Data %>%
  mutate(gdppc = gdp/pop)

#' Again, the world is your oyster here. We can also create another variable to
#' identify Southern European countries of Portugal, Spain, Italy, and Greece. 
#' Looking ahead, you can see how this would also create a variable for something
#' like the Nordic countries in the European Union, though you'd have to change
#' a few things to make it work (the information is still there).

Data %>%
  mutate(southeurope = ifelse(iso2c %in% c("GR", "IT", "PT", "ES"), 1, 0)) %>%
  filter(southeurope == 1) # Did this work the way I wanted?

#' We can save/assign our work as follows.

Data %>%
  mutate(gdppc = gdp/pop,
         southeurope = ifelse(iso2c %in% c("GR", "IT", "PT", "ES"), 1, 0)) -> Data

Data

#' Now, let's combine it with `summarize()` to learn a bit more about the differences
#' between Southern Europe and the rest of the European Union in terms of their
#' average level of wealth, their average tax revenues as a percentage of GDP, 
#' and their average levels of net FDI inflows as a percentage of GDP.

Data %>% summarize(avggdppc = mean(gdppc), 
                   avgtaxrevpgdp = mean(taxrevpgdp),
                   avgfdipgdp = mean(fdipgdp), .by=southeurope)

#' The data suggest that the four Southern European countries are generally
#' poorer than the rest of the European Union and there are generally more net
#' FDI inflows coming into the rest of the European Union (as % of GDP) than 
#' there are coming into Southern Europe. Cyprus might be doing some heavy-lifting
#' in that. There doesn't seem to be a difference at all in reliance on tax 
#' intake relative to its economic size.
#' 
#' ### `filter()`
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

#' We can do something like find the highest GDP per capita of EU states by 
#' different values of the `wp` variable.

Data %>%
  filter(gdppc == max(gdppc),
         .by = wp)

#' Take out `gdppc` above and insert `gdp` and you'll get the more elegant way
#' of doing what the `slice(which())` example did above.

#' We can also see all the states that were previously in the Warsaw Pact.

Data %>% filter(wp == 1)

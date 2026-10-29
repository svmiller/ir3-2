#' ---
#' title: "Model Presentation"
#' layout: lab
#' permalink: /lab-scripts/modelsummary/
#' filename: modelsummary.R
#' abstract: "It's never sufficient to spam R console output into a formal 
#' document. Instead, the student should invest energy into presenting 
#' important console output into a narrative format. In the context of the 
#' regression model, this is the regression table. `{modelsummary}` is going
#' to be doing some heavy-lifting here with respect to a silly sample analysis
#' I did around which students can pattern their final papers."
#' active: lab-scripts
#' output:
#'    md_document:
#'      variant: gfm
#'      preserve_yaml: TRUE
#' ---

#+ setup, include=FALSE
knitr::opts_chunk$set(collapse = TRUE, 
                      fig.path = "figs/modelsummary/",
                      cache.path = "cache/modelsummary/",
                      fig.width = 11,
                      comment = "#>")
#+
#     /\_/\           ___
#    = o_o =_______    \ \  -Model Presentation-
#     __^      __(  \.__) )
# (@)<_____>__(_____)____/

#' ## If it's not installed, install it.

library(tidyverse)
library(modelsummary)
library(stevethemes)

theme_set(theme_steve(style = 'generic'))
# library(kableExtra) # for extra formatting options, in this format.
# options("modelsummary_factory_default" = "kableExtra")

#' ^ Note: "tinytable" (c.f. `{tinytable}`) is now default, though previous 
#' versions of this were written around "kableExtra" (c.f. `{kableExtra}`). As 
#' you develop your skills here (and importantly move away from copy-pasting 
#' stuff into Word), you may want to more fully transition into 
#' `{modelsummary}`'s default settings. However, we should keep this tractable 
#' here. Also note that anyone viewing this on the public course website will 
#' note that there are additional formatting things we should be doing to make 
#' this presentable in that particular format. However, what's offered here is 
#' fine for the intended format. We'll be doing copy-pasting from RStudio into 
#' Word.
#' 
#' ## Load the data 

WVS <- readRDS("~/Koofr/teaching/eh1903-ir3/2/data/wvs-swe-6/wv6-sweden-v20201117.rds")
#' ^ Note: you have access to this, but I won't know where you put it on your
#' hard drive. You need to download it and load it.
#' 
#' Let's grab the information I used in the example paper I wrote for you.
#' Here's where I have to emphasize you need to read the codebook. The codebook
#' describes the variables included and tells you the basic information they 
#' are communicating. You have to read the codebook, whatever the codebook is.

WVS %>%
  select(V140, V205, #importance of democracy, justifiability of divorce, and...
    # age, sex, scale of incomes,
    V242, V240, V239, 
    # how often you pray, age completed education
    V146, V249) -> Data


#' ^ read the codebook. It'll tell you what you want.
#' 
#' Optional, but renames columns to be more informative. In most cases,
#' you should seriously think about doing this because a lot of variable names
#' in standing data sets are either vague or obscene to look at.
colnames(Data) <- c("impdem", "justdiv", "age", "sex", "inc", "pray", "educ")

#' Surveys typically make men to be 1 and women to be 2, but I've always hated
#'  this practice. This makes women to be 1 and men to be 0.
Data %>% mutate(sex = ifelse(sex == 2, 1, 0)) -> Data

Data

#' Let's run the linear models I described in the paper.

# First model
M1 <- lm(impdem ~ justdiv, Data)
# Full model
M2 <- lm(impdem ~ justdiv + age + sex + inc + pray + educ, Data)

summary(M1)
summary(M2)

#' ## Prepare a table of descriptive statistics of your data. 
#'
#' Papers make routine use of the table of descriptive statistics to communicate
#' some basic features about the data. this is easily done in `{modelsummary}` 
#' with the `datasummary_skim()` function. The `datasummary()` function in the 
#' same package has more flexibility but this is easier to explain.
#' 
#' However, it comes with a few caveats that aren't immediately obvious and
#' often change as the package is updated. I'll talk about these here.
#' 
#' 1. It makes the most sense to whittle the data frame you're using to *just*
#' the information that you're going to model. Real-world applications often
#' have many more columns based on various transformations or robustness tests
#' or what-not. It's just easier to use `select()` here to grab only what you 
#' need.
#' 2. Related to the above, you may want to consider how you communicate the
#' information about unique values and the percent missing and whether you want
#' to pick just one to include. Technically, `NA` is a unique observation. Thus,
#' a 1-10 scale would have 11 unique values for missing data. For ordinal measures
#' that would be included in the minimum and maximum in a lot of applications.
#' For something like a respondent's age, do we care that there are 68 unique
#' values of a respondent's age? I'd probably suppress the "Unique" column
#' if I were you. Alternatively, you can do the `na.omit` function on the data
#' before feeding it to `datasummary_skim()` and omit the "Missing Pct."
#' column for presentation. I'm going to do the former here.
#' 3. It used to be the case, as far as I remember, that this function would
#' only use the column names. Now, it can use variable labels (if you have them).
#' I'll actually show you how to overwrite one or supply one because the "sex" 
#' column doesn't have one.
#' 4. It used to be easier to get a histogram with these data, which was nice
#' for in-console presentation. Now, it's more difficult to get that to behave
#' the way I'd like for an audience like yours. It's also something you really
#' won't be presenting anyway. `histogram = FALSE` used to be an argument you'd
#' supply here. Now, it's a bit more complicated.
#' 
#' Just trust me as I do this...

attr(Data$sex, "label") <- "Female"
attr(Data$pray, "label") <- "Frequency of Prayer"
attr(Data$educ, "label") <- "Age at End of Schooling"

Data %>% 
  # na.omit %>% # See second point above...
  # Below: feel free to copy-paste, but, explicitly, what goes before the = is
  # what the column is going to be named. You can also adjust this to taste in
  # Word or whatever...
  datasummary_skim(fun_numeric = list(N = N,
                                      `Missing %` = PercentMissing,
                                      Mean = Mean,
                                      `Std. Dev` = SD,
                                      Min = Min,
                                      Median = Median,
                                      Max = Max),
                   # Below: you may want to experiment with output = 'flextable'
                   output = 'tinytable') 

#' Be mindful that the data I supplied here are *all* numeric and the data
#' has *only* what I want to summarize. Be aware what you are asking it to do.

#' Looks nice, right? Let's copy-paste it into a Word document. Some cosmetic
#' things you'll have to do yourself (e.g. potential centering and what-not). All
#' you need is Ctrl-A, Ctrl-C, Ctrl-V (Cmd equivalent for you Mac users). Don't
#' forget to add a title to the table. That is an argument in this function, but
#' it's only applicable (as I understand) to in-chunk stuff processed by {knitr}
#' or R Markdown. That's likely not you, but it's a good reason to learn how
#' to do this.
#' 
#' ## Make a plot or two or three
#' 
#' For what it's worth, this descriptive statistics table is pointing you to
#' potential issues you can encounter in your data. In this particular example,
#' I see several things I'll want to consider. For one, I see an överliggare 
#' there who said they finished schooling at 83 (which, fam...). I see that
#' there is huge problems of left-skew. Most Swedes maximally value democracy,
#' are maximally permissive about divorce, and don't pray at all (per the codebook).
#' I can already anticipate these are going to be issues I should at least
#' acknowledge because I can suspect they're going to point me to problems in my
#' linear model.
#' 
#' At the least, I can offer a visual display of these. A bar chart should 
#' suffice.

Data %>%
  select(impdem) %>%
  na.omit %>%
  ggplot(.,aes(factor(impdem))) +
  geom_bar(fill="#9bb2ce", alpha=.8, color='#000000') +
  geom_text(aes(label = after_stat(count)), stat = "count", vjust = -0.5)  +
  labs(caption = "Data: World Values Survey in Sweden (2011, Wave 6)",
       x = "Values of the Importance of Democracy",
       y = "Count of Observations") +
  scale_y_continuous(limits = c(0,1000))

#' Issues in the dependent variable will typically be the ones you should think
#' about first and the most, but you can see these issues manifest elsewhere.

Data %>%
  select(justdiv) %>%
  na.omit %>%
  ggplot(.,aes(factor(justdiv))) +
  geom_bar(fill="#9bb2ce", alpha=.8, color='#000000') +
  geom_text(aes(label = after_stat(count)), stat = "count", vjust = -0.5)  +
  labs(caption = "Data: World Values Survey in Sweden (2011, Wave 6)",
       x = "Values of the Justifiability of Divorce",
       y = "Count of Observations") +
  scale_y_continuous(limits = c(0,750))

#' Now that you've created a graph that summarizes important features about your
#' data, save it (in RStudio) to a PNG file. Then, in your Word document, grab it
#' and move it in. You can also---if it pleases and sparkles---zoom into the plot,
#' right-click, copy image, and paste it into your Word document. Choice is yours.
#' 
#' ## Create a regression table
#' 
#' To really impress me, you'll need to have a regression table that summarizes
#' the results, and that summary cannot (well, really, really should not) be a 
#' PrtScrn job. You should get comfortable with the `modelsummary()` function in
#' R.
#' 
#' Its basic form looks something like this.

modelsummary(list(M1, M2))


#' Notice here that `modelsummary()` works best with list types, and lists are
#' just super-flexible ways of corralling a diverse set of object types in R.
#' Here, we have two regression summaries (`M1`, `M2`). We're wrapping them in a 
#' `list()`. `modelsummary()` will do what it does with them.
#'
#' There's a lot we should really think about doing here. First, it may be useful
#' to so-called "name" your regressions. In my sample paper, `M1` is a simple 
#' bivariate linear model and `M2` adds the control variables. I can name them
#' within `list()` like this.

modelsummary(list("Bivariate Regression" = M1,
                  "Full Model" = M2))

#' Next---and really important---thing I want to do is add asterisks to help
#' me identify so-called statistical significance. There are some customization
#' options here, but just add `stars = TRUE` here.

modelsummary(list("Bivariate Regression" = M1,
                  "Full Model" = M2),
             stars  = TRUE)

#' Next, and also really important, thing I want to do is rename the variables
#' to be something intuitive. This is the `coef_map` argument in `modelsummary()`.
#' Of note: it will help you to build the simple version above so you know what
#' you're looking at. In `coef_map`, there's a `c()` function that takes arguments
#' effectively communicating that "what the thing is called in the model, on the 
#' left, is going to be called this new thing, on the right". `justdiv` is my main
#' independent variable, but "Justifiability of Divorce" is what I want to call 
#' it.

modelsummary(list("Bivariate Regression" = M1,
                  "Full Model" = M2),
             stars  = TRUE,
             coef_map = c("justdiv" = "Justifiability of Divorce",
                          "age" = "Age",
                          "educ" = "Age at End of Schooling",
                          "sex" = "Female",
                          "pray" = "Frequency of Prayer",
                          "inc" = "Scale of Incomes",
                          "(Intercept)" = "Intercept"))


#' Just as an FYI, this works in order you specify them (i.e. the `justdiv` 
#' variable is displayed first here) and if you don't specify it, it gets 
#' dropped from the summary (i.e. check for typos!).
#' 
#' Finally, it's worth clarifying that `modelsummary()` returns almost all 
#' goodness of fit statistic for the model (contingent on the model type) and 
#' there are often *lots* of these. You don't need all of them. In the simple 
#' linear model, you really just want information about the number of 
#' observations at a minimum, and maybe one or both of the R-squares. Generally:
#' if you include it, you better be prepared to explain it. If you're not 
#' prepared to explain the Akaike Information Criterion, the Bayesian Information
#' Criterion, or the log-likelihood of the model, don't include them.[^expl]
#' 
#' [^expl]: The likelihood of the model is a measure of how probable the observed
#' data are under a model's estimated parameters. It reflects how closely the
#' observed outcomes fall around the fitted values, given the estimated residual
#' variance. The log-likelihood is just a logarithmic transformation of that 
#' likelihood. You can extract it with `logLik(M2)`, or calculate it yourself 
#' with `(nobs(M2)/2)*(log(2*pi) + 1 + log(sum(residuals(M2)^2)/nobs(M2)))` for
#' the second model. `sum(residuals(M2)^2)`, for context, would be the residual
#' sum of squares (RSS) and you would need that for calculating the model's total 
#' R-square. You need the log-likelihood to calculate the Akaike Information 
#' Criterion (AIC) and the Bayesian Information Criterion (BIC). Both work kind 
#' of in the same way the adjusted R-square works in that they are a measure of 
#' model fit against model complexity. You calculate AIC with 
#' `-2*logLik(M2) + 2*attr(logLik(M2), "df")` and BIC with 
#' `-2*logLik(M2) + log(nobs(M2))*attr(logLik(M2), "df")`. That `attr()` 
#' function, used in this way, is extracting the number of parameters in the 
#' model. The BIC is generally more punitive for extra model parameters than AIC
#' because of that logarithmic transformation of the number of observations
#' multiplied against the number of parameters in the model. Alternatively, 
#' you can do `AIC(M2)` and `BIC(M2)`. I don't prioritize teaching these 
#' because the purpose of the log-likelihood, the AIC, and the BIC are 
#' mostly for model comparison. In our case, we'd use them to compare `M1` and
#' `M2` to ask whether the extra model parameters better fit the data. Lower
#' values relative to other models are better for AIC and BIC. Higher values
#' are better for log-likelihood. In our case, `M2` is better than
#' `M1` because the AIC/BIC are lower for `M2` than `M1` and the log-likelihood
#' is higher. `M2` is more complex than `M1`, but better fits the data. Adjusted 
#' R-square also agrees. However, the social sciences don't much weight in 
#' those measures because model complexity follows the assumed data-generating 
#' process. It's a theoretical or argumentative modeling approach, and not an 
#' iterative one. If `M1` is the wrong model that follows the wrong 
#' data-generating process, it doesn't matter what the AIC or the BIC are saying. 
#' It's just not the correct data-generating process. I think these measures are 
#' relics of another time when researchers were interested in better fitting the 
#' data than they were interested in capturing (theoretical, but unknown) 
#' data-generating processes. There's still value in fitting the data, I think, 
#' but less value in fitting them relative to other models in this way and caring
#' about what these particular statistics are communicating.
#' 
#' 
#' 
#' Use the `gof_map` argument to specify what you want. If you don't know what
#' they're called, use `broom::glance()` to see what they're called internally.
broom::glance(M2)

# I want, in order, "nobs", "r.squared", and "adj.r.squared".
modelsummary(list("Bivariate Regression" = M1,
                  "Full Model" = M2),
             stars  = TRUE,
             coef_map = c("justdiv" = "Justifiability of Divorce",
                          "age" = "Age",
                          "educ" = "Age at End of Schooling",
                          "sex" = "Female",
                          "pray" = "Frequency of Prayer",
                          "inc" = "Scale of Incomes",
                          "(Intercept)" = "Intercept"),
             gof_map = c("nobs", "adj.r.squared", "r.squared"))

#' Finally, you may want to add a caption that explains that this a regression
#' table. You'll want to call it something better than what I call it here.

modelsummary(list("Bivariate Regression" = M1,
                  "Full Model" = M2),
             stars  = TRUE,
             coef_map = c("justdiv" = "Justifiability of Divorce",
                          "age" = "Age",
                          "educ" = "Age at End of Schooling",
                          "sex" = "Female",
                          "pray" = "Frequency of Prayer",
                          "inc" = "Scale of Incomes",
                          "(Intercept)" = "Intercept"),
             gof_map = c("nobs", "adj.r.squared", "r.squared"),
             title = "Hi Mom!")

#' Dope, let's put it in our Word document. In RStudio, click on that viewer of
#' the table. Then: Ctrl-A, Ctrl-C, Ctrl-V into your Word document. For you
#' Mac users, this should be Cmd instead of Ctrl.
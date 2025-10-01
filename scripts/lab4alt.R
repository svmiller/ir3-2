#' ---
#' title: "Linear Models (Again)"
#' layout: lab
#' permalink: /lab-scripts/lab-4alt/
#' active: lab-scripts
#' abstract: "This lab script teaches the implementation and interpretation of
#' the basic linear model by reference to Braithwaite's (2006) analysis
#' of the geographic spread of militarized interstate disputes. Students should read that
#' article to understand the context of what we're doing. This lab script will
#' just implement one of their basic models and unpack its contents."
#' output:
#'    md_document:
#'      variant: gfm
#'      preserve_yaml: TRUE
#' ---

#+ setup, include=FALSE
knitr::opts_chunk$set(collapse = TRUE, 
                      fig.path = "figs/lab-4alt/",
                      cache.path = "cache/lab-4alt/",
                      fig.width = 11,
                      comment = "#>")
#+
#          ___
#      _.-|   |          |\__/,|   (`\
#     {   |   |          |o o  |__ _) ) # not again...
#      "-.|___|        _.( T   )  `  /
#       .--'-`-.     _((_ `^--' /_<  \
#     .+|______|__.-||__)`-'(((/  (((/
#
# Lab 4b: Linear Models (Again)

#' ## If it's not installed, install it.

library(tidyverse)
library(stevethemes)
library(stevemisc)

#' ## Load the data
#' 
#' This code aims to augment what students should've already learned in [the
#' previous lesson](https://ir3-2.svmiller.com/lab-scripts/lab-4/). I'll be
#' repeating myself because repetition will certainly help the student's learning,
#' but I hope any terseness (for the moment) is met with some understanding since
#' it's a fair bit of work to create new lessons on the fly. No matter, I hope
#' students have learned by now how to read data from the internet. I've uploaded
#' the data for this session to Athena (in both forms) and to my website. You
#' have two options here if you're going the route of my website. One is the
#' Stata file and the other is the R serialized data frame (`.rds`). Let's go with
#' the R serialized data frame for this session. If you go this route, you have
#' to include `url()` in the `readRDS()` function. Observe:
#' 
Braith <- readRDS(url("https://svmiller.com/extdata/braithwaite2006gsmd.rds"))
# Braith <- haven::read_dta("https://svmiller.com/extdata/braithwaite2006gsmd.dta")
# ^ also works. You can also download a copy of the data from Athena.

#' This part won't be super fun, but this is the price of doing business in this
#' world. Ideally, you read the article in question to get an idea of what Alex
#' is doing. Joshua Alley has these data in [his Github repository of simple
#' cross-sectional OLS data sets](https://github.com/joshuaalley/cross-sectional-ols/tree/master/braithwaite-2006).
#' The original data and analyses were conducted in Stata, so some forensics
#' are necessary here based on [the Stata .do file that Alex wrote](https://github.com/joshuaalley/cross-sectional-ols/blob/master/braithwaite-2006/file48281_braith_final_analysis.do).
#' We're going for a replication of Table II, so let's identify what exactly he
#' did and get a reduced version of the data based on Alex' description and the
#' Stata .do file. I'll do it for you this session but, in the Master's level,
#' I'll ask you to figure stuff out like this yourself. [It's good experience](https://svmiller.com/blog/2025/09/replication-forensics/).
#' 
#' Before we begin, though, I welcome anyone in the class as we're doing this
#' to tell me what this article is about.
#' 
#' Briefly, we're aiming to reproduce this model, presented below in Stata
#' syntax.
# reg log_radius_area territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource   if final_hostile>0, robust;
#' 
#' Okay, let's look at our data...

Braith
names(Braith)

#' This is a good lesson for those of you who may have some experience with Stata
#' from instruction in another department. Stata will guess stuff on your behalf. 
#' R won't. In this case, Stata can infer you meant `log_jointsize` in the data 
#' when you asked for `logsize`. R 100% won't do that for you. Beyond that, 
#' reducing the raw data to a simple form for the sake of the analysis isn't 
#' that hard.

Braith %>%
  filter(final_hostile > 0) %>%
  select(log_radius_area, territory, log_jointsize,
         host_for, host_mt, water, cwpceyrs, bord_vital, 
           host_resource) -> Data

Data

#' How did we do?
#' 
summary(M1 <- lm(log_radius_area ~ territory + host_resource + host_mt + 
                   host_for + water + bord_vital + log_jointsize + cwpceyrs, 
                 data = Data))

#' Got it. Don't worry about the difference in the test statistics as we're not
#' going with robust standard errors for the sake of this exercise. [I explain a
#' bit about what those are here](http://svmiller.com/blog/2024/01/linear-model-diagnostics-by-ir-example/).
#' 
#' ## Unpacking the Model Output
#' 
#' R presents a summary of the residuals at the top, though our eyes should
#' go right to the coefficients first (the extent to which we are interested in
#' hypothesis-testing). In Alex' case, he's interested in explaining the geographic
#' spread of militarized interstate disputes through a variety of factors. He's 
#' interested first, it seems, in the pernicious effect of territorial disputes.
#' He hypothesizes that disputes over the allocation of territory are more likely
#' to be dispersed over a geographic area than disputes over any other issues.
#' The coefficient for that `territory` variable is 1.624. The standard error is
#' .412. Dividing the coefficient over the standard error for 287 degrees of 
#' freedom results in a test statistic of 3.943. If there were truly no difference
#' between disputes over territory and disputes over any other issue, the 
#' probability we observed what we observed  is .000101. Thus, we reject the 
#' null hypothesis as incompatible with the data we observed and suggest Alex'
#' hypothesized relationship is closer to what it truly is. Since the dependent
#' variable is log-transformed, you'll want to think of some creative ways to
#' express this relationship. [I discuss these here](https://svmiller.com/blog/2023/01/what-log-variables-do-for-your-ols-model/).
#' For example:
#' 
#' 1. Toggling a dispute from over some other issue to the allocation of territory
#' multiplies the geographic spread (as measured in the radius from the center of
#' the dispute to its furthest incident) by `exp(1.624)` (about 5.075).
#' 2. Toggling a dispute from over some other issue to the allocation of territory
#' results in a `(exp(1.624) - 1)*100` (about 407.33) percent increase in the 
#' geographic spread of the dispute (as measured by the radius from the center of
#' the dispute to its furthest incident).
#' 
#' Since the coefficient isn't close to 0, I would advise against using the rule
#' of thumb of multiplying the coefficient by 100. You could, however, do that
#' with the forest variable (`host_for`). Alex doesn't argue this point with
#' any obvious emphasis, but his treatment on pp. 510-11 implies that forest
#' would be impassable terrain. This should constrain the spread of the dispute
#' and a negative relationship should emerge. He measures this by the percentage
#' of the territory that is covered in forest. The coefficient for this is -.012 
#' and is significant at the .10 level in this model without robust standard errors.
#' Thus, you can communicate the relative change, percentage change, and percentage 
#' change approximations by the following ways:
#' 
exp(-0.012035)-1       # relative change
(exp(-0.012035)-1)*100 # percentage change
-0.012035*100          # percentage change approximation

#' You can do something similar for the mountainous terrain variable, even as
#' this has a different effect than the one hypothesized by Alex.

exp(0.025871)-1       # relative change
(exp(0.025871)-1)*100 # percentage change
0.025871*100          # percentage change approximation

#' If this is a bit much for you at this level, that's cool too. You can just note
#' what's significant and in what direction and say something like "a one-unit
#' change in the percentage of the territory that is covered in mountains coincides
#' with an estimated change of .025 in the logged value of the radius between
#' the center of the dispute to the furthest incident." I'd be remiss, though, if
#' I didn't give you things to consider. Economists certainly are accustomed to
#' this line of thinking given the type of indicators they model.
#' 
#' We should also make an obligatory reference to the stuff included at the
#' bottom of the output. Namely, the adjusted R-squared suggests the model
#' accounts for about 12% of the variation in geographic spread. We've also
#' comfortably beat the mean-only model (see: the F-stat).
#' 
#' ## Again, with the Diagnostics
#' 
#' Let's inspect the model output as we did in the previous lesson. Remember:
#' the fitted-residual plot is the most "bang for your buck" linear model
#' diagnostic. It's where you should start.

plot(M1, which = 1)

#' Oh boy... that's not good. Let's pretty it up bit, just for presentation and
#' added exposure to the `augment()` function in `{broom}`.
#' 
broom::augment(M1) %>%
  ggplot(.,aes(.fitted, .resid)) +
  geom_point(pch = 21) +
  theme_steve(style='generic') +
  geom_hline(yintercept = 0, linetype="dashed", color="red") +
  geom_smooth(method = "loess")

#' Remember what you should want to see in a fitted-residual plot. Know this
#' isn't it. That said, here's what you can discern this is telling you and what
#' it might mean for things you'd want to do with your model.
#' 
#' The first thing that grabs your attention is the clear line. Generally,
#' a line like this of any kind in your fitted-residual plot is suggesting some
#' kind of discrete pattern in the DV. Let's see this for ourselves.
#' 
Data %>% ggplot(.,aes(log_radius_area)) + 
  geom_histogram() +
  theme_steve(style='generic')

Data %>% arrange(log_radius_area)

#' When you see something like this, it's suggesting you have some kind of
#' "hurdle" component to the data-generating process. There is a separate process
#' that determines that big bar you see and then a separate one determining the
#' variation in the flatter distribution to the right of it. Braithwaite's third
#' footnote is pointing to his 2005 data article in *International Interactions*
#' that might provide more context for why this value of 4.363605 occurs so much
#' in his data. I do not at all expect you to know exactly what to do under 
#' these circumstances. That said, here's about what I'd expect you to say: "the
#' fitted-residual plot suggests a clear discrete pattern in the DV and the 
#' histogram suggests two separate data-generating processes. Both strongly imply
#' the linear model is a questionable fit for the data."
#' 
#' The second thing that grabs your attention (maybe?) is the disagreement between
#' the LOESS smoother and the flat line at 0. I don't know if it's no. 2, but it's
#' what we'll talk about next. When you see something like this, it's suggesting
#' some kind of non-linear relationship in the data. It comes with three major
#' caveats though. The first is that the LOESS smoother will always come off the
#' line at 0 near the tails of the fitted-residual plot. Thus, we really shouldn't
#' say something with any authority yet. The second is that we obviously have the
#' discrete clumping we noted above. That might be an important part of this. The
#' third is that we 100% won't know where until we looked at something a bit
#' more informative. `linloess_plot()` in `{stevemisc}` will do this.

linloess_plot(M1, pch=21) +
  theme_steve(style='generic')

#' Binary IVs will never be the issue here. It's the "vital border" variable that
#' looks like it has some weirdness. Based on what I remember of Starr (2002) and
#' how Alex describes this on p. 514, it would suggest that the 0s are probably
#' a distinct phenomenon that should be focused on in some detail. Beyond that,
#' it really seems like the fitted-residual plot's LOESS smoother is really just
#' drawing attention to the "hurdle" component of the DV.
#' 
#' The third thing you can tell from the fitted-residual plot is that the variance
#' of the residuals are clearly fanning out as the fitted values increase. That's
#' as tell-tale a sign of heteroskedasticity as you're going to see. It's also
#' why Alex estimated this model with robust standard errors. If I remember Stata
#' correctly, this is type "HC1".
#' 
lmtest::coeftest(M1,  sandwich::vcovHC(M1,type='HC1'))

#' I don't expect you to know what this does, but I've pointed you in the direction
#' of what this does on my blog. Don't sweat those details now. Just know it's
#' what a lot of practitioners do in the presence of non-constant error variance
#' (heteroskedasticity).
#' 
#' Finally, we can check for whether the residuals are normally distributed. This
#' assumption has no bearing for our test statistics or our line of best fit, but
#' it's nice to estimate a model that can reasonably fit the data.
#' 
plot(M1, which=2)

rd_plot(M1) + theme_steve(style='generic')

#' Again, a plot like this is wanting to alert us to the "hurdle" component of
#' the DV. Rather than have normally distributed residuals, or something reasonably
#' approximating it, we have two such peaks in our data. Non-normally distributed
#' residuals strongly imply a non-normally distributed DV. We already knew we had
#' that in this case.
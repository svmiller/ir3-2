#' ---
#' title: "Testing Proportions and Means"
#' layout: lab
#' permalink: /lab-scripts/lab-3alt/
#' active: lab-scripts
#' abstract: "This lab script will show you how to do some very basic tests in
#' R for equal/given proportions and differences in means. These simple tests
#' make some strong assumptions about the data, or the ability to marshall data
#' for more sophisticated tests. However, they are nice entry-level stuff students
#' should know."
#' output:
#'    md_document:
#'      variant: gfm
#'      preserve_yaml: TRUE
#' ---

#+ setup, include=FALSE
knitr::opts_chunk$set(collapse = TRUE, 
                      fig.path = "figs/lab-3alt/",
                      cache.path = "cache/lab-3alt/",
                      fig.width = 11,
                      comment = "#>")
#+

#
#
#　　　　　　　　　　　　　　　l^丶
#　 　Testing             | 　'゛''"'''゛ y-―,
#　　　Proportions　　　　 ミ　´ ∀ ｀　　,:'
#　　　and　 　　　　　　　(丶　　　　(丶 ミ
#　　　Means　　　 （（　 　 ミ　　　　　　　 ;':　ハ,_,ハ
#　　　　　　　　　　　　　　;:　　　　　　 　ミ 　';´∀｀';,　 
#　　　　　　　　　　　　　　`:; 　　　　　　,:'　ｃ　 ｃ.ミ
#　　　　　　　　　　　　　　　U"゛'''~"＾'丶)　　　u''゛"J



#' ## If it's not installed, install it.

library(tidyverse)
library(stevedata)

#' Reminder: Please have read this:
#'
#' - https://svmiller.com/blog/2025/08/simple-tests-for-arms-races-war/
#' 
#' It takes a lot of time to write things out for the sake of new material. 
#' What follows here is just a reduced form of what I make available on my
#' blog.
#'
#' ## Load and prepare the data 
#'
#' The data I'll be using for the bulk of this lab script is the `mmb_war` data
#' that I describe in the blog post above. You should have this in `{stevedata}`,
#' and I may or may not make a copy of it available on Athena. Here's how I'll
#' be loading it into the data for the sake of this presentation.
#' 
Data <- stevedata::mmb_war

Data

#' As I noted in the blog post accompanying this particular session, the only
#' that's missing from the data is a binary measure of war we need to create.
#' The industry standard in quantitative peace science is operationalizing war
#' from any confrontation where fatalities exceed 1,000. We'll be doing that
#' with the minimum dyadic fatalities observed in the confrontation. That's the
#' `dyfatmin` column here.

Data %>%
  mutate(war = ifelse(dyfatmin >= 1000, 1, 0)) -> Data

Data

#' Now we're ready to go. We already have our primary arms race variable (`mmb`).
#' 
#' There are a few ways in which you can do this. For example, the `table()` 
#' function is a base R that will create a cross-tabulation for you without a
#' whole lot of effort. Just supply it the two vectors you want, like this.
#' 
table(Data$war, Data$mmb)

#' When you do it this way, the first argument (`Data$war`) is a column that
#' becomes the information in the rows whereas the second argument (`Data$mmb`)
#' is the information that becomes the columns. Here's how you'd read this table
#' with that in mind.
#' 
#' - **Top-left (a):** There were 2,049 confrontations that *did not* become wars (i.e.
#' `war = 0`) and for which there was no mutual military build-up preceding the
#' confrontation (`mmb = 0`).
#' - **Top-right (b):** There were 75 confrontations that *did not* become wars (i.e.
#' `war = 0`) but there was a mutual military build-up preceding it (`mmb = 1`).
#' - **Bottom-left (c):** There were 180 confrontations that became wars (i.e. `war = 1`),
#' but did not have a mutual military build-up preceding it (`mmb = 0`).
#' - **Bottom-right (d):** There were 20 confrontations that became wars (i.e. `war = 1`),
#' and did have a mutual military build-up preceding it (`mmb = 1`).
#' 
#' I mention this here because I think it's important, if not critical. Chi-square
#' tests do not care about what is the row and what is the column because it's
#' primarily multiplying row and column totals together. However, there is a
#' (reasonable) convention in the social science world that anything you understand
#' to be a "cause" is a column in a cross-tab. In our case, we 100% understand
#' that arms races are potentially causes of confrontation escalation to war
#' and not necessarily the other way around (given how we operationalize them).
#' You are not obligated to hold to that convention, but I would encourage it.
#' 
#' You could also see for yourself with some slightly more convoluted code.

Data %>% 
  # This just splits the data by each unique combination of war and MMB
  # It wouldn't be elegant if you had missing data
  split(., paste("War = ", .$war, "; MMB = ", .$mmb, sep = "")) %>%
  # map() summarizes each data frame in the list
  map(~summarize(., n = n())) %>%
  # bind_rows() flattens this list into a data frame, with a new id column,
  # called `war_mmb` communicating each unique combination of mmb and war
  bind_rows(, .id = "war_mmb")

#' If you do it this way (i.e. by manually getting counts to create your own
#' contingency table), I strongly encourage making a matrix of this information.
#' You just have to be careful how you construct it. Let's first create a vector
#' of the counts, like this:
v <- c(2049, 75, 180, 20)
v

#' Let's wrap it in a `matrix()` function now.
matrix(v)

#' Oops, that's not what we want. We want a 2x2 matrix. For a simple 2x2 matrix,
#' we just need to specify that `nrow = 2` (or `ncol = 2`). Be mindful of the
#' dimensions of your intended matrix.

matrix(v, nrow = 2)

#' Oops, that's also not what we want. By default, `matrix()` fills column down.
#' We wanted that 75 to be in the `b` position (top-right), but it went in the
#' `c` position (bottom-left). If this happens to you when you're manually creating
#' your matrix, just toggle `byrow = TRUE`. It's `FALSE` as a hidden default.
#' 
matrix(v, nrow = 2, byrow = TRUE)

#' Now that we're happy with what we got, we assign to an object to use later.
#' 
mat <- matrix(v, nrow = 2, byrow = TRUE)
mat

#' The chi-squared test itself is a really simple test with a very straightforward
#' interpretation. Its test statistic is referenced to a chi-squared distribution
#' that checks for consistency with a chi-squared distribution with some
#' degree of freedom determined by the product of the number of rows and columns
#' (each subtracted by 1 prior to multiplication). The sum of deviations from
#' what's expected produces a chi-squared value that, if it's sufficiently large
#' or outside what's expected from a "normal" chi-squared distribution, produces
#' a *p*-value that allows you to reject the null hypothesis of random differences
#' between observed values and expected values.
#' 
#' That's basically what you see here, however you specify this chi-squared test.
#' 
chisq.test(table(Data$war, Data$mmb))
chisq.test(mat)

#' Simulation is useful for illustrating what the chi-squared statistic is illustrating
#' with respect to its eponymous distribution. We have a distribution with one
#' degree of freedom, representing a singular standard normal variate to square.
#' It's conceivable, however rare, that you could draw a singular 4 from that
#' distribution to square. You'd expect about 95% of the distribution under those
#' circumstances to be around 1.96^2 or thereabouts (about 3.84). Intuitively, if the differences
#' we observe were random fluctuations, they'd be consistent with a chi-squared
#' distribution with that singular degree of freedom. Anything outside those
#' bounds and we're left with the impression the differences we observe are not
#' just random squared differences.
#' 
#' Again, simulation is nice for this. Let's simulate 100,000 random numbers
#' from a chi-square distribution with a singular degree of freedom parameter.

set.seed(8675309)
tibble(x = rchisq(100000, 1)) -> chisqsim

chisqsim

#' FYI: this will have a mean that approximates 1 (the degree of freedom parameter).

mean(chisqsim$x)

#' Tell me if you recognize these numbers...

quantile(chisqsim$x, .90)
quantile(chisqsim$x, .95)

#' Let's plot this distribution now, and assign a vertical line corresponding
#' with our test statistic.

ggplot(chisqsim, aes(x)) +
  geom_density() +
  theme_minimal() +
  geom_vline(xintercept = 17.895, linetype = 'dashed')

#' Our test statistic is almost an impossibility in the chi-squared distribution.
#' 
chisqsim %>% filter(x >= 17.895)

#' Indeed, we only observed it three times in 100,000 simulations of this
#' distribution.
#' 
#' ## Choose Your Own Adventure with the *t*-test
#' 
#' I have three articles on the course description for which you need to do an
#' article summary. I also have three data sets in `{stevedata}` that are either
#' the data sets themselves or allow for reasonable approximations of what the
#' authors are doing.
#' 

EBJ        # reduced form of Appell and Loyle (2012)
PRDEG      # full replication of Leblang (1996)
states_war # approximation of Valentino et al. (2010)

#' Taking requests for something more interactive for illustrating a t-test.
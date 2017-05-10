### (x) Use purrr to pull/format JSON style data in variables: goal, shoton, shotoff, foulcommit, card, ====
### This is not necessary - purrr did not help
### cross, corner, and possession
### does not work

install.packages("purrr")
library(purrr)
install.packages("jsonlite")
library(jsonlite) #so we can use listviewer::jsonedit()
library(purrr)
install.packages("listviewer")
library(listviewer)
library(tibble)
library(dplyr)

str(match$goal, max.level = 3)
head(str(match$goal, max.level), n=1)

str(...,list.len = x, max.level = 3)


tail(match$goal, n=50)
match$goal[[25000]]

# learning to use seq_along
# this was pulled from a talk Hadley Wikham gave about nested data
# the talk didn't help me solve the problem directly, but it helped me grasp
# the concept of nested data, as well as nesting and unnesting
x1 <- c(1.2, 4.5, 6.8, 2.2)
seq_along(x1)
1:length(x1)


?list

# looking at more levels of data
str(match$goal, max.level = 0)
str(match$goal, max.level = 1)
str(match$goal, max.level = 250)

str(match$goal[[25000]])

str(match$goal[[10000]], max.level=0)

### (VIII) this is a start - R tried to use listviewer, though the format still isn't usable ====

listviewer::jsonedit(match$goal, mode = "view")

library(purrr) # so we can use the function map()
library(repurrrsive)
library(listviewer)

# See a particular cell of data - what is the proper terminology? iteration? row?
match$goal[[1730]]
map(match$goal[1730], 2)

# names() does nothing for us:
names(match$goal[1730])
names(match$goal[[1730]])

map_df(match$goal, extract) # nope

# doesn't work
match %>% 
  map("goal")

library(magrittr) # for what? map_df()0 and extract() ? I think so - for extract()
map_df(match$goals, extract, c("goal"))

match.goal.1730 <- match$goal[[1730]]
match.goal.1730



### More stuff that doesn't work

# (XI) Trying new tools (I don't think this is necessary) ====
# This might be necessary for section (X)

devtools::install_github("jennybc/googlesheets") # not necessary (or I alreaady did it a couple weeks ago)
library(googlesheets)
library(httr)
install.packages('xml2')
library(xml2)
suppressMessages(library(dplyr)) # I *think* this gives us select()
suppressMessages(library(purrr))
library(tidyr)
devtools::install_github("hrbrmstr/xmlview")
library(xmlview)

#does not work
goalUnpack1 <- rows_df %>%
  mutate(match$goal = nodeset %>% map(~ xml_name(.)),
         match.goal.1730 = nodeset %>% map(~ xml_text(.)),
         i = nodeset %>% map(~ seq_along(.))) %>% 
  select(row, i, match$goal, 'goal') %>% 
  unnest()

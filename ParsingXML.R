### (XI) Parsing the XML
# source: http://www.informit.com/articles/article.aspx?p=2215520


library(plyr) # partial y - this gives us the ldply command
library(XML) # partial y - this gives us xmlToList command
library(xmlview) #m yes? not sure if needed

xmltop25948 <- xmlRoot(xml.match.goal.25948) # (because of this)
xmlName(xml.match.goal.25948) # and this


parsed25948 <- xmlParse(match$goal[[25948]]) # no
parsed25948 <- xmlParse(match.goal.25948) # no
parsed25948 <- xmlParse(xml_children(xml.match.goal.25948)) # no

parsed25948 <- xmlParse(match25948char) # maybe yes
class(parsed25948)
str(parsed25948)
head(parsed25948)

xmlRoot(parsed25948) # this writes the whole XML code out in proper format
xmlName(parsed25948)
xmlSize(parsed25948)
xmlName(parsed25948[[1]])

parsed25948 <- xmlParse(xml.match.goal.25948) # maybe yes (Why do these both work?)
class(parsed25948)
str(parsed25948)
head(parsed25948)

xmlRoot(parsed25948) # this writes the whole XML code out in proper format
xmlName(parsed25948)
xmlSize(parsed25948)
xmlName(parsed25948[[1]])

# to see the first entry
parsed25948[[1]] # error
parsed25948[[2]] # error

# all errors
xmlSize(parsed25948[[1]]) #number of nodes in each child
xmlSApply(parsed25948[[1]], xmlName) #name(s)
xmlSApply(parsed25948[[1]], xmlAttrs) #attribute(s)
xmlSApply(parsed25948[[1]], xmlSize) #size

# this is helpful
ldply(xmlToList(as.character(match$goal[[25942]])), data.frame)
ldply(xmlToList(as.character(match$goal[[25943]])), data.frame)
write.csv(ldply(xmlToList(as.character(match$goal[[25943]])), data.frame), file = "df25943.csv")
write.csv(ldply(xmlToList(as.character(match$goal[[25944]])), data.frame), file = "df25944.csv")
write.csv(ldply(xmlToList(as.character(match$goal[[25945]])), data.frame), file = "df25945.csv")
write.csv(ldply(xmlToList(as.character(match$goal[[25946]])), data.frame), file = "df25946.csv")
write.csv(ldply(xmlToList(as.character(match$goal[[25947]])), data.frame), file = "df25947.csv")
write.csv(ldply(xmlToList(as.character(match$goal[[25943:25948]])), data.frame), file = "df25943.csv") # no
ldply(xmlToList(as.character(match$goal[[25944]])), data.frame)
ldply(xmlToList(as.character(match$goal[[25945]])), data.frame)
ldply(xmlToList(as.character(match$goal[[25946]])), data.frame)
match$goal[[25947]]
ldply(xmlToList(as.character(match$goal[[25947]])), data.frame)
match$goal[[25948]]
ldply(xmlToList(as.character(match$goal[[25948]])), data.frame)
match$goal[25945:25946]

ldply(xmlToList(as.character(match$goal[25943:25944])), data.frame) # this doesn't work for any multiple cells

ldply(xmlToList(as.character(match$goal[[1731]])), data.frame)

str(match$goal)
str(match$goal[[1731]], max.level = 0) # this doesn't help while data is in original format
str(as.character(match$goal[[1731]]), max.level = 1)
str(xmlToList(as.character(match$goal[[1731]])))
str(xmlToList(as.character(match$goal[[1731]])), max.level = 1)
str(xmlToList(as.character(match$goal[[1731]])), max.level = 2)
str(xmlToList(as.character(match$goal[[1731]])), max.level = 3) # no levels beyond this

# !!! This gets list::viewer to work on XML !!!
listviewer::jsonedit(xmlToList(as.character(match$goal[[1731]]))) # yes!

# This gets us to make pretty sentances out of the data:

library(stringr) # need this: to get str_interp to work

LCMG1731 <- xmlToList(as.character(match$goal[[1731]])) # this makes later code more concise
# LCMG1731 <- xmlToList(as.character(match$goal)) # I think this works too (without the [[1731]], even though it gives an error)
# these two lines of code set up the sentence

template <- "${player1} scored a goal during game ID: ${id}." # 1

game_announcements <- match %>% 
  mutate(scored = map_chr(LCMG1731, str_interp, string = template)) # 2

game_announcements$scored[[1731]] # example of output

# Notes:
# LCMG stands for "list.char.match.goal.1731"
# which means that match$goal[[1731]] was taken through as.character, then xmlToList


# Now we try to unnest()
## I think this is important
### this might be the way to it without writing a loop function (keep trying this--->)
#### Start by breaking this code into separate pieces
#### try to run the pieces separately, then put together
#### try to understand each separate piece


unnested_test <- match %>%  # have also tried match[[1731]], match[[1729:1731]]
  transmute(id,
            whatwhat = map(goal, "team")) %>%
  filter(lengths(whatwhat) > 1) %>% 
  unnest()




xmlToList(as.character(match$goal[[2]])) # no
matchXML <- xmlToList(as.character(match)) # no

# trying again with subsetted data:

unnested_test <- match %>% 
  transmute(id,
            whatwhat = map(ok, "GoalTypes")) %>%
  filter(lengths(whatwhat) > 0) %>% 
  unnest()

xmlToList(as.character(match$goal[[2]])) # no
matchXML <- xmlToList(as.character(match)) # no

test.submatch.1731 <- match[1731,] # yes
ldply(xmlToList(as.character(test.submatch.1731$goal)), data.frame)


# to get a subset of rows in a df:
test.submatch.1728 <- subset(match, match = 1728) # no
test.submatch.1729 <- subset(match, match = 1729) # no
test.submatch.1731 <- subset(match, goal(nrow==1731)) # no
test.submatch.1731 <- match$goal(subset(nrow==1731)) # no

test.submatch.1731 <- match[1731,] # yes
test.submatch.1728to1740 <- match[1728:1740,] # yes
test.submatch.1728to1740

test.submatch.1731
test.submatch.1731$goal



test.submatch.1728to1740
test.submatch.1728to1740$goal

ok <- ldply(xmlToList(as.character(test.submatch.1731)), data.frame)
ldply(xmlToList(as.character(test.submatch.1728to1740$goal)), data.frame)
ldply(xmlToList(as.character(test.submatch.1731$goal)), data.frame)

str(match)
names(match$shoton)
match$away_team_goal[[1731]]
match$home_team_goal[[1731]]
match$away_team_goal[[25944]]
match$home_team_goal[[25944]]
names(match$stage)
head(match$stage)
tail(match$stage)
match$stage[[25944]]
head(match$stage, n = 500)
unique(match$stage)



# trying something again

devtools::install_github("jennybc/googlesheets")
library(googlesheets)
library(httr)
library(xml2)
suppressMessages(library(dplyr))
suppressMessages(library(purrr))
library(tidyr)
devtools::install_github("hrbrmstr/xmlview")
library(xmlview) ## highly optional for this example!

pts_ws_feed <- match
ss <- gs_ws_feed(match)
?get_ws_feed

col_names <- TRUE
ws <- "embedded empty cells"
index <- match(ws, match$ws$ws_title)
the_url <- match$ws$listfeed[index]
req <- GET(the_url)
rc <- read_xml(content(match$goal[[1731]], as = "text", encoding = "UTF-8"))
ns <- xml_ns_rename(xml_ns(rc), d1 = "feed")


rows <- 



(rows_df <- xmlToList(as.character(match(row = seq_along(goal),
                      nodeset = goal))))






(cells_df <- (match1731char) %>% 
  mutate(col_name_raw = nodeset %>% map(~ player1(.)),
         cell_text = nodeset %>% map(~ id(.)),
         i = nodeset %>% map(~ seq_along(.))) %>% 
  select(row, i, col_name_raw, cell_text) %>% 
  unnest())

str(match1731char)

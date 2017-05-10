### (XI) Converting XML nested data into Structured Format (i.e., *.csv) using XML, plyr packages====
###***THIS IS IT!!***###

# (In order for "IT" to work, we need to first convert the XML cells into character format)
# we got the as.character from here: http://stackoverflow.com/questions/27528907/how-to-convert-data-frame-column-from-factor-to-numeric
str(match$goal)
match.goal.char <- as.character(match$goal) # as char for entire column of var match$goal
str(match.goal.char)
str(as.character(match$goal)) # this also works

# individual cell
match.goal.1730 <- match$goal[[1730]]
match1730char <- as.character(match.goal.1730) # as char for only one iteration of goal

# this would probably also work:
# match1730char <- as.character(match$goal[[1730]])
str(match1730char)
head(match1730char) # allows to see entire cell

### Necessary packages: ====
install.packages('XML') # necessary?
require(XML) # yes, This gives us xmlToList()
require(plyr) # necessary?
install.packages('xml2')
library(xml2) # yes, necessary for read_xml()
library(xmlview) #m yes? not sure if needed, i think no


xmltry1 <- read_xml(match$goal) # does not work because variable is in Factor format

## this is the beauty right here:
# Here are some of the sources that helped:
# http://rpubs.com/jsmanij/131030
# https://github.com/jennybc/repurrrsive/blob/master/README.md#installation # especially this

# this is nice for viewing, but I don't think it actually does anything
xmltry2 <- read_xml(match1730char) # works because match1730char has been converted to 'char' format
xmltry2 # shows it, a little tough to see
xml_child(xmltry2) # much better
as_list(xml_child(xmltry2))

# This is what xml_child(xmltry2) (from above) used to look like with just head():
head(match$goal[1730]) # also shows it, but as one text line

xml_child(xmltry2) # is this what we should use to help build the new df?

# can also play with:
# xml2::as_list()

### (XI) NEXT: use xml_child() for a few other variables
# create: match1729char, match1731char, etc - some with different number of goals
# Try to create a single df with match$goal
# Try to merge that df with match$goal - intent is to create more robust df to run regressions on
# moneyball approach


match.goal.1730 <- match$goal[[1730]]
match.goal.1730

# this is how we get a cell from current state to list in xml
# not sure we need this
match.goal.1729 <- match$goal[[1729]]
match.goal.1729
match1729char <- as.character(match.goal.1729)
match1729char <- as.character(match$goal[[1729]])
match25948char <- as.character(match$goal[[25948]])
xml.match.goal.1729 <- read_xml(match1729char) # works because match1730char has been converted to 'char' format
xml.match.goal.1729 <- read_xml(as.character(match$goal[[1729]])) # also works
xml_child(xml.match.goal.1729) # much better # this returns the first child/list
xml_children(xml.match.goal.1729) # this returns all children/lists
xml_children(read_xml(as.character(match$goal[[1729]]))) # or as this


# this takes 1729, writes it to csv file, puts it in folder
list1729 <- xmlToList(match1729char) # only this one works | match1729char is cell 1729 as a character
write.csv(list1729, file = "list1729.csv")
# which can be written as:
write.csv(xmlToList(as.character(match$goal[[1729]])), file = "list1729.csv") # require(XML)

# trying to make a better format result in csv (not working)
list1729v2 <- xmlToList(xml_children(xml.match.goal.1729))
write.csv(xmlToList(xml_children(xml.match.goal.1729)), file = "list1729v2.csv")

list25948 <- xmlToList(match25948char) # only this one works | match29548char is cell 29548 as a character
write.csv(list25948, file = "list25948.csv")





# this is how we do it again
match.goal.1731 <- match$goal[[1731]]
match.goal.1731
match1731char <- as.character(match.goal.1731)
xml.match.goal.1731 <- read_xml(match1731char)
xml_child(xml.match.goal.1731) # this returns the first child/list
xml_children(xml.match.goal.1731) # this returns all children/lists

list1731 <- xmlToList(match1731char)
write.csv(list1731, file = "list1731.csv")

list25948 <- xmlToList(match25948char) # only this one works | match29548char is cell 29548 as a character
write.csv(list25948, file = "list25948.csv")



# for 25948
match.goal.25948 <- match$goal[[25948]]
match.goal.25948
match25948char <- as.character(match.goal.25948)
xml.match.goal.25948 <- read_xml(match25948char) # we need this
xml_child(xml.match.goal.25948) # this returns the first child/list
xml_children(xml.match.goal.25948) # this returns all children/lists
class(xml.match.goal.25948)

# playing with xml code, not really necessary
xml_parent(xml.match.goal.25948)
xml_parents(xml.match.goal.25948)
xml_siblings(xml.match.goal.25948)
xml_contents(xml.match.goal.25948)
xml_length(xml.match.goal.25948)
xml_root(xml.match.goal.25948)

# now trying to convert to csv
getwd()
write.csv(xml.match.goal.25948, file = "goal25948.csv") # does not work

# is to convert xml doc into List
# source: http://rpubs.com/jsmanij/131030
list25948 <- xmlToList(xml.match.goal.25948) # no
list25948 <- xmlToList(match.goal.25948) # no
list25948 <- xmlToList(match$goal[[25948]]) # no
list25948 <- xmlToList(match25948char) # only this one works | match29548char is cell 29548 as a character



write.csv(list25948, file = "list25948.csv")

# Next we need to turn our lists into tabular data
# start with this:
list25948 <- xmlToList(match25948char) # only this one works | match29548char is cell 29548 as a character
# it takes the list to excel
# we need to iterate this over all the cells of match$goals
# and then iterate it over all the cells of other nested data


## Note: We might need to change the class of our XML data to "XMLInternalDocument" and/or "XMLAbstractDocument"
# (see )

### (XI) Creating a data frame (tabular data) from our list!!!!! ====
# source: http://www.informit.com/articles/article.aspx?p=2215520
# source: http://rpubs.com/jsmanij/131030 (sort of - didn't really use)
library(plyr)
df25948 <- ldply(xmlToList(match25948char), data.frame)
df25948 <- ldply(xmlToList(as.character(match$goal[[25948]])), data.frame) # same
df25948

class(df25948)
head(df25948, n=2)
str(df25948)
write.csv(df25948, file = "df25948.csv")



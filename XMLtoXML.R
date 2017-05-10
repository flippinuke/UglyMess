### (I) Create variable for each csv file/table that we created in sqlite2csv.R ====

read.csv('country.csv')

# variables/df's created here
country <- read.csv('country.csv')
league <- read.csv('league.csv')
match <- read.csv('match.csv') # this might take a while to load
player <- read.csv('player.csv')
playerattributes <- read.csv('playerattributes.csv')
teams <- read.csv('teams.csv')
teamattributes <- read.csv('teamattributes.csv')
sqlitesequence <- read.csv('sqlitesequence.csv')

class(country)

# to view
sapply(country, class)
sapply(league, class)
sapply(match, class)
sapply(player, class)
sapply(playerattributes, class)
sapply(teams, class)
sapply(teamattributes, class)
sapply(sqlitesequence, class)

# export the above to excel as individual sheets for notetaking
# this allowed me to inspect the individual cells more closely
# maybe necessary
varscountry <- sapply(country, class)
write.csv(varscountry, file = "varscountry.csv")
varsleague <- sapply(league, class)
write.csv(varsleague, file = "varsleague.csv")
varsmatch <- sapply(match, class)
write.csv(varsmatch, file = "varsmatch.csv")
varsplayer <- sapply(player, class)
write.csv(varsplayer, file = "varsplayer.csv")
varsplayerattributes <- sapply(playerattributes, class)
write.csv(varsplayerattributes, file = "varsplayerattributes.csv")
varsteams <- sapply(teams, class)
write.csv(varsteams, file = "varsteams.csv")
varsteamattributes <- sapply(teamattributes, class)
write.csv(varsteamattributes, file = "varsteamattributes.csv")
varssqlitesequence <- sapply(sqlitesequence, class)
write.csv(varssqlitesequence, file = "varssqlitesequence.csv")


sapply(tables, head)

# more inspection
head(country)
head(league)
head(match)
head(playerattributes)
head(teams)
head(teamattributes)
head(sqlitesequence)
sqlitesequence

sapply(tables, str) # need to run "tables <-" command earlier for this to work
str(country)
str(league)
str(match)
str(player)

unique(player$player_fifa_api_id)

## (II) Inspection: Playing with levels, trying to see levels of data ====
# Important in order to later understand the nested data
str(playerattributes)
str(teams)
str(teamattributes)
str(teamattributes, max.level = 0)
str(teamattributes, max.level = 1)
str(teamattributes, max.level = 2) # same as above

str(teamattributes, list.len = 0)
str(teamattributes, list.len = 1)
str(teamattributes, list.len = 2)
str(teamattributes, max.level = 2, list.len = 4)

str(sqlitesequence)

head(playerattributes)

# see all variable names
names(country)
names(league)
names(match)
names(teams)
names(teamattributes)
names(player)
names(playerattributes)
names(sqlitesequence)

# why doesn't this work to accomplish the previous 8 lines of code?
#1
tables <- (c(country, league, match, player, playerattributes, teams, teamattributes, sqlitesequence))
#2
sapply(tables, names)

# continue

# doesn't work
head(playerattributes$aggression)
library(plyr)
count(playerattributes$aggression) # need library(plyr)
names(playerattributes)
playerattributes.char <- as.character(playerattributes) # not necessary
class(playerattributes.char)
count.fields(playerattributes.char) #why error?

### (III) Basics for playerattributes ====
ls()
names(playerattributes)
str(playerattributes)
levels(playerattributes)
dim(playerattributes)

# learning head() function
head(playerattributes)
head(playerattributes, n=3)
head(playerattributes, n = 18)
tail(playerattributes)
tail(playerattributes, n = 3)

### (IV) Making some plots: ggplot2() vs base R plotting ====
# view distribution of various attributes
library(ggplot2)
ggplot(playerattributes, aes(x = aggression)) + geom_bar()
hist(playerattributes$aggression)
ggplot(playerattributes, aes(x = potential)) + geom_bar()
hist(playerattributes$potential)
ggplot(playerattributes, aes(x = acceleration)) + geom_bar()
hist(playerattributes$acceleration)

# play with bin width
hist(playerattributes$acceleration, breaks=90)
hist(playerattributes$acceleration, breaks=200)
hist(playerattributes$acceleration, breaks=1000)

ggplot(playerattributes, aes(x = shot_power)) + geom_bar()
hist(playerattributes$shot_power)
ggplot(playerattributes, aes(x = defensive_work_rate)) + geom_bar()
hist(playerattributes$defensive_work_rate) # why does ggplot above work, but this hist does not?
ggplot(playerattributes, aes(x = crossing)) + geom_bar() # odd distribution anomaly
hist(playerattributes$crossing)
ggplot(playerattributes, aes(x = stamina)) + geom_bar()
hist(playerattributes$stamina)
ggplot(playerattributes, aes(x = positioning)) + geom_bar() # odd distribution anomaly
hist(playerattributes$positioning)
ggplot(playerattributes, aes(x = strength)) + geom_bar()
hist(playerattributes$strength)
ggplot(playerattributes, aes(x = penalties)) + geom_bar() # odd distribution anomaly, smaller
hist(playerattributes$penalties)
ggplot(playerattributes, aes(x = marking)) + geom_bar() # odd distribution anomaly
hist(playerattributes$marking)

# plotting interactions between variables ====
ggplot(playerattributes, aes(x = aggression, y = strength)) + geom_point(alpha=0.01)

str(playerattributes$aggression)
playerattributes$strength

splayerattributes <- playerattributes[sample(nrow(playerattributes), 500), ] # take 500 rows, i think random
ggplot(splayerattributes, aes(x = aggression, y = strength)) + geom_point(alpha=.8) # allows for faster plotting
# note: would be a good place to start setseed()

### (IV) Playing with Models for variable - playerattributes ====

head(splayerattributes$aggression)
order(splayerattributes$aggression)

str(splayerattributes)
summary(splayerattributes)


### (V) Linear modeling

model1 = lm(overall_rating ~ potential, data = splayerattributes)
summary(model1)
SSE = sum(model1$residuals^2)
SSE

model2 = lm(overall_rating ~ potential + crossing, data = splayerattributes)
summary(model2)
SSE2 = sum(model2$residuals^2)
SSE2

# none of these work:
cor(splayerattributes$overall_rating, splayerattributes$potential)
cor(splayerattributes$overall_rating, splayerattributes$crossing)
cor(splayerattributes$strength, splayerattributes$aggression)
cor(splayerattributes)

hist(playerattributes$penalties, breaks=90) # what is breaks=90 for? # this code runs fast
ggplot(playerattributes, aes(x=penalties)) + geom_bar()

### (VI) Playing with stuff ====

tail(match$goal)
head(match$goal, n=500)
names(match$home_player_X1)
str(match$home_player_X1)
head(match$home_player_X1, n=100)

### (VII) Trying to understand variables home_player_X/y#, away_player_x/y#, etc.
# Note: These are coordinates of starting positions (x1 = player 1 x-coordinate, y1 = player 1 y-coordinate)
unique(match$home_player_X1)
unique(match$home_player_X2)
unique(match$home_player_X3)
# ...
unique(match$home_player_X11)

# ==
  
unique(match$home_player_Y1)
unique(match$home_player_Y2)
unique(match$home_player_Y3)
# ...
unique(match$home_player_Y12)

# ==
  
unique(match$away_player_X1)
unique(match$away_player_X2)
# ...
unique(match$away_player_X11)

#==
  
unique(match$away_player_Y1)
unique(match$away_player_Y2)
unique(match$away_player_Y3)
# ...
unique(match$away_player_Y11)

# here: no longer coordinates - but actual player ID for given above positions:
unique(match$away_player_1)
tail(match$away_player_1)
unique(match$away_player_2)
tail(match$away_player_2)
#...
unique(match$away_player_11)
tail(match$away_player_11)

### (VIII) Understanding other variables, this is where we realize match$goal is XML

unique(match$season)
unique(match$stage)
unique(match$goal)
head(match$goal)
tail(match$goal, n=100)
head(match$home_team_goal, n=20)

str(player)
str(match)

str(sqlitesequence)
head(sqlitesequence, n=100)

# how to subset to view only certain rows of a table ====
head(subset(match, select = c("B365H", "BWH", "IWH")))

str(match)
head(match$season)
head(match$date)
head(match$goal,n=500)
tail(match$goal, n=100)

### (IX) Inspecting goal data more thoroughly (and other nested data) ====
### This is where I discovered that the data was in XML format
### I understand that I wrote a csv file to a folder - I did this so I could view it in Excel
### I understand that this is an R course, but soemtimes it's still easier for me just to
### look at it in Excel. I saw the same thing here ... it helped me figure it out eventually

match.goal <- (match$goal)
write.csv(match.goal, file = "PlayData/match.goal.csv")
getwd()

# more subsetting
tail(subset(match, select = c("home_team_goal", "away_team_goal")), n=100)
tail(subset(match, select = c("goal")), n=100)
tail(match$goal, n=100)

str(match$possession)
str(match$possession[1730])
head(match$possession)
head(match$possession[1730]) # this allows me to view what's in one cell/row of a variable

# making another csv for same reason
match.possession <- (match$possession)
write.csv(match.possession, file = "PlayData/match.possession.csv")
match.test <- subset(match, select = c("possession", "goal"))
write.csv(match.test, file = "PlayData/match.test.csv")

# making a subsetted data set / table / df ====
match.subset1 <- subset(match, select = c("X", "id", "country_id", "league_id", "season", "stage",
                                              "date", "match_api_id", "home_team_api_id", "away_team_api_id",
                                              "home_team_goal", "away_team_goal", "goal", "shoton", "shotoff",
                                              "foulcommit", "card", "cross", "corner", "possession"))
write.csv(match.subset1, file = "PlayData/match.subset1.csv")

### (X) Use purrr to pull/format JSON style data in variables: goal, shoton, shotoff, foulcommit, card, ====
### This is not necessary - purrr did not help
### cross, corner, and possession
### does not work
### (this was moved out of here to R sheet "soccerPurrr.R")

# (XI) Trying new tools (I don't think this is necessary) ====
# This might be necessary for section (X)
# moved to "soccerPurr.R"

### (XI) Converting XML nested data into Structured Format (i.e., *.csv) using XML, plyr packages====
###***THIS IS IT!!***###

# (In order for "IT" to work, we need to first convert the XML cells into character format)
# we got the as.character from here: http://stackoverflow.com/questions/27528907/how-to-convert-data-frame-column-from-factor-to-numeric
str(match$goal)
match.goal.char <- as.character(match$goal) # as char for entire column of var match$goal
str(match.goal.char)
str(as.character(match$goal)) # this also works
match.goal.1730 <- match$goal[[1730]]
match1730char <- as.character(match.goal.1730) # as char for only one iteration of goal
# this would probably also work:
# match1730char <- as.character(match$goal[[1730]])
str(match1730char)
head(match1730char) # allows to see entire cell

# then we need to install packages:
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



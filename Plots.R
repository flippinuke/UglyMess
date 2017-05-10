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

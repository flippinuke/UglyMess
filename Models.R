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

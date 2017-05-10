### (VI) Playing with stuff (Probably unnecessary) ====

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

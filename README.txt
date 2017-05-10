Please focus on these files:

sqlite2csv2df.R

This file contains the code I used to convert the SQLite database into 7 separate data frames.

The original SQLite database has 8 tables. I assigned each table to a variable, and then converted each variable into a csv file, since I can use base R and popular R packages on csv files.

Inspection.R

This is a mass of commands I used simply to explore the data. str(), head(), names(), etc. It also includes various sub-data frames that I wrote to additional csv files. Coming from an Excel background, this helped me understand how R works with data based on how it displayed in Excel. Any visual exploration I did exists in Plots.R

MoneyBall.R

This file contains the code I am working on to see if goal differential has an impact on teams' progression through stages.

Plots.R, Models.R, list2df.R

These are files I worked on previously and may return to later.
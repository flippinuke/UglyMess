library(swirl)
swirl()
Toast
1
bye()
swirl()
Toast
1
head(flags)
dim(flags)
class(flags)
lapply(flags, class)
cls_list <- lapply(flags, class)
cls_list
class(cls_list)
as.character(cls_list)
?sapply
cls_vect <- sapply(flags, class)
class(cls_vect)
sum(flags$orange)

### this ###

flag_colors <- flags[, 11:17]
head(flag_colors)
lapply(flag_colors, sum)
sapply(flag_colors, sum)
sapply(flag_colors, mean)
flag_shapes <- flags[, 19:23]
lapply(flag_shapes, range)
shape_mat <- sapply(flag_shapes, range)
shape_mat
class(shape_mat)


### end ###

unique(c(3,4,5,5,5,6,6))

unique_vals <- lapply(flags, unique)
unique_vals
sapply(unique_vals, length)
sapply(flags, unique)
lapply(unique_vals, function(elem) elem[2])
1
bye()
1
bye()

library(swirl)
swirl()
bye()
Toast
1
bye()

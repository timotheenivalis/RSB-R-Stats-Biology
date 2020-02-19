#' **HANDLING DATA**
#' 


1 + 1
#' That was an addition
#' 
#' ## Loading data 
#' Manual input
my_vector <- c(12, 2, 6)
my_data_frame<-data.frame(weather=c("sun", "rain", "snow"),
                            temperature=c(15, 13, -1))
#' simulation
my_data_sim <- data.frame(
  weather = sample(x = c("sun", "rain", "snow"),
                   size=1000,
                   replace = TRUE),
  temperature = rnorm(n = 1000, mean = 13, sd = 5))
summary(my_data_sim)

#' preexisting data in R
data("volcano")
image(volcano)

library(ape)
data("cynipids")
data("lynx")
lynx
cynipids


#' Load data

library("readxl")
library("gdata")

roo <- read.csv("Data/roo.csv")
ped <- read.table("Data/ped.txt")


#' ## doing things with data
data("trees")

str(trees)
summary(trees)
head(trees)
tail(trees)
View(trees)
plot(trees)

na.omit()
as.numeric()

#' access by squared brackets
# rows
trees[1, ]

#columns
trees[,2]
#cell
trees[3,1]

trees[c(1,4,18), ]
trees[1:8,]
trees[1:7, 2:3]

#' access by column name
rownames(trees) <- paste0("tree", 1:nrow(trees))

trees["tree1", "Volume"]

trees[c("tree1", "tree21"), ]

trees$Height
trees$Height[1]
trees$Height[3:20]

mean(trees$Girth)
mean(trees[,2])

mean(c(trees[1:30,1],trees[1:30,2],trees[1:30,3]))

trees[c(1:14, 16:31),3]
trees[-(15:30),3]

#' Subset

firsttrees <- trees[1:15, ]

1 < 3
4 < 3

smalltrees <- trees[trees$Height < 75, ]
smalltrees <- trees[trees$Height < mean(trees$Height),]

#' Merge

trees2 <- trees*2
trees2

alltrees <- rbind(trees, trees2)
allvar <- cbind(trees, trees2)
allvar[,"Height"]

colnames(allvar$Height) <- c("A1", "2", "3", "RE", "a", "e")

roo <- read.csv("Data/roo.csv")
ped <- read.table("Data/ped.txt", header = TRUE)

head(roo)
head(ped)

alldata <- merge(x = roo, y= ped, by.x = "id", by.y = "animal", all = TRUE)
dim(alldata)
alldata <- merge(x = roo, y= ped, by.x = "id", by.y = "animal", all.x = TRUE)
dim(alldata)

#' repetitive task
#' 
colMeans(trees)
apply(X = trees, MARGIN = 2, FUN = mean)
apply(X = trees, MARGIN = 2, FUN = var)
apply(X = trees, MARGIN = 2, FUN = function(x) mean((x-2)^1/3))

apply(trees, 1, mean)

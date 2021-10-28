###############
# Week 1 Notes
###############

# Console Input and Evaluation #

x <- 1
print(x) # explicit printing
x # auto-printing

class(x)


msg <- 'Hello'
msg

x <- 1:20
x

#### Data Types - Vectors and Lists ####

x <- c(0.5, 0.6) # numeric
x <- c(TRUE, FALSE) # logical
x <- c (T, F) # logical
x <- c('a', 'b', 'c') # character
x <- 9:29 # integer
x <- c(1+0i, 2+4i) # complex

x <- vector('numeric', length = 10) # using the vector function
x

y <- c(1.7, 'a') # character
y
y <- c(TRUE, 2) # numeric
y
y <- c('a', TRUE) # character
y

x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
as.complex(x)

x <- c('a', 'b', 'c')
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
as.complex(x)

x <- list(1, 'a', TRUE, 1+4i) # list can contain multiple classes
x

#### Data Types - Matrices ####

m <- matrix(nrow = 2, ncol = 3)
m
dim(m)
attributes(m) # returns dimensions

m <- matrix(1:6, nrow = 2, ncol = 3)
m

m <- 1:10
m
dim(m) <- c(2,5)
m

x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x,y)

#### Data Types - Factors ####

# Factors are used to represent categorical data. Factors can be un-ordered or ordered.
# One can think of a factor as an integer vector where each integers has a label.
# Using factors with labels is better than using integers because factors are sel-describing.
# Having a variable that has "Male" "Female" is better than "0" and "1".

x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x)

unclass(x)

x <- factor(c("yes", "yes", "no", "yes", "no"),
            levels = c("yes", "no"))
x

#### Data Types - Missing Values ####

# Missing values are denoted by NA or NaN for undefined mathematical operations
# is.na() is used to test objects if they are NA.
# is.nan() is used to test for NaN.
# NA values have a class also, so there are integer NA, character NA, etc.
# a NaN value is also NA but the converse is not true

x <- c(1, 2, NA, 10, 3)
is.na(x)
is.nan(x)

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

#### Data Types - Data Frames ####

x <- data.frame(foo = 1:4, bar = c(T, T, F, F))
x
nrow(x)
ncol(x)

#### Data Types - Names Attribute ####

x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf")
x
names(x)

x <- list(a = 1, b = 2, c = 3)
x

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c('a', 'b'), c('c', 'd'))
m

#### Reading Tabular Data ####

# read.table, read.csv - for reading tabular data
# readlines - for reading lines of a text file
# source - for reading in R code files (inverse of dump)
# dget - for reading in R code files (inverse of dput)
# load - for reading in saved workspaces
# unserialized - for reading single R objects in binary form

# read.table() - ex. data <- read.table("foo.txt")
  # file - name of file
  # header - logical if the file has a header line
  # sep - str indicating how columns are separated
  # comment.char - a character str indicating the comment character
  # stringAsFactors - default to TRUE

# read.csv - same as above except separator is defaulted to comma, and header = T

# Calculating Memory Requirements
  # ex. dataframe has 1,500,000 rows, and 120 col of numeric data
    # 1.5 mil * 120 * 8bytes/numeric
    # = 1440000000 bytes
    # = 1440000000 / 2^20 bytes/MB
    # = 1,373.29 MB
    # = 1.34 GB (double it for operating overhead)

# dput-tin R Objects
  # another way to pass data around is by deparsing the R object with dput and reading it back in using dget
y <- data.frame(a = 1, b = "a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")
new.y

# Dumping R Objects
  # Mulitple objects can be deparsed using the dump function and read back in using source
x <- "foo"
y <- data.frame(a = 1, b = 'a')
dump(c('x', 'y'), file = 'data.R')
rm(x,y) # remove from the enviroment
source('data.R')
y
x

### Subsetting ###

# [] - always returns an object of the same class as the original
# [[]] - used to extract elements of a list or dataframe
# $ - used to extract elements of a list or df by name

x <- c('a', 'b', 'c', 'd', 'e')
x[1]
x[2]
x[1:4]
x[x > 'a']

u <- x > 'a'
u
x[u] # using logicals to subset

x <- list(2, "a", "b", TRUE)
x[[2]]

x <- list(foo = 1:4, bar = 0.6)
x[1]

x[[1]]

x$bar

x[['bar']]
x['bar']

x <- list(foo = 1:4, bar = 0.6, baz = 'hello')
x[c(1, 3)]

name <- 'foo'
x[[name]] # computed index for 'foo'
x$name # element 'name doesn't exist!
x$foo # element foo does exist!

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 3)]]
x[[1]][[3]]
x[[c(2, 1)]]

x <- matrix(1:6, 2, 3)
x
x[1, 2]
x[2, 1]
x[1,]
x[,2]

x< - matrix(1:6, 2, 3)
x
x[1, 2]
x[1, 2, drop = F]

x <- matrix(1:6, 2, 3)
x
x[1,] # output a vector
x[1, , drop = F] # preserve a 1x3 matrix output

x <- list(aardvark = 1:5)
x
x$a # simplifies calling the element - looks for closest match (only with $)
x[['1']]
x[['a', exact = F]] # brackets default to requiring exact match

x <- c(1, 2, NA, 4, NA, 5)
x
bad <- is.na(x)
bad
x[!bad] # remove the na values

x <- c(1, 2, NA, 4, NA, 5)
y <- c('a', 'b', NA, 'd', NA, 'f')
good <- complete.cases(x, y) # look for non-NA values simultaneously
good
x[good]
y[good]

airquality[1:6, ]
good <- complete.cases(airquality)
good
airquality[good, ][1:6, ]


## practice
x <- 1:4
y <- 2:3
class(x + y)

x <- c(3, 5, 1, 10, 12, 6)
x[x < 6] <- 0
x[x < 6] == 0


x <- read.csv('hw1_data.csv')
x
x[47,]
sum(is.na(x['Ozone']))
mean(x$Ozone[!is.na(x['Ozone'])])

y <- subset(x, Ozone > 31 & Temp > 90)
mean(y$Solar.R)

z <- subset(x, Month == 6)
mean(z$Temp)

u <- subset(x, Month == 5)
max(u$Ozone[!is.na(u['Ozone'])])


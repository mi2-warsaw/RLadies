## Operator przypisania w R
x <- 5
x

(y <- "r-ladies")

z <- NA

## Wektory
vec <- c(1, 2, 3)

vec <- c(vec, z)
isna <- is.na(vec)

vec <- na.omit(vec)

## Funkcje z base
?min

min(vec)
max(vec)
sum(vec)

vec2 <- 4:6

## Operacje na wektorach
vec + vec2
vec * x

sum(vec, vec2, x)

## Inne typy
df <- data.frame(col_1 = c(1, 2, 3), col_2 = c("one", "two", "three"))
lista <- list(elem_1 = c(1, 2, 3), elem_2 = c("one", "two", "three"), elem_3 = df) 

## Operatory
df$col_1
df[, 1]
df[1, ]

lista[[1]]
lista$elem_1
lista$elem_3[, 1]
lista$elem_3$col_1

## Pakiety
# install.packages('dplyr')
library(dplyr)
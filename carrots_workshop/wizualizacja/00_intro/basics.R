## Operator przypisania w R
x <- 5
x

(y <- "r-ladies")

z <- NA
k <- TRUE

## Sprawdzanie typów
is.numeric(x)
is.character(y)
is.logical(z)
is.logical(k)

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

## data frame
df <- data.frame(col_1 = c(1, 2, 3), col_2 = c("one", "two", "three"))
str(df)
class(df)

## lista
lista <- list(elem_1 = c(1, 2, 3), elem_2 = c("one", "two", "three"), elem_3 = df)
str(lista)
class(lista)

## macierz
df_matrix <- as.matrix(df)
str(df_matrix)
class(df_matrix)

## Operatory
df$col_1
df[, 1]
df[1, ]

lista[[1]]
lista$elem_1
lista$elem_3[, 1]
lista$elem_3$col_1

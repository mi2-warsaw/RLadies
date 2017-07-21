# R / RStudio
# co jest czym w RStudio?

## Operator przypisania w R
x <- 5
x
y = 5

zmienna <- "Hello World!"

## Wektory
parzyste <- c(2, 4, 6)
litery <- c("a", "b", "c")

litery[2]

vec <- c(parzyste, litery)
vec

## Operacje na wektorach
nieparzyste <- c(1, 3, 5)

parzyste + nieparzyste
parzyste * x

##Zadanie 1
#Stworz dwa wektory skladajace sie z 5 liczb kazdy, a nastepnie przypisz ich roznice do nowej zmiennej o nazwie roznica.




## Funkcje z base
?min

min(roznica)
max(roznica)
sum(roznica)


vec2 <- 1:20
vec3 <- 50:100

vec2

## Ramki danych
df <- data.frame(col_1 = c(1, 2, 3), col_2 = c("raz", "dwa", "trzy"))

# Operatory
df$col_1
df[3, 1]
df[ ,1]
df[1, ]
df[2:3, ]


#Zabawa z jeziorami
jeziora <- read.csv("(tu nalezy wkleic sciezke do pliku)", sep=";")
jeziora
head(jeziora)

##Zadanie 2
# Stosujac operator [ , ] na ramce danych jeziora wypisz: 
#a) nazwe oraz powierzchnie trzeciego co do wielkosci jeziora
#b) nazwy 5 najwiekszych jezior.






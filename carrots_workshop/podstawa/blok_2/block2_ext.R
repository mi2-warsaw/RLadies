### BLOK 2 
### -----------------------------------------------

### Wyrażenia warunkowe if i if...else
### -----------------------------------------------

# if (warunek logiczny: TRUE / FALSE){
#   wyrazenie: 
# }

x <- 10
if ( x > 5 ) print("x jest większe niż 5")

x <- 5
if ( x > 5 ) print("x jest większe niż 5") # nie dzieje sie nic

# if (warunek logiczny: TRUE / FALSE){
#   wyrazenie
# } else {
#     inne_wyrazenie
# }

x <- 10
if ( x > 5 ){ 
  print("x jest większe niż 5")
} else {
  print("x nie jest większe niż 5")
}

x <- 5
if ( x > 5 ){ 
  print("x jest większe niż 5")
} else {
  print("x nie jest większe niż 5")
}

# if (warunek logiczny: TRUE / FALSE){
#   wyrazenie
# } else if (inny warunek logiczny) {
#     inne_wyrazenie
# } else {
#   jeszcze_inne_wyrazenie
# }

x <- 10
if ( x > 5 ){ 
  print("x jest większe niż 5")
} else if ( x == 5) {
  print("x jest równe 5")
} else {
  print("x nie mniejsze niż 5")
}

x <- 5
if ( x > 5 ){ 
  print("x jest większe niż 5")
} else if ( x == 5) {
  print("x jest równe 5")
} else {
  print("x nie mniejsze niż 5")
}

# ZADANIE 1;
# Napisz wyrażenie warunkowe, które sprawdza, czy 
# dana liczba jest:
# (a) liczbą parzystą
# (b) liczbą podzielną przez 3
# (c) liczbą, która przy dzieleniu przez 5 daje resztę 2

# Rozwiązanie:

# (a)
x <- 5
if ( x %% 2 == 0){
  print(paste(x, 'jest liczbą parzystą.'))
} else {
  print(paste(x, 'jest liczbą nieparzystą.'))
}

# (b)
x <- 12
if ( x %% 3 == 0){
  print(paste(x, 'jest liczbą podzielną przez 3.'))
} else {
  print(paste(x, 'jest liczbą nie podzielną przez 3.'))
}

# (c)
x <- 13
if ( x %% 5 == 2){
  print(paste(x, 'jest liczbą, która przy dzieleniu przez 5 daje resztę 2.'))
} else {
  print(paste(x, 'nie jest liczbą, która przy dzieleniu przez 5 daje resztę 2.'))
}

# (d) liczbą podzielną przez 2 i przez 3
# (e) liczbą podzielną przez 2 lub przez 3


6 %% 2 == 0 & 6 %% 3 == 0

x <- 15
if ( x %% 3 == 0 && x %% 2 == 0 ){
  print(paste(x, 'jest liczbą podzielną przez 2 i przez 3.'))
} else {
  print(paste(x, 'jest liczbą nie podzielną przez 2 lub przez 3.'))
}

x <- 17
if ( x %% 3 == 0 || x %% 2 == 0 ){
  print(paste(x, 'jest liczbą podzielną przez 2 lub przez 3.'))
} else {
  print(paste(x, 'jest liczbą nie podzielną przez 2 i przez 3.'))
}


### Pętle
### -----------------------------------------------

# WHILE: dopóki warunek jest spełniony 
# (czyli wartość logiczna wynosi true) dopóty pętla 
# będzie powtarzała instrukcję (lub blok instrukcji) 
# występujący bezpośrednio po słowie kluczowym while. 

# while(  warunek kończący pętlę  )
# {
#   powtarzany blok instrukcji
# }

i <- 1
while( i <= 5 ){
  print(i)
  i <- i + 1
}

# ZADANIE 2:
# Ile liczb naturalnych możemy dodać do siebie aby ich suma nie była większa niż 100?

suma <- 0
i <- 0
while(suma <= 100 ){
  suma <- suma + i
  i <- i + 1
}

suma <- 0
i <- 0
while(suma <= 100 ){
  suma <- suma + i + 1
  if( suma <= 100) i <- i + 1
}

sum(1:13)
sum(1:14)

### FOR

for( i in 1:5 ){
  print(i)
}

for(i in seq_len(5) ){
  print(i)
}

for(i in seq_len(5) ) print(i)

x <- letters[1:5]
for(i in seq_along(x) ) print(i)
for(i in seq_along(x) ) print(x[i])

for(l in c('a', 'b', 'c')){
  print(l)
}

for(l in letters) print(l)
for(l in letters[ 1 : 10]) print(l)


# ZADANIE 3:
# Dla każdej liczby od 0 do 10,
# sprawdź i wypisz informacje, czy jest liczbą
# parzystą, czy liczbą nieparzystą.

for( i in 0:10 ){
  if ( i %% 2 == 0){
    print(paste(i, 'jest liczbą parzystą.'))
  } else {
    print(paste(i, 'jest liczbą nieparzystą.'))
  }
}


### Funkcje
### -----------------------------------------------

# nazwa_funkcji <- function(...){
#   ciało funkcji
# }

bez_parametrów <- function(){
  print("Nie mam parametrów, zawsze robię to samo!")
}

bez_parametrów()

funkcja_z_parametrem <- function(imie){
  print(paste("Mam na imię", imie, ":)"))
}

funkcja_z_parametrem("Martyna")
funkcja_z_parametrem()

funkcja_z_parametrem <- function(imie = ""){
  print(paste("Mam na imię", imie, ":)"))
}

funkcja_z_parametrem()

funkcja_z_dwoma_parametrami <- function(imie, nazwisko = "Kot"){
  print(paste("Mam na imię", imie, "a na nazwisko", nazwisko))
}

funkcja_z_dwoma_parametrami()
funkcja_z_dwoma_parametrami(imie = "Jan")
funkcja_z_dwoma_parametrami(imie = "Jan", nazwisko = "Kowalski")
funkcja_z_dwoma_parametrami("Jan", "Kowalski")
funkcja_z_dwoma_parametrami("Kowalski", "Jan")
funkcja_z_dwoma_parametrami(nazwisko = "Kowalski", imie = "Jan")

# --------------------------------------------------------------------

co_z_tym_x <- function(x){
  if ( x > 5 ){ 
    print("x jest większe niż 5")
  } else if ( x == 5) {
    print("x jest równe 5")
  } else {
    print("x nie mniejsze niż 5")
  }
}

x <- 5
co_z_tym_x(x)

co_z_tym_x(1)
co_z_tym_x(10)

co_z_tym_x2 <- function(x){
  if ( x > 5 ){ 
    odp <- "x jest większe niż 5"
  } else if ( x == 5) {
    odp <- "x jest równe 5"
  } else {
    odp <- "x nie mniejsze niż 5"
  }
  return(odp)
}

x <- co_z_tym_x2(5)
x

# ZADANIE 4:
# Napisz własną funkcję, która liczy sume wszystkich 
# liczb parzystych dla danego wektora.

vec <- sample(1:10, 20, replace = TRUE)
vec


policz <- function(vec){
  suma <- 0
  for( v in seq_along(vec) ){
    if( v %% 2 == 0 )
      suma <- suma + v
  }
  return(suma)
}


### Funkcje z base, stat, utils
### -----------------------------------------------

# base
# -------------------------------------------------

# base::all()
# base::any()
# base::as.numeric()
# base::as.character()
# base::which()
# base::duplicated()
# base::unique()

x <- 1:5
all(x > 4)
any(x > 4)

#is.numeric(x)
#is.character(x)

which(x == 5)
which(x > 5)

unique(x)
duplicated(x)

x <- c(7, 5, 9, 14, 1, 1, 7, 1)
unique(x)
duplicated(x)

sort(x)
sort(x, decreasing = TRUE)

# trochę matematyki
# base::min()
# base::max()
# base::which.min()
# base::which.max()
# base::abs()
# base::diff()

x <- c(7, 5, 9, 14, 1, 1, 7, -1)

min(x)
max(x)
which.max(x)
which.min(x)
abs(x)

# ZADANIE 5:
# (a) Sprawdz czy wszystkie kobiety były w ciaży.
# (b) Podaj zbiór liczb okreslajacych liczbe ciąż w danym zbiorze.
# (c) Podaj maksymalną liczbę ciąż

# stat
# -------------------------------------------------

# Wykladzik ze staty opisowej...
# min, max, abs
# srednia, mediana, moda, kwantyle
# korelacja

library(MASS)
data("Pima.te") # Indianki dataset :)
help("Pima.te")

min(Pima.te$age)
max(Pima.te$age)
range(Pima.te$age)

mean(Pima.te$bmi)
median(Pima.te$bmi)
quantile(Pima.te$bmi, .25)
quantile(Pima.te$bmi)

table(Pima.te$type)
max(table(Pima.te$type))
which.max(table(Pima.te$type))
names(which.max(table(Pima.te$type)))

# ZADANIE 6:
# (a) Sprawdz czy wszystkie kobiety były w ciaży. Jeśli nie wszystkie, 
# to jaki procent zbioru wszystkich kobiet stanowią kobiety, które
# nigdy nie były w ciąży.

all(Pima.te$npreg > 0)
# FALSE

sum(Pima.te$npreg == 0)
# 49
sum(Pima.te$npreg == 0) / length(Pima.te$npreg)
# 0.1475904

# (b) Oblicz 25 kwantyl dla liczby ciąż i zinterpretuj go.

quantile(Pima.te$npreg, 0.25)
# 1
quantile(Pima.te$npreg, 0.5)
# 2
quantile(Pima.te$npreg, 0.75)
# 5

# (c) Podaj zbiór liczb okreslajacych liczbe ciąż w danym zbiorze.

table(Pima.te$npreg)

# (d) Podaj maksymalną liczbę ciąż

max(Pima.te$npreg)
# 17

### sapply, apply, mapply
### -----------------------------------------------

data("women")
View(women)

# Wartości w calach i funtach -> zamieniamy na metry i kg
wzrost <- women$height * 2.54
waga <- women$weight * 0.45359237

# wzrost <- sapply(women$height, function(x) x * 2.54)
# waga <- sapply(women$weight, function(x) x * 0.45359237)


# apply() 
# --------------------------------------------------

kobiety <- data.frame(wzrost = wzrost, waga = waga)
View(kobiety)

apply(kobiety, 1, sum)

apply(kobiety, 1, function(x){
  paste0("Waga: ", x[1], ", Wzrost: ", x[2])
})

podsumowanie <- apply(kobiety, 1, function(x){
  paste0("Wzrost: ", x[1], ", Waga: ", x[2])
})


apply(kobiety, 1, sum)

apply(kobiety, 2, mean)
apply(kobiety, 2, median)
apply(kobiety, 2, min)
apply(kobiety, 2, max)

summary(kobiety)

# ZADANIE 7: 
# (a) Dla każdej kobiety z ramki danych `women` oblicz jej BMI.
# BMI = MASA / WZROST ^ 2 (MASA w kg, WZROST w metrach)
# (b) Następnie określ czy dana kobieta ma niedowage / prawidłową masę ciała / nadwagę. 
# Przyjmij następujące zasady klasyfikacji
# < 18,5 - niedowaga
# 18,5 - 24,99 - wartość prawidłowa
# >= 25,00 - nadwaga
# (c) Sprawdz czy wszystkie kobiety maja prawidłowa mase ciała

bmi <- apply(kobiety, 1, function(x){
  bmi <- x[2] / (x[1] / 100) ^ 2
  bmi
})

# lub

bmi <- numeric(nrow(kobiety))
for(i in seq_len(nrow(kobiety))){
  kobieta <- kobiety[i,]
  bmi[i] <- as.numeric(kobieta[2] / (kobieta[1] / 100) ^ 2)
}

for(i in seq_along(bmi)){
  if(bmi[i] < 18.5){
    print(paste("Koobieta nr", i, "ma niedowage!"))
  }
  else if(bmi[i] >= 25){
    print(paste("Koobieta nr", i, "ma nadwage!"))
  }
  else{
    print(paste("Koobieta nr", i, "ma prawidlowa mase ciala"))
  }
}
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

# ZADANIE 1;
# Napisz wyrażenie warunkowe, które sprawdza, czy 
# dana liczba jest:
# (a) liczbą parzystą
# (b) liczbą podzielną przez 3
# (c) liczbą, która przy dzieleniu przez 5 daje resztę 2

# Rozwiazanie:




# (d) liczbą podzielną przez 2 i przez 3 (razem)
# (e) liczbą podzielną przez 2 lub przez 3 (razem)


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

# Rozwiazanie:



### FOR

for( i in 1:5 ){
  print(i)
}

for(i in seq_len(5) ){
  print(i)
}





# ZADANIE 3:
# Dla każdej liczby od 0 do 10,
# sprawdź i wypisz informacje, czy jest liczbą
# parzystą, czy liczbą nieparzystą.

# Rozwiazanie:




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

# ZADANIE 4:
# Napisz własną funkcję, która liczy sume wszystkich 
# liczb parzystych dla danego wektora.

# Rozwiazanie:




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












# trochę matematyki
# base::min()
# base::max()
# base::which.min()
# base::which.max()
# base::abs()
# base::diff()

x <- c(7, 5, 9, 14, 1, 1, 7, -1)






# ZADANIE 5:
# (a) Sprawdz czy wszystkie kobiety były w ciaży.
# (b) Podaj maksymalną liczbę ciąż.
# (c) Podaj, która kobieta była najwięcej razy w ciąży.

# stat
# -------------------------------------------------

# Wykladzik ze staty opisowej...
# min, max, abs
# srednia, mediana, moda, kwantyle

library(MASS)
data("Pima.te") # Indianki dataset :)
help("Pima.te")











# ZADANIE 6:
# (a) Sprawdz czy wszystkie kobiety były w ciaży. Jeśli nie wszystkie, 
# to jaki procent zbioru wszystkich kobiet stanowią kobiety, które
# nigdy nie były w ciąży.
# (b) Oblicz 25 kwantyl dla liczby ciąż i zinterpretuj go.
# (c) Podaj zbiór liczb okreslajacych liczbe ciąż w danym zbiorze.
# (d) Podaj maksymalną liczbę ciąż



### apply
### -----------------------------------------------

data("women")
View(women)


wzrost <- women$height * 2.54
waga <- women$weight * 0.45359237

kobiety <- data.frame(wzrost = wzrost, waga = waga)
View(kobiety)


apply(kobiety, 1, function(x){
  paste0("Waga: ", x[1], ", Wzrost: ", x[2])
})




# ZADANIE 7: 
# (a) Dla każdej kobiety z ramki danych `women` oblicz jej BMI.
# BMI = MASA / WZROST ^ 2 (MASA w kg, WZROST w metrach)
# (b) Następnie określ czy dana kobieta ma niedowage / prawidłową masę ciała / nadwagę. 
# Przyjmij następujące zasady klasyfikacji
# < 18,5 - niedowaga
# 18,5 - 24,99 - wartość prawidłowa
# >= 25,00 - nadwaga
# (c) Sprawdz czy wszystkie kobiety maja prawidłowa mase ciała

# Rozwiazanie:



#-------------------------------------------------------------------------
# 1. Organizacja pracy w środowisku R ------------------------------------
#-------------------------------------------------------------------------

# R jest językiem interpretowanym, dzięki temu można pracować w nim w sposób 
# interaktywny, prawie natychmiast otrzymując wynik wykonywanych poleceń.

# pobranie wersji instalacyjnej: www.r-project.org
# pobranie Rstudio: https://www.rstudio.com/

#-------------------------------------------------------------------------
# 2. Organizacja pracy w RStudio -----------------------------------------
#-------------------------------------------------------------------------

# pobranie wersji instalacyjnej: www.rstudio.org

# RStudio jest zintegrowanym środowiskiem programistycznym dla istniejšcej
# już w systemie instalacji R. Znakomicie ułatwia pracę z R-em przez:
#  1) automatyczne kolorowanie składni języka,
#  2) zarzadzanie plikami źrodłowymi i projektami, 
#  3) licze rozszerzenia możliwości konsoli,
#  4) system pomocy,
#  5) wyświetlanie grafiki.

# Wybrać Nowy skrypt (Ctrl+Shift+N) - zapisywanie pracy z lab.
# okno z 4 części - można o nich opowiedzieć co gdzie 

# Komentowanie i odkomentowywanie aktualnego wiersza albo zaznaczonego 
# bloku tekstu (CTRL+SHIFT+c).

# Korzystanie z help'a - R ma łatwo dostępną dokumentację i posiada 
# bardzo rozbudowany system pomocy. 
# np. ?barplot - omówić sekcje help'a, wywołać funkcję z różnymi parametrami 

# forum stackoverflow.com - do polecenia poza dokumentacja R-a

# Pakiety - instalacja np. install.packages("MASS") 
# i załadowanie np. library(MASS) (bo dalej korzystam z tego pakietu)

getwd()
# [1] "D:/Moje dokumenty/2017/WIT/AnalizaDanych-2017/AD-Lab-1/AD-Lab-1"
# funkcja setwd("C:/myRfolder") do zmiany domyślnej ścieżki

#-------------------------------------------------------------------------
# 3. Typy danych w R -----------------------------------------------------
#-------------------------------------------------------------------------

# TYPY ATOMOWE:
#-------------------------------------------------------------------------

# wektor wartości logicznych: logical, 
# wektor bajtow: raw
# wektor wartosci calkowitych: integer
# wektor wartosci rzeczywistych: double
# wektor wartosci zespolonych: complex
# wektor napisow: character
# typ pusty: NULL

# WEKTORY LICZBOWE (numeric)
# (wektory całkowite (integer) i wektory rzeczywiste (double))
# ------------------------------------------------------------------------

# tworzenie wektorów przez złaczenie - funkcja c() (od ang.combine)
# Aby utworzyć wektor skladajacy sie z zadanych wartosci wystepujacych 
# w okreslonej kolejnosci, mozemy uzyc funkcji c()

c(3, 5, 2, 6) # obiekt bez nazwy
c(3, 5, 2, 6, 2, 4)

l.osob <- c(3, 5, 2, 6, 2, 4) # nazwanie obiektu
l.osob
# nazywanie obiektów- by móc je zapamiętać i móc dokonywać na nich operacji
# nazwa 1) nie rozpoczyna się od cyfry, podkreślnika, ani cyfry poprzedzonej kropką (?make.names)
# 2) nie zawiera spacji, 3) nie jest słowem kluczowym języka R (?Reserved)


# tworzenie wektorów przez replikację - funkcja rep() (od ang. replicate)
# przykłady

?rep

rep(2)
rep('a', times = 5)
rep(c('a', 'b'), length.out = 9)
rep(c('a', 'b'), each = 2)

# tworzenie wektorów przez operator : (przyrosty o 1 lub -1)
# przykłady
# oprocz funkcji c() oraz rep() do tworzenia wektorow o dl >= 1 
# mozemy wykorzystac operator ":", sluzy on do generowania 
# ciagow arytmetycznych o przyrostach rownych zawsze 1 lub -1

?":"
1:10
10:1

# Ciagi arytmetyczne o dowolnych roznicach generujemy za 
# pomoca funkcji seq():
# tworzenie wektorów przez funkcję seq() (od ang. sequence)
# przykłady

?seq
seq(from = 0, to = 10) # by = 1
seq(0, 10, by = 2) 
seq(0, 10, length.out = 10)

# Uwaga: W R nie operujemy na wartościach skalarnych, nawet pojedyncza 
# liczba to wektor o długości 1. 

length(TRUE)
c(5)
5 # to samo
length(c(5))

# uwaga: mimo rozróżnienia typów całkowitych i rzeczywistych w R, przeważnie
# nie powino nas interesować, czy R reprezentuje je za pomocą typu podstawowego
# integer czy double (uznajemy te wektory po prostu za liczbowe (numeric)).
# Rozróżnienie to jest spowodowane tym, że najczęściej za obliczenia na różnych
# typach liczbowych są odpowiedzialne różne jednostki procesora komputera (ALU/FPU).

?typeof
typeof(1:3) # typ podstawowy
typeof(c(1,2,3))
typeof(c(1L,2L,3L)) # jawne wprowadzanie wartosci całkowitych

# WEKTORY NAPISÓW (character)
# ------------------------------------------------------------------------
c('Audi', 'Ford', 'Mazda', 'Subaru', 'Toyota', 'Volvo')
producent <- c('Audi', 'Ford', 'Mazda', 'Subaru', 'Toyota', 'Volvo')
length(producent)
pochodzenie <- c('Europa', 'USA', 'Japonia', 'Japonia', 'Japonia', 'Europa')


# WEKTORY WARTOŚCI LOGICZNYCH (logical)
# ------------------------------------------------------------------------

# Istnieja tez funkcje sluzace do sprawdzania, czy dany obiekt jest okreslonego
# typu. 
is.character(producent)
is.numeric(2)
is.vector(5)
is.factor(5)

5 < 4
# TRUE, FALSE - dwie stałe logiczne
c(TRUE, TRUE, FALSE, FALSE)
x <- l.osob > 2
pochodzenie == 'Japonia'

# Utworzenie wektora o zadanej długosci i określonym typie
logical(4)
numeric(5)
vector("numeric", 5)
character(5)
# zwrócić uwagę na domyślne wartości



# 4. Operacje na wektorach
# Do dzialania na wektorach liczbowych mozemy uzywac binarnych operatow
# arytmetycznych 
# dodawanie: +
# odejmowanie: -
# mnozenie: *
# dzielenie: /
# potegowanie: ^
# reszta z dzielenia (modulo): %%
# dzielenie calkowite bez reszty: %/%

# Operacje tego typu wykonywane sa element po elemencie
# ------------------------------------------------------------------------
wiek <- c(c(35, 28), c(41, 27))  
x <- 3 

wiek
print(wiek)
?str
str(wiek)

x
x <- c(x, x)
(x <- c(x, x))
x <- rep(c("M", "K"), 2) # zamieniam x
x

y <- 4
rep(x, each=y)

# operatory arytmetyczne ?Arithmetic
# +, -, *, /, ^, %%, %/%
# do wektorów liczbowych

c(1, 2, 4) + c(1, 2, 3) # działanie element po elemencie (1)
c(1, 2, 4) * c(-1, 1, -1)


x1 <- c(3, 0, 1, 2, 4, 2, 5)
x2 <- c(2, 1, 0, 4, 5, 3, 2)
x3 <- c(2, 4, 3, 5, 0, 1, 4)

(suma <- x1 + x2 + x3)


c(1, 2, 4) * (-1) # 
c(1, 2, 4) * rep(-1, 3) # to samo
2^seq(0, 8, 2)
rep(2, 5)^seq(0, 8, 2) # to samo

# Regula zawijania: jesli wektory sa roznej dlugosci, 
# stosowana jest regula zawijania, ktora niejako powiela krotszy wektor, 
# tak by uzgodnic jego dlugosc z dluzszym wektorem

c(1, 2, 4) + c(1, 2)
c(-1, 1) * 1:5

# powyższe jest efektem reguły zawijania (2)
# wektory będące argumentami operatorów binarnych są roznej dlugosci

# Inne podobne operacje arytmetyczne
x <- c(1, 2, 3)
y <- c(4, 5, 6)

pmin(x, y)
pmax(x, y)

c(TRUE, FALSE, FALSE) * 2
# uzgadnianie typów (3)

# Warto pamiętać te trzy idee. Wiele funkcji w R działa zgodnie z tymi zasadami.

# operatory unarne
-c(-2, 0, 5.1)

# Operatory relacyjne
# do porownania wektorow sluza opeatory relacyjne
# mozna stosowac na wektorach dowolnych typów, wynikiem jest zawsze 
# wektor wartosci logicznych

# <, >, <=, >=, ==, !=

(1:3) == (3:1)

length(wiek) == 4 # czy wiek jest wektorem 4-elementowym
length(wiek) > 0 # czy wiek nie jest pustym wektorem
wiek < 36

## Operatory logiczne
# argumentem sa zasadniczo wektory wartosci logicznych i daja w wyniku też
# wektor logiczny
# negacja: !, alternatywa: |, koniunkcja: &

!TRUE 
TRUE | FALSE
6 > 0 | 6 < 0
6 | 0
as.logical(6) | as.logical(0)
is.numeric(wiek) & length(wiek) > 0

FALSE | c(FALSE, TRUE, TRUE)


# Indeksowanie wektorów --------------------------------------------------
# elementy wektora leżą na ściśle określonych pozycjach (indeksach)
# oznaczanych przez kolejne liczby naturalne 1, 2, itd.
# indeks 1 wskazuje na pierwszy element


# [] - operator indeksujacy

imie <- c("Janek", "Basia", "Adam", "Aga")
imie[1]
imie[c(2, 3)]
imie[2:3]
imie[length(imie)] # ostatni element
imie[c(1, 3, 4)] # bez Basi
imie[-2] # to samo
imie[-c(1, 3)]

imie[0] # wektor pusty (nie ma takiego elementu)
imie[6] # nieznana wartość - NA

imie[5] <- "Zosia"
imie

imie[c(T, F, T, T)] # właśnie tę własność wykorzystuje się do 
# tzw. filtrowania danych

imie[imie != "Basia"]  
as.logical(imie != "Basia")

wiek
wiek[wiek > 20 & wiek < 32]
imie[wiek > 20 & wiek < 32]

wiek[4:5] <- c(29, 31) # zamiana 4.wartości i rozszerzenie wektora
imie[5] <- "Rafal"
wiek
imie

wiek[8] <- 40 # rozszerzenie wektora
wiek


# braki danych (NA), wartosci nieskończone (Inf), nie-liczby (NaN)
# ------------------------------------------------------------------------
cena <- c(25, 33, 45, NA, 35, 40) # w tys. zł
is.na(c(25, 33, 45, NA, 35, 40))


# ZWEKTORYZOWANE FUNKCJE MATEMATYCZNE
# Przyjmuja one jako pierwszy argument wektor liczbowy 
# W wyniku dzialania otrzymujemy wektor o takiej samej dlugosci 
# co wektor wejsciowy, ktorego wartosci sa wyznaczane przez
# przeksztalcenie kazdego elementu dana funkcja

# abs, sign, floor, ceiling, trunc, round
# sqrt, exp, log, factorial (silnia)
# sin, cos, tan

# AGREGACJA DANYCH
# Operacje agregujace dane to funkcje, ktore zwracaja
# pojedyncza wartosc w pewnym sensie charakterystyczna 
# dla calego wektora

# sum, prod, mean, var, sd, min, max, median, quantile


z <- -1.237

abs(z) 

round(z)
round(z, 2)
?round

log(1) # logartm naturalny
?log

exp(2)

sqrt(9)


# funkcje agregujace dane # eksploracyjna analiza danych

x <- 1:6
y <- c(rep(0, 5), 1)


sum(x)
sum(y)
sum(x, y) # agregujaca 
x + y # zwektoryzowana
mean(x)
var(x)
sd(x)
min(x)
max(x)
range(x)
median(x)
quantile(x)

# AGREGACJA WEKTORÓW LOGICZNYCH
all(x > 0)
all(y >= 0)
all(x == y)
any(x==y)
any(x > y) # OK, a ile?
sum(x > y) # można ich używać także do danych nieliczbowych
sum('ola' > 'ala')
sum(c('ola','janek') > 'ala')

identical(x, y)
identical(1:4, seq(1,4))

# AGREGACJA WEKTOROW Z BRAKAMI DANYCH
# funkcje moga miec specjalny parametr, ktorego 
# ustawienie nakazuje R pomijac wartosci NA

x <- c(2, 4, NA, 6) 
x + 1
sum(x)
?sum
sum(x, na.rm=TRUE)
mean(x, na.rm=TRUE) # srednia z trzech liczb

sum(x[!is.na(x)])   #ew.
sum(na.omit(x)) # ew.

#inne funkcje
# which()
# zwraca indeksy wszystkich elemntów wektora, dla których argument ma wartosc TRUE
which(wiek < 35)

which.min(wiek)
which.max(wiek)
# zwracaja pozycję pierwszego elementu minimalnego badz maksymalnego
imie[which.min(wiek)]

w <- c(4, 6, 4, 2, 6, 0, 0.5, -1)
max(w)
which.max(w)

# PERMUTOWANIE ELEMENTÓW

# sort() zwraca uporzadkowana kopie wektora wejsciowego
sort(w)
sort(w, decreasing=TRUE)
sort(imie)
# is.unsorted() moze sprawdzic, czy dany wektor nie jest 
# posortowany niemalejaco
is.unsorted(w)

# CZYNNIK (Factor)
# ------------------------------------------------------------------------
# czynnik
# można postrzegać jako wektory do reprezentowania danych jakościowych
# np. plec, wyksztalcenie, miejsce zamieszkania, kolor oczu, itp.

# przykłady utwotrzenia

#-------------------------------------------------------------------------
### TYPY ZŁOŻONE
#-------------------------------------------------------------------------

# Operacje na czynnikach
# ------------------------------------------------------------------------
# Czynniki mozemy postrzegac jako wektory zawierajace elementy ze zbioru 
# o z gory okreslonej liczbie wartosci.
# Sluza do reprezentowania danych jakosciowych

(wzrost <- rep(c('niski', 'sredni', 'wysoki'), 2))
wzrost <- factor(wzrost)
wzrost

levels(wzrost)
nlevels(wzrost)

table(wzrost)

# cut() dyskretyzuje dany wektor liczbowy, dzielac zbior jego
# wartosci na okreslone przedzialy
x <- c(170, 156, 198, 200, 166, 178, 182)
cut(x, c(-Inf, 160, 180, Inf), c('niski', 'sredni', 'wysoki'))

# jak sprowadzić czynnik do wektora atmowoego (liczbowego lub napisów)
as.character(wzrost)
as.vector(wzrost)

as.numeric(wzrost)

# ------------------------------------------------------------------------
# TYPY ZŁOŻONE
# ------------------------------------------------------------------------

# Ramki danych (data frame)
# ------------------------------------------------------------------------
# obiekty przypominajšce zbiory danych znane z programóW MS Excel, czy SPSS
# wiersze odpowiadaja obserwacjom, kolumny zmiennym

# install.packages("MASS")
# library(MASS)

data("Cars93") 

# JAK TWORZYĆ RAMKĘ DANYCH???
# 1. recznie

klasa <- data.frame(
  imie = c('Kasia', 'Zosia', 'Jan'),
  nazwisko = c('Nowak', 'Kowalska', 'Polski'), 
  wiek = c(15, 14, 15)
)
klasa

# Przez połaczenie wektorów, czynników.

imie <-c('Kasia', 'Zosia', 'Jan')
nazwisko <- c('Nowak', 'Kowalska', 'Polski')
plec <- c("K", "K", "M")
wiek <- c(15, 14, 15)

klasa <- data.frame(imie = imie, nazwisko = nazwisko, wiek = wiek)
klasa 

View(klasa)
dim(klasa)
dimnames(klasa)
names(klasa)
str(klasa)

# 2. wczytywanie zbiorow danych z innych zrodel: plikow tekstowych, 
# arkuszy danych (np. format .csv)

# wczytywanie z pakietow:
library(MASS)
data(Cars93)
?Cars93

str(Cars93)
is.data.frame(Cars93)
dim(Cars93) # (liczba obserwacji, liczba zmiennych)

# przykłady wczytania danych z pakietów, plików .csv, i innych...

?write.csv()


# uwaga: domyslnie przy tworzeniu ramek danych wektory napisów są automatycznie 
# rzutowane do typu czynnikowego

# odwołanie sie do wybranej kolumny
klasa$imie

# można to zmienić ustawiajšc w data.frame argument stringsAsFactors na FALSE

?data.frame
klasa <- data.frame(imie = imie, nazwisko = nazwisko, wiek = wiek, plec = plec, stringsAsFactors = FALSE)
klasa
klasa$imie

# Utworzyć kilka nowych zmiennych o klasie i dodac je do ramki danych auta

klasa["obecność"] <- c(TRUE, FALSE, TRUE)
klasa

klasa$rok.urodzenia <- 2017 - klasa$wiek
klasa



# ------------------------------------------------------------------------
# Operacje na ramkach danych
# ------------------------------------------------------------------------

# Filtrowanie danych
# ------------------------------------------------------------------------
# Na ramce danych mozna wykonywac operacje indeksowania i wydobywania elementow

# wymiary ramki danych

dim(klasa)
nrow(klasa)
ncol(klasa)

# nazwy kolumn
names(klasa)
colnames(klasa)

# Wybieranie kolumn
klasa$nazwisko
klasa[2]
klasa[, 2]
klasa[, "nazwisko"]


tekolumny <- c("imie", "rok.urodzenia")
klasa[, tekolumny]

klasa[ !names(klasa) == "wiek" ]

innekolumny <- names(klasa) %in% c("wiek","plec","imie","wzrost")
innekolumny
klasa[innekolumny]

# Wybieranie wierszy
klasa[c(1, 2, 3), ]
klasa[1:3, ]
klasa[-(4:nrow(klasa)),]
klasa[-1, ]
klasa[nrow(klasa), ]

# Wybieranie wierszy i kolumn
klasa[c(1,2,3), 4]
klasa[klasa$obecność == TRUE, tekolumny]
klasa[klasa$obecność == TRUE & klasa$wiek > 14, tekolumny]


# Dodawanie kolumn i wierszy

waga <- c(20, 30, 40)
waga2 <- waga / 10

cbind(klasa, c(waga, waga2))
cbind(klasa, data.frame(waga, waga2))
cbind(klasa, klasa)

klasa
rbind(klasa, c("Adam", "Maly", 10, "M", TRUE, 2007))
rbind(klasa, data.frame("Adam", "Maly", 10, "M", TRUE, 2007))
rbind(klasa, klasa)

# Sortowanie ramek danych wzgledem wybranych zmiennych (kolumn)

klasa
klasa[order(klasa$wiek), ]
klasa[order(klasa$wiek, klasa$imie), ]

# Agregacja danych w podgrupach

str(klasa)
colSums(klasa[, c("wiek", "rok.urodzenia")])
colMeans(klasa[, c("wiek", "rok.urodzenia")])

lapply(klasa[, c("wiek", "rok.urodzenia")], mean)
sapply(klasa[, c("wiek", "rok.urodzenia")], mean)


# Wykonywanie tej samej czynnosci na kazdej kolumnie

sapply(klasa, class)
sapply(klasa, typeof)
sapply(klasa, min)
sapply(klasa, mean)

apply(klasa, 2, class)

# Uzyteczne pakiety do pracy z ramkami danych: plyr, reshape2, dplyr, data.table


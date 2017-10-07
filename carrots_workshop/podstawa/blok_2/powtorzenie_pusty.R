
# Analiza danych - big data i data mining - Lab 1 
# 04-03-2017
#-------------------------------------------------------------------------

#-------------------------------------------------------------------------
# 1. Organizacja pracy w środowisku R ------------------------------------
#-------------------------------------------------------------------------

# R jest językiem interpretowanym, dzięki temu można pracować w nim w sposób 
# interaktywny, prawie natychmiast otrzymując wynik wykonywanych poleceń.

# pobranie wersji instalacyjnej: www.r-project.org
# pobranie Rstudio: https://www.rstudio.com/

# kilka poleceń w konsoli R-a, np.
2+3
1:50

# Do tej pory tworzylismy obiekty tylko po to, aby zobaczyc je na ekranie.
# Jednak w codziennej pracy prawie zawsze zachodzi potrzeba zapamietania 
# informacji w pewnych określonym miejscu pamieci komputera, chocby po to 
# aby za chwile moc dokonac na niej jakies operacji.

# <- operator przypisania
x <- rnorm(100) # wektor liczbowy 
y <- rnorm(100)
plot(x,y)

# (brak kolorowania, brak podopowiadania składni funkcji)

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

# Zasadniczo R może pracować w dwóch trybach:
# - w trybie interaktywnym, gdzie po każdym wydanym poleceniu otrzymujemy
#   informację zwrotną o przebiegu jego wykonania (konsola),
# - w trybie wsadowym, w którym zlecamy środowisku R uruchomienie danego 
#   pliku źródłowego (skryptu), czyli pliku tekstowego najczęściej 
#   o rozszerzeniu .R, zawierajšcego kolejne polecenia języka R
#   przeznaczone do wykonania.
# W codziennej pracy używa się często (co znakomicie ułatwia RStudio) 
# mieszanki tych dwóch trybów, pracując raz to z pojedynczymi poleceniami,
# a kiedy indziej z z całymi zbiorami plików źródłowych. Takie podejście
# będzie niedługo i dla nas najbardziej naturalne.

# Zapisanie w skrypcie kilku poleceń, np.
x <- 'Witamy na Lab1'
print(x)
nchar(x)

# i przesłanie tych poleceń do konsoli: CTRL+ENTER (=Run), CTRL+SHIFT+S 
# (=Source), pokazać co się stanie, gdy uruchomimy częsć zaznaczonego 
# polecenia z x - wtedy pojawia się znak zachęty + który przy okazji można
# wyjaśnić (dokończenie polecenia lub Esc)
# > x <- 'Wi
# + 

# Znak zachęty '>' zmienia się na '+'. Oznacza to, że R oczekuje od nas, 
# że dokończymy wprowadzanie wyrażenia w kolejnym wierszu.

# Komentowanie i odkomentowywanie aktualnego wiersza albo zaznaczonego 
# bloku tekstu (CTRL+SHIFT+c).

# Korzystanie z help'a - R ma łatwo dostępną dokumentację i posiada 
# bardzo rozbudowany system pomocy. 
# np. ?barplot - omówić sekcje help'a, wywołać funkcję z różnymi parametrami 

# forum stackoverflow.com - do polecenia poza dokumentacjš R-a

# Mechanizm podpowiedzi i uzupełniania nazw obiektów. 
# Np. zapisujšc bar (barplot), pokazać jak to działa. Ew.naciskajšc Tab.

# Pakiety - instalacja np. install.packages("MASS") 
# i załadowanie np. library(MASS) (bo dalej korzystam z tego pakietu)

# Zapis Workspace przy kończeniu działania programu. 
# Pokazanie, że po ponownym uruchomieniu możemy odtworzyć stan obliczeń 
# sprzed zamknięcia.

getwd()
# [1] "D:/Moje dokumenty/2017/WIT/AnalizaDanych-2017/AD-Lab-1/AD-Lab-1"
# funkcja setwd("C:/myRfolder") do zmiany domyślnej ścieżki
q('yes')

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



# tworzenie wektorów przez operator : (przyrosty o 1 lub -1)
# przykłady
# oprocz funkcji c() oraz rep() do tworzenia wektorow o dl >= 1 
# mozemy wykorzystac operator ":", sluzy on do generowania 
# ciagow arytmetycznych o przyrostach rownych zawsze 1 lub -1

?":"


# Ciagi arytmetyczne o dowolnych roznicach generujemy za 
# pomoca funkcji seq():
# tworzenie wektorów przez funkcję seq() (od ang. sequence)
# przykłady

?seq



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

# Regula zawijania: jesli wektory sa roznej dlugosci, 
# stosowana jest regula zawijania, ktora niejako powiela krotszy wektor, 
# tak by uzgodnic jego dlugosc z dluzszym wektorem

c(1, 2, 4) + c(1, 2)
c(-1, 1) * 1:5
# powyższe jest efektem reguły zawijania (2)
# wektory będące argumentami operatorów binarnych są roznej dlugosci


# operatory unarne
-c(-2, 0, 5.1)

# Operatory relacyjne
# do porownania wektorow sluza opeatory relacyjne
# mozna stosowac na wektorach dowolnych typów, wynikiem jest zawsze 
# wektor wartosci logicznych

# <, >, <=, >=, ==, !=

(1:3) == (3:1)

wiek <- c(10, 3, 5, 11, 12)

length(wiek) == 4 # czy wiek jest wektorem 4-elementowym
length(wiek) > 0 # czy wiek nie jest pustym wektorem
wiek < 36

## Operatory logiczne
# argumentem sa zasadniczo wektory wartosci logicznych i daja w wyniku też
# wektor logiczny
# negacja: !, alternatywa: |, koniunkcja: &

!TRUE 
TRUE & FALSE
TRUE | FALSE
6 > 0 | 6 < 0

FALSE | c(FALSE, TRUE, TRUE)
FALSE || c(FALSE, TRUE, TRUE)

# uwaga: wszystkie opeatory binarne oprocz ^, =, <- dzialaja zgodnie z zasada 
# "od lewej do prawej" (z zachowaniem kolejnosci dzialan) ?Syntax


# Indeksowanie wektorów --------------------------------------------------
# elementy wektora leżą na ściśle określonych pozycjach (indeksach)
# oznaczanych przez kolejne liczby naturalne 1, 2, itd.
# indeks 1 wskazuje na pierwszy element, ...



# [] - operator indeksujšcy

imie <- c("Janek", "Basia", "Adam", "Aga")


imie[0] # wektor pusty (nie ma takiego elementu)
imie[6] # nieznana wartość - NA



# braki danych (NA), wartosci nieskończone (Inf), nie-liczby (NaN)
# ------------------------------------------------------------------------
cena <- c(25, 33, 45, NA, 35, 40) # w tys. zł
is.na(c(25, 33, 45, NA, 35, 40))

3+NA



# funkcje agregujace dane # eksploracyjna analiza danych

x <- 1:6
y <- c(rep(0, 5), 1)


sum(x)
sum(y)
sum(x, y) # agregujaca 
x + y # zwektoryzowana



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


# ------------------------------------------------------------------------
# TYPY ZŁOŻONE
# ------------------------------------------------------------------------

# Ramki danych (data frame)
# ------------------------------------------------------------------------
# obiekty przypominajšce zbiory danych znane z programóW MS Excel, czy SPSS
# wiersze odpowiadaja obserwacjom, kolumny zmiennym

# SAS and SPSS (także Microsoft Excel) both use one main data structure, the data set. Instead, R
# has several different data structures including vectors, factors, data frames,
# matrices, arrays, and lists. The data frame is most like a data set in SAS or
# SPSS. R is flexible enough to allow you to create your own data structures,
# and some add-on packages do just that.

# install.packages("MASS")
# library(MASS)

data("Cars93") # pokazać (np.w prawym górnym oknie, że mamy różne typy danych)

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


# ------------------------------------------------------------------------
# Operacje na ramkach danych
# ------------------------------------------------------------------------

# Filtrowanie danych
# ------------------------------------------------------------------------
# Na ramce danych mozna wykonywac operacje indeksowania i wydobywania elementow

# wymiary ramki danych




# Dodawanie kolumn i wierszy





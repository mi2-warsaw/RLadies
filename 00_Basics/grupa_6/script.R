# Wczytanie ramki danych
oferty_informacje <- read.csv('00_Basics/pobranie_danych/oferty_informacje.csv')

# Jak możemy zobaczyć dane?
View(oferty_informacje)

# Kilka przydatnych komend do inspekcji danych 
names(oferty_informacje)
dim(oferty_informacje)
str(oferty_informacje)
nrow(oferty_informacje)

?table ## co robi funkcja table?
tabela_sprzedajacych <- table(oferty_informacje$sprzedajacy)
tabela_sprzedajacych_sort <- sort(tabela_sprzedajacych, decreasing = TRUE)
head(tabela_sprzedajacych_sort, 20)

# dplyr bardzo przydatna biblioteka do analizy danych
library(dplyr)

# ile ofert ma każdy sprzedający w naszym zbiorze - funkcja count
count_sprzedajacych <- count(oferty_informacje, sprzedajacy, sort = TRUE)
head(count_sprzedajacych, 5)

# sortowanie danych - funkcja arrange
oferty_informacje_arr <- arrange(oferty_informacje, cena)
(cena_tytul <- select(oferty_informacje_arr, cena, tytul))

oferty_informacje_arr_desc <- arrange(oferty_informacje, desc(cena))
(cena_tytul_desc <- select(oferty_informacje_arr_desc, cena, tytul))
head(cena_tytul_desc, 5)

# dodawanie dodatkowych kolumn - funkcja mutate
oferty_informacje_low <- mutate(oferty_informacje, tytul_lower = tolower(tytul))
head(oferty_informacje_low$tytul_lower)

# filtrowanie danych - funkcja filter
zapietki_wkladki <- grepl('zapiętki|wkładki', oferty_informacje_low$tytul_lower)

table(zapietki_wkladki)
oferty_informacje_low[zapietki_wkladki, ]
oferty_informacje_low[!zapietki_wkladki, ]
filter(oferty_informacje_low, !zapietki_wkladki)
  
oferty_informacje_flt <- filter(oferty_informacje_low, cena > 50 & lokalizacja == "Warszawa")

# wybieranie unikalnych wartości - funkcja distinct
marka <- distinct(oferty_informacje_flt, marka)

# podsumowanie - funkcja summarise
summarise(oferty_informacje_low, sr_cena = mean(cena, na.rm = T))

# grupowanie i operacje na pogrupowanych danych - funkcja group_by
oferty_informacje_lok <- group_by(oferty_informacje_low, lokalizacja)

summarise(oferty_informacje_lok, count = n(), sr_cena = mean(cena, na.rm = T))

# Zadanie 1
# Z danych oferty_informacje_low znajdź ofertę kaloszy o najniższej cenie (nie uwzględniając ceny wysyłki)

# Zadanie 2
# Który sprzedawca może jeszcze najwięcej zarobić

# Zaadanie 3
# Który sprzedawca ma jeszcze najwięcej artykułów do sprzedania ze wszystkich swoich aukcji

#  Proste wizualizacje
hist(oferty_informacje$cena)
hist(oferty_informacje_flt$cena)
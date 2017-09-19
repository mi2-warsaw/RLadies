#install.packages("tidyverse")
#browseURL("https://www.tidyverse.org/")

library(tidyverse)
library(tidyr)
library(dplyr)

##################################################################
###tidyr
##ładujemy potrzebne dane
load("wagi.rda")

##znak zapytania (?) i nazwa funkcji przenosi nas do dokumentacji
##gather
?gather

wagi_waskie <- gather(wagi, key=pomiar, waga, pomiar.1:pomiar.5)

##spread
?spread
wagi_szerokie <- spread(wagi_waskie , pomiar, waga)
#zauważmy, że wagi i wagi_szerokie to te same ramki danych

##separate
?separate

wagi_miejsca_rodzielone <- separate(wagi, miejsce, c("woj","miasto"), sep="\\.")


##unite
?unite

wagi_data_urodzenia <- unite(wagi, data_urodzenia, c("dzien_ur","mies_ur"),sep="-")


##Zadanie 1
#Dany jest zbiór ranking.rda
#a) Przerób ramkę do postaci szerokiej (tydzien, pozycja)
#b) Stwórz kolumnę z data ur (złożoną z 2 innych)
#c) Rozbij dane z jednej kolumny na 3 oddzielne

load("ranking.rda")


##################################################################
###dplyr
##Korzystamy z danych z pakietu PBImisc
library(PBImisc)
apartaments <- PBImisc::apartments

##select
?select
wybraneKolumny <-select(apartaments,c("city","district","street","m2.price"))

price <- select(apartaments,ends_with("price"))

##filter
?filter
Srodmiescie <- filter(wybraneKolumny,district=="Srodmiescie")
Srodmiescie_cena <- filter(wybraneKolumny,district=="Srodmiescie"& m2.price < 10000)
Srodmiescie_Ochota <- filter(wybraneKolumny,district=="Srodmiescie"| district=="Ochota")
Srodmiescie_ulica <- filter(wybraneKolumny,district=="Srodmiescie", street=="Bagno")

##Zadanie 2
#W zbiorze danych apartaments znajdź najtańsze mieszkanie (cena za m2) na Woli o powierzchni większej niż 50 m2.

##group_by
?group_by
apartaments_gr <- group_by(apartaments, district)
#nie zmienia nam ramki (ale w strukturze tabeli jest zapisane ze wiersze z taką samą wartością w kolumnie district są w jednej grupie)

##summarise
?summarise

apartaments_sr_cena <- summarise(apartaments_gr, mean_m2 = mean(m2.price))

apartaments_sr_pow<- summarise(apartaments_gr, mean_m2 = mean(surface), number=n())

 
##Zadanie 3
#a) Znajdź średnią liczbę pokoi w dzielnicach oraz średnią cenę transakcji
#b) Znajdź średnią ceną za mieszkanie grupując dane ze względu na zmienną "type"


##arrange
?arrange

dzielnice <- arrange(apartaments, district) #mamy alfabetycznie pogrupowane ze względu na dzielnice
dzielnice <- arrange(apartaments, district, desc(m2.price)) #cena za m2 malejąco

##mutate
?mutate

apartaments2 <- mutate(apartaments, sr_pow_pok = surface/n.rooms)
#dodaliśmy kolumnę ze średnią powierzchnią pokoju

##Zadanie 4
#a) Znajdź mieszkanie na Środmieciu, którego cena za m2 jest najniższa (arrange)
#b) Do zbioru danych apartaments dodaj kolumnę z ceną w EUR


####################################################
##%>% pipe operator
#służy do składania wielu komend na raz.

apartaments_sr_pow3 <- apartaments %>% group_by(district) %>% summarise(mean_surface = mean(surface))

#Zadanie 5
#Używając operatora %>% ponownie zrób zadanie 3b : Znajdź średnią ceną za mieszkanie grupując dane ze względu na zmienną "type"



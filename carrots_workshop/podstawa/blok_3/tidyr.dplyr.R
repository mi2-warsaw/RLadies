library(tidyverse)
library(tidyr)
library(dplyr)

##################################################################
#tidyr
##potrzebne dane
load("wagi.rda")


##gather
?gather

wagi_waskie <- gather(wagi, key=pomiar, waga, pomiar.1:pomiar.5)


##spread
?spread
wagi_szerokie <- spread(wagi_waskie , pomiar, waga)

#zauważmy, że wagi i wagi_szerokie to te same ramki danych

##separate
?separate

wagi_miejsca_rodzielone <- separate(wagi, miejsce, c("woj","miasto"), sep=".")


##unite
?unite

wagi_data_urodzenia <- unite(wagi, data_urodzenia, c("dzien_ur","mies_ur"),sep="-")


##zadanko
#dam ramke danych w postaci dlugiej (np pozycja w jakims rankingu):
##przerobic do postaci szerokiej (tydzien, pozycja)
##stworzyc kolumne z data ur (zlozona z 2 innych)
##rozbic dane z jednej kolumny na 3 oddzielne

load("ranking.rda")


##################################################################
#dplyr
#Korzystamy z danych
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
##zadanko
#Ze zbioru danych apartaments znajdz najtansze mieszkanie (cena za m2) na Woli o powierzchni wiekszej niż 50 m2.

##group_by
?group_by
apartaments_gr <- group_by(apartaments, district)
#nie zmienia nam ramki(ale w strukturze jest zapisane ze wiersze z taka sama wartoscia w kolumnie district sa w jednej grupie)

##summarise
?summarise

apartaments_sr_cena <- summarise(apartaments_gr, mean_m2 = mean(m2.price))

apartaments_sr_pow<- summarise(apartaments_gr, mean_m2 = mean(surface), number=n())

 
##zadanko
#Znajdz srednia liczbe pokoi w dzielnicach oraz srednia cene transakcji

#znajdz srednia cene za mieszkanie grupujac ze wzgledu na zmienną "type"


##arrange
?arrange

dzielnice <- arrange(apartaments, district) #mamy alfabetycznie pogrupowane ze wzgledu na dzielnice
dzielnice <- arrange(apartaments, district, desc(m2.price)) #cena za m2 malejaco 


##mutate
?mutate

apartaments2 <- mutate(apartaments, sr_pow_pok = surface/n.rooms)
#dodalismy kolumne ze srednia wielkoscia pokoju

#zadanko
#znajdz mieszkanie na Srodmieciu, ktorego cena za m2 jest najniższa (arrange)
#do zbioru danych apartaments dodaj kolumne z ceną w EUR


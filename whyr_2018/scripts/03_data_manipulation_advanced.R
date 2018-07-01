### Zaawansowana analiza danych z uzyciem pakietu dplyr i tidyr
### WhyR? 2018 - RLadies Meetup in Wroclaw
### Aleksandra Grudziaz (aleksandra.grudziaz@gmail.com)
### 2 lipca 2018

##############################################################
### Powtorzenie dplyr
##############################################################

#Zarowno pakiet dplyr jak i uzywany pozniej pakiet dplyr mozemy zaladowac uzywajac instrukcji
library(tidyverse)
#lub osobno
library(dplyr)
library(tidyr)

#wczytanie nowych danych

library(PogromcyDanych)
data("serialeIMDB")

head(serialeIMDB)

?serialeIMDB

# Kilka przydatnych komend do inspekcji danych 
names(serialeIMDB)
dim(serialeIMDB)
str(serialeIMDB)
nrow(serialeIMDB)
unique(serialeIMDB$serial)

### count
count_serialeIMDB <- count(serialeIMDB, serial, sort = TRUE)
head(count_serialeIMDB, 5)

### select
seriale <- select(serialeIMDB, "serial")
unique(seriale)

### filter
filter(count_serialeIMDB, serial == "House of Cards")

friends <-filter(serialeIMDB, serial == "Friends")
unique(friends$sezon)
length(unique(friends$sezon))

# min, max, mean
minimalna <- min(friends$ocena)
minimalna 
filter(friends, ocena==minimalna)

maksymalna <- max(friends$ocena)
filter(friends, ocena==maksymalna)

### group_by, summarize
friends_sezon <- group_by(friends, sezon)
friends_sr_sezon <- summarize(friends_sezon, sr_sezon = mean(ocena))
friends_liczba_glosow <- summarize(friends_sezon, liczba_glosow = sum(glosow))

friends_podsumowanie <- summarize(friends_sezon, liczba_glosow = sum(glosow), sr_sezon=mean(ocena))
View(friends_podsumowanie)

### arrange
arrange(friends, desc(ocena))

#Zadanie 1
#Wybrac swoj ulubiony serial i znalezc dla niego odcinki z najnizsza i najwysza ocena





###############################################################################################
###tidyr
###############################################################################################

#Teraz zajmiemy sie problemem oczyszczania danych przy pomocy pakietu tidyr - https://tidyr.tidyverse.org/
#Niezawsze mamy do czynienia z danymi w "czystej" postaci.
#Ale co tak naprawde oznacza czysta postac danych?
# Porzadne dane to dane, gdzie:
#-Kazda zmienna znajduje sie w kolumnie.
#-Kazda obserwacja jest w wierszu.
#-Kazda wartosc jest komorka

# w pakiecie tidyr zaimplementowane sa dwie, bardzo wazne funkcje do przeksztalcania danych do wlasciwej postaci.

### gather

tb <- read.csv("./data/tb.csv", stringsAsFactors = FALSE, sep=",")
tb <- select(tb, -X)
View(tb)

tb2 <- tb %>% 
  gather(demo, n, -iso2, -year, na.rm = TRUE)
View(tb2)


### separate
#dodatkowo, w pakiecie tidyr mamy funkcje ktore pomagaja np w rozbijaniu kolumny zawierajcej wiecej niz jedna wartosc
#w kolumnie demo mamy napis ktory mozemy podzielic na dwie kolumny
tb3 <- tb2 %>% 
  separate(demo, c("sex", "age"), 1)
View(tb3)



#Zadanie 2
#Wczytaj ramke danych weather.csv i z kolumn d1:d31 stworz nowa kolumne okreslajaca numer dnia, przypisz zmieniona ramke do zmiennej weather2






#Zadanie 3
#Z utworzonej ramki danych wybierz kolumny "id", "year", "month", "element", "day" i "value". Pozniej zmien kolejnosc ze wzgledu na zmienne id, year, month, day
#Przypisz wynik do zmiennej weather3





### spread
#W powyzszej ramce danych mamy w kolumnie element dwie wartosci tmax i tmin, ktore przeksztalcimy na nowe kolumny 
weather3 %>% spread(element, value)




####################################################################################
###dplyr - zaawansowane
####################################################################################

billboard <- read.csv("./data/billboard.csv", sep = ",", stringsAsFactors = FALSE)
View(billboard)

billboard <- select(billboard, -X)

#male czyszczenie
billboard2 <- billboard %>% 
  gather(week, rank, wk01:wk76, na.rm = TRUE)
View(billboard2)

### between
#przydatna funkcja np. do zliczania ile obserwacji przyjmuje wartosci w pewnym przedziale jest funkcja between

sum(billboard2$rank %>% between(1,10))


### mutate

billboard3 <- billboard2 %>%
  mutate(
    week = readr::parse_number(week),
    date = as.Date(date.entered) + 7 * (week - 1)) %>%
  select(-date.entered)

View(billboard3)

billboard3 %>% arrange(artist.inverted, track, week)

billboard3 %>% arrange(date, rank)

song <- billboard3 %>% 
  select(artist.inverted, track, year, time) %>%
  unique()

song$song_id <- 1:nrow(song)

### left_join
rank <- billboard3 %>%
  left_join(song, c("artist.inverted", "track", "year", "time")) %>%
  select(song_id, date, week, rank) %>%
  arrange(song_id, date)
View(rank)


#Zadanie 4
#Wypisz unikalnych artystow z powyzszej ramki danych. 
#Wybierz jednego i sprawdz ktory  z jego utworow znalazl sie  najwyzej w rankingu a ktory najnizej (odpowiednio zmien kolejnosc). Wypisz odpowiadajace miejsca wraz z data i tytulem utworu




#Zadanie 5
#Przeksztalc ramke danych rank tak aby zamiast kolumny date miec kolumny day, month, year. 
#Nastepnie Wypisz utwory tylko z lutego 2000 roku. 
#Znajdz najpopularniejsza piosenke z tego miesiaca w rankingu. 
#Wypisz ile utworow w calym zestawieniu billboard mial wykonawca ktorego piosenka byla najpopularniejsza w tym miesiacu.






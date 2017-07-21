## Pakiety
install.packages('dplyr')
library(dplyr)

install.packages('PogromcyDanych')
library(PogromcyDanych)

## Dane - seriale
data(serialeIMDB)
head(serialeIMDB)

?serialeIMDB

# Kilka przydatnych komend do inspekcji danych 
names(serialeIMDB)
dim(serialeIMDB)
str(serialeIMDB)
nrow(serialeIMDB)
unique(serialeIMDB$serial)

##pakiet dplyr
#funkcja count
count_serialeIMDB <- count(serialeIMDB, serial, sort = TRUE)
head(count_serialeIMDB, 5)

#funkcja filter
filter(count_serialeIMDB, serial == "House of Cards")
filter(count_serialeIMDB, n > 800)

friends <-filter(serialeIMDB, serial == "Friends")
unique(friends$sezon)
length(unique(friends$sezon))

# min, max, mean
minimalna <- min(friends$ocena)
minimalna 
filter(friends, ocena==minimalna)

maksymalna <- max(friends$ocena)
filter(friends, ocena==maksymalna)

mean(friends$ocena)


#group_by, summarize
friends_sezon <- group_by(friends, sezon)
friends_sr_sezon <- summarize(friends_sezon, sr_sezon = mean(ocena))
friends_liczba_glosow <- summarize(friends_sezon, liczba_glosow = sum(glosow))

friends_podsumowanie <- summarize(friends_sezon, liczba_glosow = sum(glosow), sr_sezon=mean(ocena))

#histogram
hist(friends$ocena)

#Zadanie
#a) przypisz do nowej zmiennej dane dotyczące wybranego przez Ciebie serialu,
#b) sprawdź, który odcinek wybranego serialu był najwyżej, a który najniżej oceniany,
#c) stwórz ramkę danych zawierającą średnią sumę głosów oraz średnią ocen dla każdego sezonu,
#d) narysuj histogram prezentujący liczbę ocen odcinków





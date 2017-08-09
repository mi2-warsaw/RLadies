# Po co nam wizualizacja?

###############
#Podstawowe wykresy
View(women)
plot(women)
?plot
plot(x=women$weight, y=women$height)
plot(x=women$weight, y=women$height, pch=2)
plot(x=women$weight, y=women$height, type="l")

##tytuł
plot(x=women$weight, y=women$height, type="l", main="Dane dotyczące kobiet w USA")
##podpisy osi
plot(x=women$weight, y=women$height, type="l", main="Dane dotyczące kobiet w USA", xlab = "waga", ylab="wiek")
## kolory
plot(x=women$weight, y=women$height, type="l", main="Dane dotyczące kobiet w USA", xlab = "waga", ylab="wiek", col="red")


###ZADANIE
#Dać zbiorek z kolumnami, wartości w których będą tworzyć obrazki (coś jak datazaur).
#Popróbowac rysowania róznych kolumn, dodanie kolorków i tytułów.



#Barplot
library(PogromcyDanych)
View(imiona_warszawa)
imiona <- filter(imiona_warszawa, rok==2012, miesiac==5)
imiona_mentorki <- filter(imiona, imie %in% c("Aleksandra", "Alicja", "Marta", "Martyna", "Paulina"))
barplot(imiona_mentorki$liczba, names.arg=imiona_mentorki$imie, main="Imiona mentorek")

### ZADANIE
  #pobawić się ze zbiorem koty_ptaki,
  #narysować histogram(gatunek - waga, żwotność, długość)
  #narysować wykres waga vs długość
  #Pamietajcie o tytułach i podpisach osi, kolory mile widziane ;)
View(koty_ptaki)



###############
#Histogram
View(maturaExam)

matura2013 <- filter(maturaExam, rok==2013, przedmiot=="matematyka")
hist(matura2013$punkty)
hist(matura2013$punkty, breaks = 50)

### ZADANIE
  #Na podstawie zbioru maturaExam sprawdź, czy również w przypadku matury z języka polskiego
  #występuje pik w okolicach 15 punktów.
  #Pamiętaj o tytule i podpisaniu osi wykresu.







###############
# Własne dane i więcej zabawy
x <- seq(from=0, to=10, length.out = 100)
y <- sin(x)
plot(x, y)
plot(x, y, main = "Plot of sin(x)", xlab = "x values", ylab = "sin(x)", type = "h", lwd = 2.5, col = "red")


### ZADANIE
  #wygenerować własne dane na używajac własnej lub jednej z podanych niżej funkcji lub ich kommbinacji:
  # log - logarytm
  # exp - potęga o podstawie e
  # cos
  # ^ - potęga















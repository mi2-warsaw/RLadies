# Po co nam wizualizacja?

vec1 <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5, 5, 5, 5, 5, 5, 4.5, 4, 3, 2, 3, 4, 5, 3.5, 2.5, 2.5, 3.5, 4.5, 1.5)
vec2 <- c(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5.5, 5, 4.5, 4, 3.5, 3, 3, 3, 3, 3, 2, 1, 0, 3, 3, 2.5, 1.5, 0.5, 3)

plot(vec1, vec2, pch = 19)

###############
#Podstawowe wykresy
View(women)
?women

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
plot(x=women$weight, y=women$height, type="l", main="Dane dotyczące kobiet w USA", xlab = "waga", ylab="wiek", col="#607b8b")


###ZADANIE
#Wczytaj zbiór z pliku dane.csv
#Spróbuj narysować zawarte w nim dane. 
#Pobaw się typem wykresu, kolorami, nadaj tytuł
#Pamiętaj o ustawieniu ścieżki - funkcja setwd()


dane <- read.csv("dane.csv")







#Barplot
library(PogromcyDanych)
View(imiona_warszawa)
imiona <- filter(imiona_warszawa, rok==2012, miesiac==5)
imiona_mentorki <- filter(imiona, imie %in% c("Aleksandra", "Alicja", "Marta", "Martyna", "Paulina"))

barplot(height = imiona_mentorki$liczba, names.arg=imiona_mentorki$imie, main="Imiona mentorek")
?barplot

### ZADANIE
  #pobawić się ze zbiorem koty_ptaki,
  #narysować wyskres słupkowy (gatunek - waga, żwotność, długość)
  #narysować wykres waga vs długość
  #Pamietajcie o tytułach i podpisach osi, kolory mile widziane ;)

View(koty_ptaki)






###############
#Histogram
View(maturaExam)

matura2013 <- filter(maturaExam, rok==2013, przedmiot=="j. polski")

hist(matura2013$punkty)
hist(matura2013$punkty, breaks = 100)

### ZADANIE
  #Na podstawie zbioru maturaExam sprawdź, czy również w przypadku matury z matematyki
  #występuje pik w okolicach 30 procent.
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















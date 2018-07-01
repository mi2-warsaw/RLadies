## Ładowanie pakietów

library(ggplot2)
library(dplyr)

## Wczytanie danych
titanic = read.csv2('titanic.csv', sep = ',', dec = '.')

head(titanic)
str(titanic)

## Nasz pierwszy wykres!
## Wykres punktowy pokazujący zależność między wiekiem pasażerów, a opłatą jaką ponieśli za bilet

ggplot(titanic, aes(x = Age, y = Fare)) +
  geom_point()

## Dodanie tytułu
ggplot(titanic, aes(x = Age, y = Fare)) +
  geom_point() +
  labs(title = 'Analiza wieku pasażerów Titanica')
  
## Zmiana podpisów osi
ggplot(titanic, aes(x = Age, y = Fare)) +
  geom_point() +
  labs(title = 'Analiza wieku pasażerów Titanica',
       x = 'Wiek',
       y = 'Opłata za bilet')

## Alternatywnie
ggplot(titanic, aes(x = Age, y = Fare)) +
  geom_point() +
  ggtitle('Analiza wieku pasażerów Titanica') +
  xlab('Wiek') +
  ylab('Opłata za bilet')

## Kolor jako klasa w której podróżował pasażer
## Uwaga - zmienna Pclass ma typ numeric a chcemy potraktować ją jako zmienną kategoryczną
ggplot(titanic, aes(x = Age, y = Fare, color = factor(Pclass))) +
  geom_point() +
  labs(title = 'Analiza wieku pasażerów Titanica',
       x = 'Wiek',
       y = 'Opłata za bilet')


## Zmiana tytułu legendy
ggplot(titanic, aes(x = Age, y = Fare, color = factor(Pclass))) +
  geom_point() +
  labs(title = 'Analiza wieku pasażerów Titanica',
       x = 'Wiek',
       y = 'Opłata za bilet',
       color = 'Klasa')

## Czas na pierwsze zadanie
## Narysuj wykres punktowy, dla zadanych wektorów x i y

x <- c(55.3846, 51.5385, 46.1538, 42.8205, 40.7692, 38.7179, 35.6410, 33.0769, 28.9744, 26.1538, 23.0769, 22.3077, 22.3077, 23.3333, 25.8974, 29.4872, 32.8205, 35.3846, 40.2564, 44.1026, 46.6667, 50.0000, 53.0769, 56.6667, 59.2308, 61.2821, 61.5385, 61.7949, 57.4359, 54.8718, 52.5641, 48.2051, 49.4872, 51.0256, 45.3846, 42.8205, 38.7179, 35.1282, 32.5641, 30.0000, 33.5897, 36.6667, 38.2051, 29.7436, 29.7436, 30.0000, 32.0513, 35.8974, 41.0256, 44.1026, 47.1795, 49.4872, 51.5385, 53.5897, 55.1282, 56.6667, 59.2308, 62.3077, 64.8718, 67.9487, 70.5128, 71.5385, 71.5385, 69.4872, 46.9231, 48.2051, 50.0000, 53.0769, 55.3846, 56.6667, 56.1538, 53.8462, 51.2821, 50.0000, 47.9487, 29.7436, 29.7436, 31.2821, 57.9487, 61.7949, 64.8718, 68.4615, 70.7692, 72.0513, 73.8462, 75.1282, 76.6667, 77.6923, 79.7436, 81.7949, 83.3333, 85.1282, 86.4103, 87.9487, 89.4872, 93.3333, 95.3846, 98.2051, 56.6667, 59.2308, 60.7692, 63.0769, 64.1026, 64.3590, 74.3590, 71.2821, 67.9487, 65.8974, 63.0769, 61.2821, 58.7179, 55.1282, 52.3077, 49.7436, 47.4359, 44.8718, 48.7179, 51.2821, 54.1026, 56.1538, 52.0513, 48.7179, 47.1795, 46.1538, 50.5128, 53.8462, 57.4359, 60.0000, 64.1026, 66.9231, 71.2821, 74.3590, 78.2051, 67.9487, 68.4615, 68.2051, 37.6923, 39.4872, 91.2821, 50.0000, 47.9487, 44.1026)
y <- c(97.1795, 96.0256, 94.4872, 91.4103, 88.3333, 84.8718, 79.8718, 77.5641, 74.4872, 71.4103, 66.4103, 61.7949, 57.1795, 52.9487, 51.0256, 51.0256, 51.0256, 51.4103, 51.4103, 52.9487, 54.1026, 55.2564, 55.6410, 56.0256, 57.9487, 62.1795, 66.4103, 69.1026, 55.2564, 49.8718, 46.0256, 38.3333, 42.1795, 44.1026, 36.4103, 32.5641, 31.4103, 30.2564, 32.1795, 36.7949, 41.4103, 45.6410, 49.1026, 36.0256, 32.1795, 29.1026, 26.7949, 25.2564, 25.2564, 25.6410, 28.7180, 31.4103, 34.8718, 37.5641, 40.6410, 42.1795, 44.4872, 46.0256, 46.7949, 47.9487, 53.7180, 60.6410, 64.4872, 69.4872, 79.8718, 84.1026, 85.2564, 85.2564, 86.0256, 86.0256, 82.9487, 80.6410, 78.7180, 78.7180, 77.5641, 59.8718, 62.1795, 62.5641, 99.4872, 99.1026, 97.5641, 94.1026, 91.0256, 86.4103, 83.3333, 79.1026, 75.2564, 71.4103, 66.7949, 60.2564, 55.2564, 51.4103, 47.5641, 46.0256, 42.5641, 39.8718, 36.7949, 33.7180, 40.6410, 38.3333, 33.7180, 29.1026, 25.2564, 24.1026, 22.9487, 22.9487, 22.1795, 20.2564, 19.1026, 19.1026, 18.3333, 18.3333, 18.3333, 17.5641, 16.0256, 13.7180, 14.8718, 14.8718, 14.8718, 14.1026, 12.5641, 11.0256, 9.8718, 6.0256, 9.4872, 10.2564, 10.2564, 10.6410, 10.6410, 10.6410, 10.6410, 10.6410, 10.6410, 8.7180, 5.2564, 2.9487, 25.7692, 25.3846, 41.5385, 95.7692, 95.0000, 92.6923)

## Wracając do naszego przykładu

## Zwiększmy kółeczka i zróbmy je lekko przezroczyste 
ggplot(titanic, aes(x = Age, y = Fare, color = factor(Pclass))) +
  geom_point(size = 2, alpha = 0.6) +
  labs(title = 'Analiza wieku pasażerów Titanica',
       x = 'Wiek',
       y = 'Opłata za bilet',
       color = 'Klasa')

## Zmieńmy kółeczka na inny symbol
ggplot(titanic, aes(x = Age, y = Fare, color = factor(Pclass))) +
  geom_point(shape = 8, size = 2) +
  labs(title = 'Analiza wieku pasażerów Titanica',
       x = 'Wiek',
       y = 'Opłata za bilet',
       color = 'Klasa')

## Można też zaznaczyć kobiety i mężczyzn różnymi kształtami
ggplot(titanic, aes(x = Age, y = Fare, color = factor(Pclass))) +
  geom_point(aes(shape = factor(Sex))) +
  labs(title = 'Analiza wieku pasażerów Titanica',
       x = 'Wiek',
       y = 'Opłata za bilet',
       color = 'Klasa',
       shape = 'Płeć')

## Zróbmy wykres ładniejszy!
ggplot(titanic, aes(x = Age, y = Fare, color = factor(Pclass))) +
  geom_point(aes(shape = factor(Sex)), size = 2) +
  labs(title = 'Analiza wieku pasażerów Titanica',
       x = 'Wiek',
       y = 'Opłata za bilet',
       color = 'Klasa',
       shape = 'Płeć') +
  theme_minimal()

## Jakie inne wykresy możemy uzyskać w analogiczny sposób?

## Wykres słupkowy
## Liczba osób którzy przeżyli i nie przeżyli katastrofy w podziale na klasy

survived <-  titanic %>%
  group_by(Pclass, Survived) %>%
  summarise(cnt = n()) %>%
  as.data.frame()

survived

ggplot(survived, aes(factor(Survived), cnt, fill = factor(Pclass))) +
  geom_bar(stat = 'identity')

ggplot(survived, aes(factor(Survived), cnt, fill = factor(Pclass))) +
  geom_bar(stat = 'identity') +
  geom_text(label = survived$cnt, position = 'stack')

ggplot(survived, aes(factor(Survived), cnt, fill = factor(Pclass))) +
  geom_bar(stat = 'identity', position = position_dodge()) 

# Wykres liniowy
# Podzielmy pasażerów na grupy według wieku, a następnie policzmy w tych grupach średnią opłatę 

bins = titanic %>%
  select(Age, Fare, Sex) %>% 
  mutate(bins = as.numeric(as.character(cut(Age, breaks = seq(0, 100, 10), labels =  seq(10, 100, 10))))) %>% 
  group_by(bins, Sex) %>%
  summarise(mean_fare= mean(Fare))

ggplot(bins, aes(bins, mean_fare, color = Sex)) + 
  geom_path(size = 1.5) +
  geom_point(size = 3)
 
## Histogram
ggplot(titanic, aes(Age)) + geom_histogram()

## Zadanie drugie
## Narysuj wykres słupkowy prezentujacy liczbę osób danej płci w poszczególnych klasach

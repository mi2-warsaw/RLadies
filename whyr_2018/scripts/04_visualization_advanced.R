### WhyR? 2018 - RLadies Meetup in Wroclaw
### Alicja Gosiewska (alicjagosiewska@gmail.com)
### 2 lipca 2018 r.


################################################################################
### PAKIETY
################################################################################
library(ggplot2)
library(PogromcyDanych)
library(dplyr)


################################################################################
### ggplot2, dplyr - KRÓTKIE PRZYPOMNIENIE
################################################################################

data("serialeIMDB")
View(serialeIMDB)

serialeIMDB$sezon <- as.numeric(as.character(serialeIMDB$sezon))
serialeIMDB$odcinek <- as.numeric(as.character(serialeIMDB$odcinek))

GoT <- filter(serialeIMDB, serial == "Game of Thrones")

ggplot(GoT, aes(x = sezon, y = ocena)) + 
    geom_point() +
    ggtitle("Oceny sezonów serialu Gra o Tron")



GoT_means <- group_by(GoT, sezon) %>%
    summarise(ocena = mean(ocena))

ggplot(GoT_means, aes(x = sezon, y = ocena)) +
    geom_point(size = 4)


### Zadanie 1
# Narysuj średnie oceny poszczególnych sezonów wybranego przez siebie serialu.
# Pamiętaj o tytule, kolory inne niż domyślne mile widziane :)






################################################################################
### ggplot2 - geom_smooth
################################################################################

ggplot(GoT_means, aes(x = sezon, y = ocena)) +
    geom_point(size = 4) +
    geom_smooth(method = lm, se = FALSE)

GoT_Sherlock <- filter(serialeIMDB, serial == "Game of Thrones" | serial == "Sherlock")
GoT_Sherlock_means <- group_by(GoT_Sherlock, sezon, serial) %>%
    summarise(ocena = mean(ocena))

ggplot(GoT_Sherlock_means, aes(x = sezon, y = ocena, color = serial)) +
    geom_point(size = 4) +
    geom_smooth(method = lm, se = FALSE)


### Zadanie 2
# Narysuj analogiczne wykresy dla trzech innych wybranych seriali. (Najlepiej seriale z przynajmniej trzema sezonami)
# Spróbuj użyć innych wartości 'method' w geom_smooth().

?geom_smooth






################################################################################
### ggplot2 - facet_wrap
################################################################################

p <- ggplot(GoT, aes(x = odcinek, y = ocena)) + 
        geom_point() +
        geom_smooth(method = lm, se = FALSE)
p


p + facet_wrap(~sezon)


### Zadanie 3
# Użyj funkcji facet_wrap() do porównania poszczególnych sezonów dwóch wybranych seriali.



################################################################################
### PLOTLY
### Przykłady: https://plot.ly/r/
################################################################################

library(plotly)

################################################################################
### ggplot2 - ggplotly
################################################################################

p <- ggplot(GoT, aes(x = odcinek, y = ocena)) + 
        geom_point() +
        geom_smooth(method = lm, se = FALSE) +
        facet_wrap(~sezon)
p

ggplotly(p)




################################################################################
### plotly - ggplotly
################################################################################

data(maturaExam)
View(maturaExam)

maturaExam2013pol <- filter(maturaExam, rok == 2013, przedmiot == "j. polski")

(p <- ggplot(maturaExam2013pol, aes(x = punkty)) + geom_histogram(binwidth = 1))

ggplotly(p)


# Zadanie 4 
# Narysuj interaktywny histogram wyników z matematyki dla wybranego przez siebie roku. 
# Czy widać zależność taką, jak w przypadku języka polskiego?




################################################################################
### plotly - plot_ly
################################################################################


plot_ly(data = maturaExam2013pol, x = ~punkty, type = "histogram")

plot_ly(data = maturaExam2013pol, x = ~punkty, type = "histogram") %>%
    layout(title = 'Histogram matur z języka polskiego w roku 2013')

?layout


# Zadanie 5
# Stwórz inteaktywny wykres, ze średnim wynikiem z matury z matematyki w poszczególnych latach.
# Skorzystaj z plot_ly. 
# Przykładowe wykresy punktowe: https://plot.ly/r/line-and-scatter/#basic-scatter-plot





###################

# Zadanie 6
# Stwórz inteaktywny wykres, ze średnim wynikiem z matur dla poszczególnych lat, 
# w podziale na przedmioty.
# Wskazówka: użyj ggplot2() z facet_wrap(), a następnie ggplotly()



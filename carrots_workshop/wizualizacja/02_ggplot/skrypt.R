library("dplyr")
library("ggplot2")

load("./data/dane_czyste_2017-08-25.Rdata")

head(dane)

# punktowy:

ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point()

ggplot(dane, aes(x = powierzchnia, y = cena, 
                 color = rodzaj_zabudowy)) +
    geom_point()

ggplot(dane, aes(x = powierzchnia, y = cena, 
                 color = rodzaj_zabudowy, shape = rynek)) +
    geom_point()

ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point() +
    geom_smooth()

# liniowy:

ggplot(dane, aes(x = rok_budowy, y = cena)) +
    geom_point()

dane %>% 
    group_by(rok_budowy) %>% 
    summarise(sr_cena = mean(cena)) -> dane_tmp

ggplot(dane_tmp, aes(x = rok_budowy, y = sr_cena)) +
    geom_point() +
    geom_line()

# slupkowy:

ggplot(dane, aes(x = rodzaj_zabudowy)) +
    geom_bar()

dane %>% 
    group_by(rodzaj_zabudowy) %>% 
    summarise(ile = n(),
              sr_cena_metr = round(mean(cena_metr))) -> dane_tmp

ggplot(dane_tmp, aes(x = rodzaj_zabudowy, y = ile, label = sr_cena_metr)) +
    geom_bar(stat = "identity") +
    geom_text()

# boxplot:

ggplot(dane, aes(x = rodzaj_zabudowy, y = cena_metr)) +
    geom_boxplot()



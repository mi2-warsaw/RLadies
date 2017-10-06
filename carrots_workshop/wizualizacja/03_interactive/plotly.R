library(plotly)
library(viridis)

load("data/dane_czyste_2017-08-25.Rdata")

## GGplot2 => plotly
ggplotly()

## Prosty wykres
plot_ly(data = dane, x = ~powierzchnia, y = ~cena, color = ~rodzaj_zabudowy)

## Zmienmy kolory
n_colors <- length(unique(dane$rodzaj_zabudowy))

plot_ly(data = dane, x = ~powierzchnia, y = ~cena, color = ~rodzaj_zabudowy, colors =  viridis(n_colors))

## Tooltip
plot_ly(data = dane, x = ~powierzchnia, y = ~cena, color = ~rodzaj_zabudowy, colors =  viridis(n_colors),
        text = ~paste("Powierzchnia: ", powierzchnia, 'm2<br>Cena:', cena, 'PLN'))

## Dodajmy rozmiar kropek
plot_ly(data = dane, x = ~powierzchnia, y = ~cena, color = ~rodzaj_zabudowy, colors =  viridis(n_colors),
        text = ~paste("Powierzchnia: ", powierzchnia, 'm2<br>Cena:', cena, 'PLN'),
        size = ~liczba_pokoi)

## Ostylujmy
plot_ly(data = dane, x = ~powierzchnia, y = ~cena, color = ~rodzaj_zabudowy, colors =  viridis(n_colors),
        text = ~paste("Powierzchnia: ", powierzchnia, 'm2<br>Cena:', cena, 'PLN'),
        size = ~liczba_pokoi) %>% 
  layout(title = 'Powierzchnia vs. cena',
         yaxis = list(title = "Cena w PLN"),
         xaxis = list(title = "Powierzchnia w m2"))

## Wykres słupkowy
house_type_price <- dane %>%
  group_by(rodzaj_zabudowy) %>%
  summarise(mean_price = mean(cena)) %>%
  arrange(mean_price)

plot_ly(house_type_price, x = ~rodzaj_zabudowy, y = ~mean_price, type = 'bar')

## Posortujmy
plot_ly(house_type_price, x = ~rodzaj_zabudowy, y = ~mean_price, type = 'bar') %>% 
  layout(xaxis = list(categoryarray = ~names, categoryorder = "array"))

library(leaflet)

dane[1:10, ] %>% leaflet() %>% addTiles() %>% addCircleMarkers(lng = ~lon, lat = ~lat, popup = ~paste("Cena", cena))

dane[1:10, ] %>% leaflet() %>% addProviderTiles(providers$CartoDB.Positron) %>% 
  addMarkers(lng = ~lon, lat = ~lat, popup = ~paste("Cena", cena))

dane[1:10, ] %>% leaflet() %>% addProviderTiles(providers$CartoDB.Positron) %>% 
  addCircleMarkers(lng = ~lon, lat = ~lat, popup = ~paste("Cena", cena), color = "red")

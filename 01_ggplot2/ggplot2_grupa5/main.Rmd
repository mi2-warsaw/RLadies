---
title: ggplot2
author: Wickham Hadley, Katarzyna Sobiczewska
output: 
  slidy_presentation:
    font_adjustment: -1
    fig_width: 7
    fig_height: 6
    background: 'black'
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, cache=TRUE, fig.align = 'center', fig.height = 10, fig.width = 10)
```


## Gramatyka grafiki


```r
library(ggplot2)
```

```r
ggplot(data = nazwa_zbioru, aes(x=..., y=..., group=..., color=..., size=..., alpha=...) ) +
  geom_point(...) +
  geom_line(...) +
  geom_bar(...) +
  geom_density(...) + 
  geom_boxplot(...) +
  _________________________________________
  labs( x=..., y=..., title=...)
  -----------------------------------------
  scale_*_manual(values=c(...)) +
  scale_*_continous(...) + 
  scale_*_discrete(...)
  _________________________________________
  coord_flip() +
  coord_polar() +
  coord_cartesian(xlim=c(-5,5))
  _________________________________________
  theme( axis.title = element_text(family=..., face=..., color=..., size=..., hjust=...
                                    vjust=..., angle=..., ....),
          axis.title.x = element_text(...),
          axis.title.y = element_text(...),
          axis.text.x = element_text(...) )
```

### Tablice ggplot-owe

https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

## {}

![Charles Joseph Minard - Napoleon's March (1869)](napoleon.png)


## Dane

```{r}
library(HistData)
head(Minard.cities, n=5)
head(Minard.troops, n=5)
head(Minard.temp, n=5)
```

## Nasz pierwszy wykres

```{r}
ggplot(Minard.cities, aes(x=long, y=lat)) +
  geom_point()
```

## Nasz pierwszy wykres

Alternatywne zapisy tego samego:

```r
g <- ggplot(Minard.cities, aes(x=long, y=lat))
g + geom_point()

ggplot() + geom_point(data=Minard.cities, aes(x=long, y=lat))
```

Dodajemy kolejną warstwę do wykresu: tekst.

```r
ggplot(Minard.cities, aes(x=long, y=lat)) +
  geom_point() + 
  geom_text(aes(label = city))
```

```{r}
ggplot(Minard.cities, aes(x=long, y=lat, label=city)) +
 geom_point() + 
 geom_text()
```


```{r}
ggplot(Minard.cities, aes(x=long, y=lat)) +
  geom_point() + 
  geom_text(aes(label = city), size=3, nudge_y=0.08)
```


## Dwa zbiory danych na jednym wykresie

Dodamy nową warstwę ale z nowymi danymi. Aby nie kopowiać wielokrotnie tego samego początku, który rysuje nam miasta, możemy łatwo przypisać dotychczasowy wykres do zmiennej (nazwijmy ją `wykres`) i do tej zmiennej dodawać nowe warstwy!

```{r}
wykres <- ggplot(Minard.cities, aes(x=long, y=lat)) +
  geom_point() + 
  geom_text(aes(label = city), size=3, nudge_y=0.08) 

wykres +
  geom_path(data=Minard.troops, aes(long,lat))
```

## Dwa zbiory danych na jednym wykresie

```{r}
wykres +
  geom_path(data=Minard.troops, aes(long,lat, color=direction) )
```

## Dwa zbiory danych na jednym wykresie

Plątatnina kresek z lewej strony wykresu w niczym nie przypomina oryginalnego dzieła Minarda. Widzimy, że `geom_path` łączy ze sobą wszystkie kolejne punkty, nie uwzględniając group żołnierzy, które odłączyły się w trakcie marszu. Pogrupujmy więc punkty (long, lat) wg. odpowiednich grup piechurów. Dołożymy również do wykresu tytuł: `ggtitle()` jest tylko jednym ze sposobów. Innym byłaby funkcja `labs()`.

```{r}
wykres +
  geom_path(data=Minard.troops, aes(long,lat, color=direction, group=group) ) +
  ggtitle('Inwazja Napoleona na Rosję (1812)')
```

## Dwa zbiory danych na jednym wykresie

Jak wyrazić liczbę żołnieży poprzez grubość linii? 

```{r}
wykres +
  geom_path(data=Minard.troops, aes(long,lat, color=direction, group=group, size=survivors)) +
  ggtitle('Inwazja Napoleona na Rosję (1812)') 
```

## Estetyka

Jesteśmy coraz bliżej, popracujemy jeszcze nad kwestiami estetycznymi: kolorystyką oraz wyglądem legendy. Zauważmy, że mamy dwa typy legend na dwóch wymiarach wykresu: `size` oraz `colour`. Zmienna `survivors` leżąca na wymiarze `size` jest typu ciągłego. Do poprawki legendy wykorzystamy parametr `scale_*_**` w miejsce `*` wstawiając odpowiedni wymiar.

```{r}
wykres +
  geom_path(data=Minard.troops, aes(long,lat, colour=direction, group=group, size=survivors)) +
  ggtitle('Inwazja Napoleona na Rosję (1812)') +
  scale_colour_manual(values=c("orange","darkgray"), labels=c('Inwazja', 'Powrót'), name='Kierunek') + 
  scale_size_continuous(name = 'Liczba żołnierzy')
```

Powyższy rysunek jest dobrym przykładem tego, że kolejne warstwy nakładają się na siebie: punkty i nazwy miast, które umieściłyśmy na początku zostały prawie zupełnie przykryte naszą ścieżką. Poprawimy to na kolejnym przykładzie, zmieniając kolejność nakładanych warstw. Zobaczymy przy okazji w jaki sposób wygląda całościowy kod tworzący nasz obrazek.

## {}

```{r}
ggplot(Minard.cities, aes(x=long, y=lat)) +
  geom_path(data=Minard.troops, aes(long,lat, color=direction, group=group, size=survivors)) +
  ggtitle('Inwazja Napoleona na Rosję (1812)') +
  scale_colour_manual(values=c("orange","darkgray"), labels=c('Inwazja', 'Powrót'), name='Kierunek') + 
  scale_size_continuous(name = 'Liczba żołnierzy') +
  geom_point() + 
  geom_text(aes(label = city), size=3, nudge_y=0.08) 
```


## Wykres temperatury (Ćwiczenie)

Wykorzystajmy zbiór `Minard.temp` do narysowania wykresu temperatury na danej długości geograficznej. Przykładowy wykres może wyglądać następująco:

```{r, echo=FALSE}
ggplot(data = Minard.temp, aes(x=long, y=temp)) +
  geom_line(size=.3) +
  geom_point() +
  xlim(range(Minard.troops$long)) +
  geom_text(aes(label=paste0(temp,'*C ', date)), nudge_y=2, size=4 )
```

## Inne pożyteczne wykresy: 
### Zależność zmiennej ciągłej od kategorialnej.

Zmienianie się liczby żołnierzy podczas wyprawy, w poszczególnych grupach.  `ggplot()` oraz funkcja `aes()` wymagają, aby zmienna przechowująca nazwy kategorii, była typu `factor()`. Na wszelki wypadek, warto taki typ wymusić.

```{r}
ggplot(Minard.troops, aes(x=as.factor(group), y=survivors)) + 
  geom_boxplot()
```


## Inne pożyteczne wykresy
### Grupowanie boxplotów za pomocą wypełnienia wykresu.

```{r}
ggplot(Minard.troops) +
  geom_boxplot(aes(x=as.factor(group), y=survivors, fill=direction)) +
  labs( x='Grupa piechurów', y = 'Liczba żywych', fill='Kierunek') +
  scale_fill_brewer(labels=c('Inwazja','Powrót'), palette=5)
```

## Inne pożyteczne wykresy
### Grupowanie wykresów z wykorzystaniem paneli.

```{r}
ggplot(Minard.troops) +
  geom_boxplot(aes(x=direction, y=survivors)) +
  scale_x_discrete(labels=c('Inwazja','Powrót')) +
  facet_grid( ~group )
```

## Zadania samodzielne

Poniżej podaję proste zadania do samodzielnego wykonania oraz przykładowe rozwiązanie.

```{r, message=FALSE}
library(PogromcyDanych)
```

### 1. WYKRES PUNKTOWY

#### Czy ocena serialu i liczba oddanych głosów od siebie zależą?

### 2. WYKRES PUDEŁKOWY 1

#### Wybierz ulubiony serial. Jakie miał oceny w poszczególnych sezonach?

```{r, echo=FALSE}
friends = serialeIMDB[ serialeIMDB$serial=='Friends', ]
ggplot(data=friends) +
  geom_boxplot(aes(x=sezon, y=ocena)) +
  ggtitle('Friends')
```

### 3. WYKRES PUDEŁKOWY 2

#### Wybierz kilka seriali. Który z nich miał lepsze noty? Jak zmieniała się opinia widowni w poszczególnych sezonach?

```{r, echo=FALSE}
kilka = serialeIMDB[ serialeIMDB$serial %in% c('Friends','The Big Bang Theory','Prison Break', 'Game of Thrones'),1:7 ]

ggplot(data=kilka) +
  geom_boxplot(aes(x=sezon, y=ocena, fill=serial)) +
  facet_grid( ~serial, scales='free_x')
```

### 4. WYKRES SŁUPKOWY

#### Ile było dodanych głosów w najchętniej i najmniej chętnie oglądanym sezonie wybranego serialu? Jaka to była ocena?

```{r, echo=FALSE}
library(dplyr)
out = serialeIMDB %>% filter( (serial == 'The Big Bang Theory' & sezon==8) | (serial == 'Game of Thrones' & sezon==4))
out$odcinek <- factor(out$odcinek, levels = 1:13, labels = 1:13, ordered=TRUE)
ggplot(out, aes(x=odcinek, y=glosow, fill=ocena, group = serial)) + 
  geom_bar( stat = 'identity', position = 'dodge')
```




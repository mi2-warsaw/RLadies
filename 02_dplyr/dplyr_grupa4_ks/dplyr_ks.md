---
title: "dplyr"
output: html_document
---

```{r, echo=FALSE}
library(knitr)
opts_chunk$set(comment="", cache=TRUE)
```


<style type="text/css">

body, td {
   font-size: 14px;
}
code.r{
  font-size: 12px;
  width: 100%;
}
pre {
  font-size: 8px;
  width: 100%;
  padding: 5px;
}
</style>


### Podstawowe operacje:

* `select()`
* `filter()`
* `arrange()`
* `distinct()`
* `mutate()`
* `summarise()`
* `sample_n()`

### Złożone polecenia i potoki

Sposób 1.

```{r}
a <- iris[iris$Sepal.Width > 2, ]
b <- a[a$Species %in% c('setosa', 'virginica'), ]
c <- b[, c('Sepal.Length', 'Petal.Length')]
d <- data.frame(c, sum = c[,1] + c[,2])
head(d)
```

Sposób 2.

```{r}
a <- iris[(iris$Sepal.Width > 2) & (iris$Species %in% c('setosa', 'virginica')), c('Sepal.Length', 'Petal.Length')]
b <- data.frame(a, sum = a[,1] + a[,2])
head(b)
```

Sposób 3.

```{r, message=FALSE}
library(dplyr)
iris %>% 
  filter(Sepal.Width > 2 & Species %in% c('setosa', 'virginica')) %>% 
  select(Sepal.Length, Sepal.Width) %>% 
  mutate(aum = Sepal.Length + Sepal.Width) %>% head
```

## World food facts

```{r, message=FALSE}
library('dplyr')
wff <- read.csv('en.openfoodfacts.org.products.tsv', sep = '\t')
```


```{r, echo=TRUE, results='markup'}
dim(wff)
```

### `select()`, `filter()`

```{r}
wff %>% 
  select(origins, cities_tags, countries_en, main_category_en, quantity, stores) %>% 
  sample_n(10)
```

```{r}
wff %>% 
  select(contains('date')) %>% head
```

```{r}
wff %>% 
  select(ends_with('_n')) %>% sample_n(5)
```

```{r}
wff %>% 
  select(starts_with('vitamin')) %>% sample_n(5)
```


```{r}
wff %>% 
  filter(main_category_en %in% c('Banana-chips', 'Kangaroo')) %>% 
  select(countries_en, main_category_en, quantity, packaging, stores)
```

```{r}
wff %>% 
  select(main_category_en, contains('vitamin')) %>% 
  filter(grepl('chips', main_category_en)) %>% 
  distinct()
```

### `group_by()` i `summarise()`

__Przykład 1.__ Liczba produktów per kraj

```{r}
wff %>% 
  group_by(countries_en) %>% 
  summarise(sum = n()) %>% 
  arrange(-sum) -> wff_country
```

```{r}
wff_country %>% head
wff_country %>% tail
```

__Przykład 2.__ Liczba produktów per sklep + kraj

```{r}
wff %>%
  filter(stores != '' ) %>% 
  group_by(countries_en,stores) %>% 
  summarise(n = n()) %>% 
  mutate(freq = n/sum(n)) %>% arrange(-n) %>% head(20)
```

__Przykład 3.__ Zawartość cukru w produktach w poszczególnych krajach

```{r}
wff %>% 
  select(countries_en, matches('sugar|gluc')) %>%
  group_by(countries_en) %>%
  summarise_each(funs(mean(.,na.rm=TRUE)), -countries_en) %>% 
  arrange(-sugars_100g) -> cukry

with(cukry, plot(sugars_100g, 
                 pch = 20, 
                 col = ifelse(grepl('Poland', countries_en), 'red','black')))
```

```{r}
filter(cukry, countries_en == 'Poland')
filter(cukry, grepl('Poland', countries_en))
```

### `mutate()`

__Przykład 4.__ Zawartość oleju palmowego w produktach w poszczególnych krajach

```{r}
wff %>%
  mutate(nan_palm_oil = as.integer(is.na(ingredients_from_palm_oil_n) | ingredients_from_palm_oil_n == 0),
         country = substr(countries_en, 1, 15)) %>% 
  group_by(country) %>% 
  summarise(n = mean(nan_palm_oil)) %>% arrange(n)
```

__Przykład 5.__ Przyrost liczby produktów w czasie

```{r}
wff %>%
  arrange(created_datetime) %>% 
  mutate(created_year = substr(created_datetime,1,4),
         created_month = substr(created_datetime,6,7),
         created_day = substr(created_datetime,9,10)) %>% 
  group_by(created_year, created_month, created_day)  %>% 
  summarise(n = n()) -> prod_in_time
plot(cumsum(prod_in_time$n), type='l')
```


__Przykład 6.__ Porównanie składu produktów wegańskich do "zwykłych"

```{r}
wff %>% 
  mutate(is_vegan = as.integer(grepl('vegan', wff$labels))) %>% 
  select(is_vegan, salt_100g, fat_100g, sugars_100g, energy_100g, saturated.fat_100g, proteins_100g, carbohydrates_100g) %>% 
  mutate_each(funs(ifelse(is.na(.),0,.)), -is_vegan) %>%
  group_by(is_vegan) %>%
  summarise_all(mean)
```


## Zadania

__Ćwiczenie__ Użycie soli w krajach.

```{r, echo=FALSE}
wff %>% 
  select(countries_en, starts_with('salt')) %>% 
  mutate(salt = ifelse(is.na(salt_100g), 0, salt_100g),
         country = substr(countries_en, 1, 15)) %>% 
  group_by(country) %>% 
  summarise(
    salt_sum = sum(salt),
    salt_mean = mean(salt)) %>% arrange(-salt_mean) %>% head(20)
```

__Ćwiczenie__ Zawartość konserwantów w produktach w czasie.

```{r, echo = FALSE}
wff %>%
  arrange(created_datetime) %>% 
  mutate(created_year = substr(created_datetime,1,4),
         created_month = substr(created_datetime,6,7),
         created_day = substr(created_datetime,9,10)) %>% 
  group_by(created_year, created_month) %>% 
  summarise(n=sum(additives_n, na.rm=TRUE)) %>%
  ungroup %>% 
  mutate(date = paste(created_year, created_month)) %>% 
  select(date, n) -> additives
with(additives, plot(n, type='l'))
```

__Ćwiczenie__ Zawartość witamin w poszczególnych kategoriach produktów.





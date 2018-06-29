### WhyR? 2018 - RLadies Meetup in Wroclaw
### Marta Sommer (mmartasommer@gmail.com)
### 2 lipca 2018 r.

################################################################################
### PAKIETY:
################################################################################

library("dplyr")

################################################################################
### WCZYTYWANIE DANYCH:
################################################################################

dane <- read.csv("./data/titanic.csv")

head(dane)

# Dataset columns:
#     
# 1: Survived Indicator
# 2: Passenger Class
# 3: Name
# 4: Sex
# 5: Age
# 6: Siblings and spouses Aboard
# 7: Parents and children Aboard
# 8: Fare paid in £

################################################################################
### DPLYR: WPROWADZENIE
################################################################################

# Podstawowe funkcje:
#     
# select - wybierz kolumny
# arrange - posortuj
# filter - wybierz wiersze spelniajace okreslone warunki
# mutate - stworz nowa kolumne
# summarise - podsumuj (stworz nowa tabele)
# group_by - licz cos w grupach

# Podstawowy operator:
#     
# %>% (pipe) - Ctrl + Shift + M (skrot w RStudio)

################################################################################
### PIPE
################################################################################

# 1. zamiast zagniezdzac ...

hist(round(dane$Fare))

# ... mozna zrobic taki ciag polecen:

dane$Fare %>% 
    round() %>% 
    hist()

# 2. albo zamiast ...

exp(round(log(5.676)))

# ... mozna zrobic:

5.676 %>% 
    log() %>% 
    round() %>% 
    exp()

# mozna to tez przypisac do zmiennej:

wynik <- 5.676 %>% 
    log() %>% 
    round() %>% 
    exp()

wynik

################################################################################
### DPLYR: SELECT
################################################################################

# 1. wybieranie jednej kolumny:

dane %>% 
    select(Name) %>% 
    head()

dane %>% 
    select(Sex) %>% 
    head()

# 2. wybieranie wielu kolumn:
    
dane %>% 
    select(Name,
           Sex) %>% 
    head()

dane %>% 
    select(Name,
           Sex,
           Age) %>% 
    head()

################################################################################
### DPLYR: ARRANGE
################################################################################

# 1. wybierz trzy kolumny, a następnie posortuj po jednej z nich:
    
dane %>% 
    select(Name,
           Pclass,
           Fare) %>% 
    arrange(Fare) %>% 
    head(20)

# 2. posortuj malejąco:
    
dane %>% 
    select(Name,
           Pclass,
           Fare) %>% 
    arrange(desc(Fare)) %>% 
    head(20)

# 3. posortuj podwóch kolumnach:
    
tmp <- dane %>% 
    select(Name,
           Pclass,
           Fare) %>% 
    arrange(Pclass, desc(Fare)) 

################################################################################
### DPLYR: FILTER
################################################################################

# 1. wybierz tylko osoby z klasy 1
    
tmp <- dane %>% 
    filter(Pclass == 1)

# 2. wybierz tylko osoby, ktore zaplacily wiecej niz 200 funtow za bilet

tmp <- dane %>% 
    filter(Fare > 200)

# 3. wybierz tylko osoby, ktore przezyly katastrofe

tmp <- dane %>% 
    filter(Survived == 1)

# 4. wybierz osoby, ktore przezyly katastrofe i zaplacily wiecej 
#    niz 200 funtow za bilet

tmp <- dane %>% 
    filter(Survived == 1,
           Fare > 200)

# 5. wybierz osoby, ktore nie przezyly katastrofy i zaplacily wiecej 
#    niz 200 funtow za bilet

tmp <- dane %>% 
    filter(Survived != 1,
           Fare > 200)

# 6. wybierz kobiety (>= 18 lat) niezamezne (maja 'miss' przy nazwisku)

tmp <- dane %>% 
    filter(Sex == "female",
           grepl("Miss", Name),
           Age >= 18)

################################################################################
### DPLYR: MUTATE
################################################################################

# 1. stworz kolumne mowiaca o tym, ile kosztowal bilet w zlotowkach (przyjmijmy
#    przelicznik z 2018 roku: 1 GBP = 4.9 PLN) :D

tmp <- dane %>% 
    mutate(Fare_zl = Fare * 4.9)

# 2. stworz kolumne z kategoria wiekowa: 
#    - mlody:   wiek < 20
#    - sredni:  20 <= wiek < 40
#    - stary:   wiek >= 40

tmp <- dane %>% 
    mutate(Age_category = ifelse(Age < 20, "mlody",
                                 ifelse(Age >= 40, "stary",
                                        "sredni")))

# 3. stworz dwie kolumny: z kategoria wiekowa i z kategoria cenowa

tmp <- dane %>% 
    mutate(Age_category = ifelse(Age < 20, "mlody",
                                 ifelse(Age >= 40, "stary",
                                        "sredni")),
           Fare_category = ifelse(Fare < 10, "tanio",
                                  ifelse(Fare > 200, "drogo",
                                         "srednio")))

################################################################################
### DPLYR: SUMMARISE
################################################################################

# 1. policzmy sredni wiek:

dane %>% 
    summarise(sr_wiek = mean(Age))

# 2. policzmy sredni wiek i mediane wieku:

dane %>% 
    summarise(sr_wiek = mean(Age),
              med_wiek = median(Age))

# 3. policzmy maksymalna, minimalna i srednia cene za bilet oraz jej mediane:

dane %>% 
    summarise(min_fare = min(Fare),
              max_fare = max(Fare),
              mean_fare = mean(Fare),
              median_fare = median(Fare))

################################################################################
### DPLYR: GROUP_BY
################################################################################

# 1. policzmy sredni wiek w podziale na plec:

dane %>% 
    group_by(Sex) %>% 
    summarise(sr_wiek = mean(Age))

# 2. policzmy srednia cene za bilet w podziale na klase:

dane %>% 
    group_by(Pclass) %>% 
    summarise(mean_fare = mean(Fare))

# 3. policzmy srednia cene za bilet w podziale na klase i plec:

dane %>% 
    group_by(Pclass, Sex) %>% 
    summarise(mean_fare = mean(Fare))

# 4. znajdz osoby, ktore kupily najdrozszy bilet w kazdej klasie:

tmp <- dane %>% 
    group_by(Pclass) %>% 
    filter(Fare == max(Fare))

# 5. zlicz, ile bylo na statku kobiet a ilu mezczyzn:

dane %>% 
    group_by(Sex) %>% 
    summarise(ile = n())

# 6. zlicz, ile bylo na statku kobiet i powiedz, jaki to byl procent wszystkich
#    pasazerow:

dane %>% 
    group_by(Sex) %>% 
    summarise(ile = n()) %>% 
    ungroup() %>% 
    mutate(proc = 100 * ile / sum(ile))


library(dplyr)

load("data/dane_czyste_2017-08-25.Rdata")


sum(abs(unique(sample((-10:10), 15)))) # to samo co:
sample((-10:10), 15) %>% unique() %>% abs() %>% sum()


c(1,2,3) %>% sum() # CTRL + SHIFT + M : %>% 
sum(c(1,2,3))



#####################
# wybór kolumn

dane %>% 
    select(cena) %>% 
    head(10)

head(dane$cena, 10)

dane %>% 
    select(cena, cena_metr, rodzaj_zabudowy) %>% 
    head(10)

dane[1:10, c("cena", "cena_metr")]

dane %>% 
    select(cena_metr, cena) %>% 
    head(10)

dane %>% 
    select(contains("cena")) %>% 
    head(10)


# ZADANIE: wyciągnij wszystkie kolumny, które mają w nazwie "ele"
dane %>% 
    select(contains("ele"))

###############
# sortowanie wynikóW w kolumnie
dane %>% 
    arrange(cena) %>% 
    select(cena) %>% 
    head(10)

dane %>% 
    arrange(cena, powierzchnia) %>% 
    select(cena, powierzchnia) %>% 
    head(10)

dane %>% 
    arrange(desc(powierzchnia)) %>% 
    select(cena, powierzchnia) %>% 
    head(10)
# to samo co:
dane %>% 
    arrange(-powierzchnia) %>% 
    select(cena, powierzchnia) %>% 
    head(10)

# ZADANIE: wybrac 2 kolumny: cena_metr i rok_budowy 
#          i posortowac po cena_metr

dane %>% arrange(cena_metr) %>% select(cena_metr, rok_budowy)
dane  %>% select(cena_metr, rok_budowy) %>% arrange(cena_metr)

####################
# tworzenie nowych kolumn (zmiennych)

dane %>% 
    mutate(powyzej_5tego = (pietro > 5 )) %>% 
    select(powyzej_5tego, pietro) %>% 
    head(10)


dane %>% 
    mutate(cena_metr_spr = cena/powierzchnia, x = 7) %>% 
    select(cena_metr, cena_metr_spr, x) %>% 
    head(10)

dane %>% 
    mutate(czy_blok = ifelse(rodzaj_zabudowy == "blok", 1, 6)) %>% 
    select(czy_blok) %>% 
    head(10)

dane %>%
    mutate(cena = round(cena, 0)) %>% 
    select(cena)

# ZADANIE: Utworz nowa zmienna, ktora powie ile mamy pieter do samej
#          gory budynku (ostatniego pietra)

dane %>% 
    mutate(ile_do_max_ptr = max_pieter - pietro) %>% 
    select(ile_do_max_ptr, max_pieter, pietro) %>% 
    head(10)



#######################
# filtrowanie danych

dane %>% 
    filter(cena < 500000) %>% 
    arrange(desc(cena)) %>% 
    select(cena) %>% 
    head(10)

dane %>% 
    filter(cena == 500000) %>% # uwaga na dwa znaki rownosci!
    arrange(cena) %>% 
    select(cena) %>% 
    head(10)

dane %>% 
    filter(cena != 500000) %>% 
    arrange(cena) %>% 
    select(cena) %>% 
    head(10)

dane %>% 
    filter(cena < 500000, powierzchnia > 50) %>% 
    arrange(cena, desc(powierzchnia)) %>% 
    select(cena, powierzchnia) %>% 
    head(10)

dane %>% 
    filter(cena < 500000 | powierzchnia > 50) %>% # lub
    arrange(cena, desc(powierzchnia)) %>% 
    select(cena, powierzchnia) %>% 
    head(10)

dane %>% 
    filter(powierzchnia %in% c(50, 60, 70)) %>% 
    select(powierzchnia) %>% 
    head(10)

dane %>% 
    filter(cena < 500000, rodzaj_zabudowy == "blok") %>% 
    select(cena, rodzaj_zabudowy) %>% 
    head(10)

dane %>% 
    filter(cena < 500000, rodzaj_zabudowy %in% c("blok", "apartamentowiec")) %>% 
    select(cena, rodzaj_zabudowy) %>% 
    head(10)

# ZADANIE: wybierz te wiersze, ktore maja cene_metr 
# mniejsza niz 8500 i material_budynku to cegła

dane %>% 
    filter(cena_metr < 8500, material_budynku == "cegła") %>% 
    select(cena_metr, material_budynku) %>% 
    head(10)



######################
# podsumowowywanie danych

dane %>% 
    summarise(cena = mean(cena))

dane %>%
    summarise(moja_super_zmienna = mean(cena))


dane %>% 
    summarise(cena_srednia = mean(cena),
              cena_mediana = median(cena),
              cena_min = min(cena),
              liczba_wierwszy = n()) 


###############################
# podsumowywanie w grupach, wybieranie w grupach

dane %>% 
    group_by(rok_budowy) %>% 
    summarise(cena_srednia = mean(cena))

dane %>% 
    group_by(rok_budowy, rodzaj_zabudowy) %>% 
    summarise(cena_max = max(cena)) %>% 
    arrange(desc(rok_budowy))

dane %>% 
    group_by(rok_budowy) %>% 
    filter(cena == max(cena)) %>% 
    select(rok_budowy, cena, rodzaj_zabudowy)

# ZADANIE: Policz jaka była maksymalna cena za metr per materiał budynku
dane %>% 
    group_by(material_budynku) %>% 
    summarise(cena_metr = max(cena_metr))

# ZADANIE: Policz średnie maksymalna liczbe pieter per rodzaj_zabudowy

dane %>% 
    group_by(rodzaj_zabudowy) %>% 
    summarise(max_pieter = mean(max_pieter))




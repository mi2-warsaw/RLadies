################################################################################
### ZADANIA
################################################################################

# 1. Wybierz kolumny: 'Name' oraz 'Fare'. Posortuj tabele malejaco po kolumnie
#    'Fare'.

dane %>% 
    select(Name, Fare) %>% 
    arrange(desc(Fare))

# 2. Znajdz osoby, ktore za bilet zaplacily co miedzy 100 a 150 funtow.

dane %>% 
    filter(Fare > 100,
           Fare < 150) %>% 
    select(Name, Fare)

# 3. Ile bylo na statku kobiet o imieniu 'Helen'?

dane %>% 
    filter(Sex == "female",
           grepl("Helen", Name)) %>% 
    summarise(ile = n())

# 4. Policz, ile osob bylo w kazdej z klas.

dane %>% 
    group_by(Pclass) %>% 
    summarise(ile_bylo_osob = n())

# 5. Policz sredni wiek osob, ktore przezyly katastrofe.

dane %>% 
    filter(Survived == 1) %>% 
    summarise(sr_wiek = mean(Age))

# 6. Znajdz najmlodszego i najstarszego pasazera.

dane %>% 
    filter(Age == min(Age) | Age == max(Age)) %>% 
    select(Name, Age)

# 7. Policz sredni wiek osob, ktore nie przezyly katastrofy i plynely statkiem 
#    za darmo.

dane %>% 
    filter(Survived == 0,
           Fare == 0) %>% 
    summarise(sr_wiek = mean(Age))

# 8. Jaka byla srednia wieku niezameznych kobiet na statku?

dane %>% 
    filter(Sex == "female",
           grepl("Miss", Name)) %>% 
    summarise(sr_wiek = mean(Age))

# 9. Policz, ile osob (w podziale na plec) bylo w kazdej z klas.

dane %>% 
    group_by(Sex) %>% 
    summarise(ile_bylo_osob = n())

# 10. Ile bylo osob, ktore mialy 18 lat i przezyly. Jaki to byl procent 
#    wszystkich osiemnastolatkow? 

dane %>% 
    filter(Age == 18) %>% 
    group_by(Survived) %>% 
    summarise(ile = n()) %>% 
    ungroup() %>% 
    mutate(proc = 100 * ile / sum(ile))

# 11. Ilu zginelo mezczyzn a ile kobiet? Jaki to byl procent mezczyzn, a jaki 
#     kobiet?

dane %>% 
    group_by(Survived, Sex) %>% 
    summarise(ile = n()) %>% 
    ungroup() %>% 
    group_by(Sex) %>% 
    mutate(proc = 100 * ile / sum(ile))


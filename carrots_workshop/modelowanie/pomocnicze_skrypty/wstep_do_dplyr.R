library(dplyr)
data("starwars")

# PIPE - proste przykłady
head(starwars)
starwars %>% 
    head()

apply(starwars, 2, class)
starwars %>% 
    apply(2, class)

# Policzmy średni wzrost brązowookich ludzi
mean(starwars[starwars$eye_color == "brown" & 
                  starwars$species == "Human", ]$height, na.rm = TRUE)
starwars %>% 
    filter(eye_color == "brown" & species == "Human") %>% 
    pull(height) %>% 
    mean(na.rm = TRUE)

# Policzmy średnią wagę po miejscu zamieszkania i płci
aggregate(mass ~ homeworld + gender, data = starwars, FUN = mean, na.rm = TRUE)

starwars %>% 
    group_by(homeworld, gender) %>% 
    summarise(mean_weight = mean(mass, na.rm = TRUE))

# Narysujmy jakiś wykres
library(ggplot2)

ggplot(starwars, aes(mass, height, colour = species)) + geom_point()

starwars %>% 
    ggplot(aes(mass, height, colour = species)) + geom_point()

# Stwórzmy nowe zmienne
starwars %>% 
    mutate(dlugosc_imienia = nchar(name)) %>% 
    select(name, dlugosc_imienia) %>% 
    arrange(-dlugosc_imienia) %>% 
    rename(name_length = dlugosc_imienia)





# punktowy

ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point()

ggplot(dane, aes(x = powierzchnia, y = cena,
                 color = rodzaj_zabudowy)) +
    geom_point()

ggplot(dane, aes(x = powierzchnia, y = cena,
                 color = rodzaj_zabudowy,
                 shape = rynek)) +
    geom_point()

ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point() +
    geom_smooth()

# liniowy:

ggplot(dane, aes(x = rok_budowy, y = cena_metr)) +
    geom_point()

ggplot(dane, aes(x = rok_budowy, y = cena_metr)) +
    geom_point() +
    geom_line()

dane %>% 
    group_by(rok_budowy) %>% 
    summarise(sr_cena_metr = mean(cena_metr)) -> dane_sr_cena

ggplot(dane_sr_cena, aes(x = rok_budowy, y = sr_cena_metr)) +
    geom_point() +
    geom_line()

dane %>% 
    filter(rodzaj_zabudowy == "blok",
           rok_budowy >= 1950) %>% 
    group_by(rok_budowy) %>% 
    summarise(sr_cena_metr = mean(cena_metr)) -> dane_sr_cena_blok

ggplot(dane_sr_cena_blok, aes(x = rok_budowy, y = sr_cena_metr)) +
    geom_point() +
    geom_line()

dane %>% 
    filter(rodzaj_zabudowy == "apartamentowiec",
           rok_budowy >= 1950) %>% 
    group_by(rok_budowy) %>% 
    summarise(sr_cena_metr = mean(cena_metr)) -> dane_sr_cena_apartament

ggplot(dane_sr_cena_apartament, aes(x = rok_budowy, y = sr_cena_metr)) +
    geom_point() +
    geom_line()

dane %>% 
    filter(rok_budowy >= 1950,
           rodzaj_zabudowy %in% c("apartamentowiec", "blok")) %>% 
    group_by(rodzaj_zabudowy, rok_budowy) %>% 
    summarise(sr_cena_metr = mean(cena_metr)) -> dane_sr_cena

ggplot(dane_sr_cena, aes(x = rok_budowy, y = sr_cena_metr,
                         color = rodzaj_zabudowy,
                         linetype = rodzaj_zabudowy)) +
    geom_point() +
    geom_line()

# barplot

ggplot(dane, aes(x = rodzaj_zabudowy)) +
    geom_bar()

dane %>% 
    group_by(rodzaj_zabudowy) %>% 
    summarise(ile = n()) -> tab_ile

ggplot(tab_ile, aes(x = rodzaj_zabudowy, y = ile, label = ile,
                    fill = rodzaj_zabudowy)) +
    geom_bar(stat = "identity") +
    geom_text()

tab_ile

ggplot(tab_ile, aes(x = rodzaj_zabudowy)) +
    geom_bar()

ggplot(tab_ile, aes(x = rodzaj_zabudowy)) +
    geom_bar(stat = "count")

ggplot(tab_ile, aes(x = rodzaj_zabudowy, y = ile)) +
    geom_bar(stat = "identity")

# geom_text w geom_point():

dane2 <- head(dane, 100)

ggplot(dane2, aes(x = powierzchnia, y = cena, 
                  label = material_budynku)) +
    geom_point() +
    geom_text()

library("ggrepel")

ggplot(dane2 %>% head(10), aes(x = powierzchnia, y = cena, 
                  label = material_budynku)) +
    geom_point() +
    geom_text_repel()

ggplot(dane2 %>% head(10), aes(x = powierzchnia, y = cena, 
                               label = material_budynku)) +
    geom_point() +
    geom_label_repel()

# boxplot:

ggplot(dane, aes(x = rodzaj_zabudowy, y = cena_metr)) +
    geom_point()

ggplot(dane, aes(x = rodzaj_zabudowy, y = cena_metr)) +
    geom_boxplot() +
    coord_flip()

#

ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point()


ggplot(dane, aes(x = powierzchnia, y = cena, color = rynek)) +
    geom_point()



ggplot(dane %>% filter(rynek == "wtórny"), 
       aes(x = powierzchnia, y = cena)) +
    geom_point()

ggplot(dane %>% filter(rynek == "pierwotny"), 
       aes(x = powierzchnia, y = cena)) +
    geom_point()


ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point() +
    facet_grid(rynek ~ .)


ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point() +
    facet_grid(rynek ~ rodzaj_zabudowy)

ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point() +
    facet_grid(rodzaj_zabudowy ~ rynek)

# styl:

ggplot(dane, aes(x = powierzchnia, y = cena,
                 color = rodzaj_zabudowy,
                 shape = rynek)) +
    geom_point() +
    theme_bw()

ggplot(dane, aes(x = powierzchnia, y = cena,
                 color = rodzaj_zabudowy,
                 shape = rynek)) +
    geom_point() +
    theme_minimal() +
    labs(x = paste("Powierzchnia"),
         y = "Cena [zł]",
         title = "Zależność ceny od powierzchni mieszkania") +
    theme(legend.position = "left",
          axis.title = element_text(size = 13, family = "serif"),
          axis.text = element_text(size = 20)) +
    scale_color_manual(name = "Rodzaj zabudowy:",
                       values = c("#000000", "blue", "green", "yellow", "black", "pink", "orange")) +
    scale_shape_manual(name = "Rynek:", 
                       values = c(4, 5),
                       labels = c("P", "W")) +
    scale_y_continuous(labels = function(lab){ format(lab, scientific = FALSE, small.mark = " ", big.mark = " ") },
                       limits = c(NA, 15e6)) +
    scale_x_continuous(labels = function(lab){ paste(lab, "m2") }) -> plot_marta

library(plotly)

ggplotly(plot_marta)





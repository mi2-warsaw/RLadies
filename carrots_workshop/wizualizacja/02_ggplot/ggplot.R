library("dplyr")
library("ggplot2")

################################################################################
### MATERIALY:
################################################################################

# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

################################################################################
### WCZYTAJ DANE:
################################################################################

load("./data/dane_czyste_2017-08-25.Rdata")

head(dane)

################################################################################
### STRUKTURA WYKRESU:
################################################################################

# ggplot(ramka_z_danymi, aes(x = ?, y = ?, color = ?, fill = ?, label = ?, 
#                            shape = ?, size = ?)) +
#     geom_point(...) +
#     geom_bar(...) +
#     geom_line(...) +
#     geom_text(...) +
#     ...
#     coord_flip(...) +
#     ...
#     facet_grid(...) +
#     ...     
#     theme_(bw/minimal/gray/...) +
#         theme(axis.title = element_text(...),
#               axis.text = element_text(...),
#               legend.position = "top/bottom/...") +
#         labs(title = "...", x = "...", y = "...") +
#     ...
#     scale_y_manual(values = ..., name = "...", label = ...) +
#         scale_y_discrete() +
#         scale_color_manual() +
#     ...

################################################################################
### GEOMETRIE:
################################################################################

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

################################################################################
### COORD_FLIP + FACET_GRID:
################################################################################

# coord_flip:

ggplot(dane, aes(x = rodzaj_zabudowy, y = cena_metr)) +
    geom_boxplot() +
    coord_flip()

# facet_grid:

ggplot(dane, aes(x = powierzchnia, y = cena, shape = rynek)) +
    geom_point() +
    facet_grid(rodzaj_zabudowy ~ .)

ggplot(dane, aes(x = powierzchnia, y = cena)) +
    geom_point() +
    facet_grid(rodzaj_zabudowy ~ rynek)

################################################################################
### THEME:
################################################################################

ggplot(dane %>% head(1000), 
       aes(x = powierzchnia, y = cena, color = rodzaj_zabudowy, shape = rynek)) +
    geom_point() -> wyk

wyk + 
    theme_bw()

wyk + 
    theme_minimal()

wyk + 
    theme_linedraw()

wyk + 
    theme_bw() +
    ggtitle("Zaleznosc ceny od powierzchni") +
    ylab("Cena") +
    xlab("Powierzchnia [m2]")  # xlab(expression(paste("Powierzchnia [", m^{2}, "]")))

wyk + 
    theme_bw() +
    ggtitle("Zaleznosc ceny od powierzchni") +
    ylab("Cena") +
    xlab(expression(paste("Powierzchnia [", m^{2}, "]"))) +
    theme(axis.title.x = element_text(size = 20, family = "serif"),
          axis.text.y = element_blank(),
          legend.position = "left")

################################################################################
### SCALE:
################################################################################

ggplot(dane %>% head(1000), 
       aes(x = powierzchnia, y = cena, color = rodzaj_zabudowy, shape = rynek)) +
    geom_point() +
    theme_minimal() +
    ggtitle("Zaleznosc ceny od powierzchni") +
    ylab("Cena") +
    xlab(expression(paste("Powierzchnia [", m^{2}, "]"))) +
    scale_y_continuous(limits = c(0, 4e6),
                       labels = function(x){format(x, scientific = FALSE, big.mark = " ", small.mark = " ")}) +
    scale_color_discrete(name = "Rodzaj zabudowy:") +
    scale_shape_manual(values = 4:5, name = "Rynek:")




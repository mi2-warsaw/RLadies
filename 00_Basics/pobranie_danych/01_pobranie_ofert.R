# znajdz linki ofert z pierwszych 30 stron
library(rvest)
obuwie_strona1 <- 
  read_html('http://allegro.pl/obuwie-1469') %>%
  html_nodes('.offer-title') %>%
  html_attr('href')

library(pbapply)
pbsapply(2:30, function(strona){
  read_html(paste0('http://allegro.pl/obuwie-1469?p=', strona)) %>%
  html_nodes('.offer-title') %>%
  html_attr('href') %>%
  assign(x=paste0('obuwie_strona', strona), envir = .GlobalEnv)
  invisible(NULL)
})

ls(pattern = 'obuwie') %>%
  sapply(get) %>% c() -> oferty

# dla linkow z 30 pierwszych stron z kategorii obuwie, wyciagnij o nich informacje
library(stringi)
pbsapply(oferty, function(url){
  oferta <- read_html(url) 
  cena <- 
    html_nodes(oferta, '#purchase-form .price') %>% 
    html_text() %>%
    stri_extract(regex = '[0-9,]+') %>%
    gsub(replacement = ".", pattern = ",", fixed = TRUE)
  
  cena_przesylek <- 
    html_nodes(oferta, '.clear') %>% 
    html_text() %>%
    stri_extract(regex = '[0-9,]+') %>%
    gsub(replacement = ".", pattern = ",", fixed = TRUE) %>%
    as.numeric()
  if(!(length(cena_przesylek) ==0)) {
    minimalna_cena_dostawy <- min(cena_przesylek)
    maksymalna_cena_dostawy <- max(cena_przesylek)
  } else {
    minimalna_cena_dostawy <- NA
    maksymalna_cena_dostawy <- NA
  }
  lokalizacja <- 
    html_nodes(oferta, '.freeShippingThreshold+ .list-unstyled li:nth-child(1) strong') %>%
    html_text()
  pozostala_liczba_par <- 
    html_nodes(oferta, '.no-wrap') %>%
    html_text() %>%
    stri_extract(regex = '[0-9]+')
    
  zdjecie <- 
    html_nodes(oferta, '.img-responsive') %>% 
    html_attr('src') %>%
    unique %>% .[1]
  atrybuty <- 
    capture.output(
      html_nodes(oferta, '.attributes-container') %>%
      html_text() %>% cat ) %>% gsub("  ", "", ., fixed=TRUE) 
  if(length(atrybuty)!=0) {
    atrybuty <- atrybuty[nchar(atrybuty)>0]
    atry_out <- atrybuty[2*(1:(length(atrybuty)/2))]
    names(atry_out) <- gsub(":", "",atrybuty[2*(1:(length(atrybuty)/2))-1])
  } else {
    atry_out <- "brak_atrybutow"
  }
  sprzedajacy <- 
    html_nodes(oferta, '#seller-rating span') %>%
    html_text()
  tytul <- 
    html_nodes(oferta, '.title') %>%
    html_text()  %>%
    gsub("Twoje powiadomieniaUstawienia", "", . , fixed=TRUE) %>%
    gsub("\n", "", ., fixed = TRUE) %>%
    paste(collapse="") %>%
    gsub("  ", "", ., fixed = TRUE)
  licznik_sprzedazy <-
    html_nodes(oferta, '.buyers-count') %>%
    html_text() %>%
    gsub("  ", "", ., fixed = TRUE) %>%
    gsub("\n", "", ., fixed = TRUE)
  if(atry_out[1] != "brak_atrybutow"){
    informacje <- list(url = url,
                       tytul = tytul,
                       cena = cena,
                       zdjecie = zdjecie,
                       sprzedajacy = sprzedajacy,
                       lokalizacja = lokalizacja,
                       pozostala_liczba_par = pozostala_liczba_par,
                       minimalna_cena_dostawy = minimalna_cena_dostawy,
                       maksymalna_cena_dostawy = maksymalna_cena_dostawy,
                       licznik_sprzedazy = licznik_sprzedazy,
                       atry_out)
  } else {
    informacje <- list(url = url,
                       tytul = tytul,
                       cena = cena,
                       zdjecie = zdjecie,
                       sprzedajacy = sprzedajacy,
                       lokalizacja = lokalizacja,
                       pozostala_liczba_par = pozostala_liczba_par,
                       minimalna_cena_dostawy = minimalna_cena_dostawy,
                       maksymalna_cena_dostawy = maksymalna_cena_dostawy,
                       licznik_sprzedazy = licznik_sprzedazy)
  }
  t(as.data.frame(unlist(informacje)))
}) -> info_oferty

library(dplyr)
pblapply(info_oferty, function(element){
  element <- as.data.frame(element)
}) -> info_oferty_2

do.call(bind_rows, info_oferty_2) ->info_oferty_binded

write.csv(info_oferty_binded, row.names = FALSE, quote = TRUE,
          file = "pobranie_danych/oferty_informacje.csv")

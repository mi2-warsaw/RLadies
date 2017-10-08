shinyUI(fluidPage(
  #Tytuł aplikacji
  titlePanel("Moja pierwsza aplikacja"),
  
  #Ułożenie aplikacji
  sidebarLayout(
    #Panel boczny na kontrolki
    sidebarPanel("Tutaj umieszczam wszystko co ma się wyświetlić w panelu bocznym."
#                  ,"Jeśli odkomentujesz tą część i ponownie uruchomisz aplikację
#                   zobaczysz, że panel powiększa się wraz ze wzostem zawartości"
                 ),
    
    #Ekran wynikowy
    mainPanel("Tutaj umieszczam wszystko co ma się wyświetlić na ekranie wynikowym")
  )
))

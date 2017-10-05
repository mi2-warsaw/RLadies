# By nasza aplikacja mogła być interaktywna użytkownik musi mieć w co 'kliknąć',
#dlatego teraz zajmiemy się różnego rodzajmu kontrolkami. Przedstawię tutaj te 
#najbardziej podstawowe:


shinyUI(
  fluidPage(
    sidebarLayout( # definiuje wygląd wejściowych i wyjściowych definicji
      sidebarPanel(
        
        ##WSZYSTKIE KONTROLKI
        #Większość kontrolek ma podobną strukturę:
        # nazwaFunkcji(
        #              "nazwaKontrolkiJakoObiektuRoewgo", 
        #              label="EtykietaWidocznaDlaUżytkownika", 
        #              list=listaMozliwychDoPrzyjęciaWartości, 
        #              selected/value=WartośćPoczątkowa)
        # "nazwaKontrolkiJakoObiektuRoewgo" - nazwa obiektu, do ktorego będziemy
        # się odwoływać pisząc kod Rowy(użytkownik tego nie widzi)
        #
        # "EtykietaWidocznaDlaUżytkownika" - tekst informacyjny widoczny dla użytkownika
        #
        # listaMozliwychDoPrzyjęciaWartości - lista nazwana. Nazwy poszczególnych pól
        # listy są widoczne jako opcje wyboru dla użytkownika, zadane wartości natomiast
        # będą przekazywane do pliku server.R z kodem Rowym
        
        
        #Zwykły przycisk - widzimy, że etykiety możemy normalnie formatować
        
        actionButton("przycisk", label = h3("Wciśnij mnie")),
        
        #Pojedynczy checkbox - odznaczamy lub zaznaczymy jakąś opcję
        checkboxInput("checkbox", label = "Pokaż wykres", value = TRUE ),
        
        #Grupa checkboxów - możliwy wybór wieloktorny
        checkboxGroupInput("checkGroup", label="Rodzaj zabudowy:", 
                           choices = list("Apartamentowiec" = 1, 
                                          "Blok" = 2, 
                                          "Kamienica" = 3,
                                          "Szeregowiec" = 4,
                                          "Dom wolnostojący" = 5,
                                          "Plomba" = 6, 
                                          "Loft" = 7),
                           selected = 1),
        # I tutaj przykład - jezli użytkownik zaznaczy Apartamentowiec, my do R
        #dostaniemy wartość 1, jeśli zaznaczy Blok i Kamienicę to dostaniemy wartość
        #c(2, 3)
        
        #Wybór jeden z wielu w postaci pól do zaznaczenia
        radioButtons("radio", label = "Ogrzewanie",
                     choices=list("Miejskie" = 1,
                                  "Kotłownia" = 2,
                                  "Gazowe" = 3,
                                  "Elektryczne" = 4,
                                  "Piece kaflowe" = 5,
                                  "Inne" = 6),
                     selected = 1),
        
        #Wybór jeden z wielu w postaci rozwijanej listy
        selectInput("select",
                    label = "Stan wykończenia", 
                    choices = list("Do wykończenia" = 1,
                                   "Do zamieszkania" = 2, 
                                   "Do remontu" = 3),
                    selected = 1),
        
        #W rozwijanej liście możemy też umożliwić wybór wielokrotny
        selectInput("select",label = "Stan wykończenia", 
                    choices = list("Do wykończenia" = 1,
                                   "Do zamieszkania" = 2, 
                                   "Do remontu" = 3),
                    selected = 1,
                    multiple = TRUE),
        
        #Możliwości podania daty lub jej zakresu
        dateInput("data", label = "Data", value = "2017-10-08"),
        dateRangeInput("dates", label = "Zakres dat", start = "2017-01-01", end = Sys.Date()),
        
        #Załadowanie pliku
        fileInput("file", label = "Wybierz plik"),
        
        #Wpisywanie liczby lub tekstu
        numericInput("l_pokoi", label = "Liczba pokoi", value = 3),
        textInput("opis", label = "Znajdź słowo w opisie", value = "Powiśle"),
        
        #Suwaki z zakresem wartości - przydatne np. do dziedziny funkcji
        sliderInput("sliderJednostronny", 
                    label = "Czynsz",
                    min = 150, 
                    max = 3900, 
                    value = 500),
        
        sliderInput("sliderDwustronny", 
                    label = "Czynsz widełki", 
                    min = 150,
                    max = 3900, 
                    value = c(400, 600)),
        
        #Test pomocniczy. Jedyna nieinteraktywna kontrolka, która nie będzie nawet
        #potrzebować nazwy obiektu Rowego, gdyż nic nie zwraca
        helpText("Krótki tekst pomocniczy")
        
        #Kontrolki wstawiałam bez Layoutu, by nie zakłócać odbioru. Można je wstawić
        #i do panelu bocznego i na ekran wynikowy
      ),
      mainPanel()
    )
  )
)

#Zauważmy, że wszytsko co teraz podajemy jest argumentami funkcji fluidPage(),
#bądź funkcji bardziej wewnętrznych jak mainPanel() stąd po każdym poleceniu 
#pamiętajmy postawić przecinek.

shinyUI(fluidPage(
  titlePanel("Jak zapanować nad tekstem?"),
  
  sidebarLayout( # definiuje wygląd wejściowych i wyjściowych definicji
    sidebarPanel(), # definiuje wygląd definicji wejściowych
    mainPanel( # definiuje wygląd wyjściowych danych
      
      #Cały pliku ui jest odpowiednio konwertowany na język HTML, więc jesli ktoś
      #już ten język zna to można podawać tekst do funkcji HTML(), np.
      #HTML("<h1> Największy tytuł </h1>") . Wszystkie funkcje poniżej są po prostu 
      #ładnym opakowaniem dla Rowców ;)
      #Jakie mamy możliwości?
      
      #Tytuły - różne rozmiary
      h1("TYTUŁY"),
      h1("h1() Pierwszy poziom tytułu"),
      h2("h2() Drugi poziom tytułu"),
      h3("h3() Trzeci poziom tytułu"),
      h4("h4() Czwarty poziom tytułu"),
      h5("h5() Piąty poziom tytułu"),
      h6("h6() Szósty poziom tytułu"),
      
      #Wyśrodkowanie tekstu
      h6("Tytuł na środku", align="center"),
      h6("Tytuł po prawej", align="right"),
      
      #Paragraf tekstu
      p("p() To będzie bardzo imponujaco długi paragraf tekstu, który ma
         pokazać jak długa może być pojedyncza linijka tekstu. Zauważcie,
         że poprzednie funkcje same zapewniały nam znaki nowej linii..."),
      
      #Nowe, puste linijki - zwykłe dodanie "\n" w tekście nie zadziała
      br(),
      br(),
      
      #Inne funkcje (bez automatycznej nowej linii)
      p("Są jeszcze inne funkcje, które nie stosują nowej linii:"),
      strong("strong() daje pogrubienie tekstu"),
       br(),
      em("em() zwraca pochyły tekst"),
       br(),
      a("a(\" \",href=\"link\") podczepia link pod dany tekst np. http://www.google.pl",
        href="http://www.google.pl"),
       br(),
      code("code() formatuje kod z R:
         x<-1:10;
         mean(x)"),
      
      p("Tekst możemy także kolorować argumentem style='color:green'", 
        style="color:green"),
      
      #Łączenie możliwości w jednym tekście
      p("Zagnieżdżając funkcję możemy", strong(" pogrubić tekst, "), 
        em("pochylić go,"), strong("czy pokolorować tylko jego część", 
                              style="color:purple")),
      #Możemy też dodać zwykły tekst
      "Fragment standardowego tekstu",
      br(),
      
      #Do tej pory dodawaliśmy tekst tylko na ekranie wynikowym. Nic nie stoi na
      #przeszkodzie, by tych funkcji użyć w panelu kontrolnym (w środku sidebarPanel())
      
      #Do naszej aplikacji możemy dodawać także zdjęcia za pomocą funkcji img()
      #Zdjęcia te umieszczamy w specjalnym folderze o nazwie "www"
      img(src="k.jpg", width=250, height=200)
    )
  )
))

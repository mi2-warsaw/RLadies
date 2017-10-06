library("ggplot2")
library("dplyr")
library("DT")

load("../../../data/dane_czyste_2017-08-25.Rdata")

shinyServer(function(input,output){
  
    output$tab1 <- renderDataTable({
      
        dane %>% 
            filter(rynek %in% input$rynek,
                   rodzaj_zabudowy %in% input$rodzaj_zabudowy,
                   rok_budowy >= input$rok_budowy[1],
                   rok_budowy <= input$rok_budowy[2]) %>% 
            select(1:13) -> d
        
        d
      
    })
    
    output$wyk1 <- renderPlot({
        
        dane %>% 
            filter(rynek %in% input$rynek,
                   rodzaj_zabudowy %in% input$rodzaj_zabudowy,
                   rok_budowy >= input$rok_budowy[1],
                   rok_budowy <= input$rok_budowy[2]) %>% 
            select(1:13) -> d
        
        ggplot(d, aes(x = powierzchnia, y = cena, color = rodzaj_zabudowy, 
                      shape = rynek)) +
            geom_point(size = 3) + 
            scale_shape_discrete(solid = FALSE)
        
    })
  
})

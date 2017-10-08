library(ggplot2)
library(dplyr)

# wczytujemy dane przed funkcja shinyServer
load("../../../data/dane_czyste_2017-08-25.Rdata")
# read.csv(...)
# fread(...)

shinyServer(function(input,output){
    
  output$wykres1 <- renderPlot({
     # dane %>% ...
    ggplot(dane, aes(x = czynsz, y = powierzchnia)) +
      geom_point()
  })
  
  output$wykres2 <- renderPlot({
      print(input$sliderDwustronny)
    dane %>% 
      filter(czynsz >= input$sliderDwustronny[1],
             czynsz <= input$sliderDwustronny[2]) %>% 
    ggplot(aes(x = czynsz, y = powierzchnia)) +
      geom_point()
      
    
  })
})



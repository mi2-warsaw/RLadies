library(ggplot2)
library(dplyr)

load("../../dane_czyste_2017-08-25.Rdata")


shinyServer(function(input,output){
  
  output$wykres1 <- renderPlot({
    ggplot(dane, aes(x = czynsz, y = powierzchnia)) +
      geom_point()
  })
  
  output$wykres2 <- renderPlot({
    dane %>% 
      filter(czynsz >= input$sliderDwustronny[1],
             czynsz <= input$sliderDwustronny[2]) %>% 
    ggplot(aes(x = czynsz, y = powierzchnia)) +
      geom_point()
  })
})

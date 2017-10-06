
shinyUI(
    
    fluidPage(
        
        titlePanel("Jak zapanować nad tekstem?"),
        
        sidebarLayout( 
            
            sidebarPanel(
                
                checkboxGroupInput("rynek", 
                                   label = "Rynek:", 
                                   choices = dane$rynek %>% unique(),
                                   selected = "pierwotny"),
                
                selectInput("rodzaj_zabudowy",
                            label = "Rodzaj zabudowy:", 
                            choices = dane$rodzaj_zabudowy %>% unique(),
                            selected = "blok",
                            multiple = TRUE),
                
                sliderInput("rok_budowy", 
                            label = "Rok budowy:", 
                            min = dane$rok_budowy %>% min(),
                            max = dane$rok_budowy %>% max(), 
                            value = c(2000, 2010),
                            step = 10,
                            sep = "")
                
            ),
            
            mainPanel(
                
                dataTableOutput("tab1"),
                
                plotOutput("wyk1")
                
            )
            
        )
        
    )
    
)

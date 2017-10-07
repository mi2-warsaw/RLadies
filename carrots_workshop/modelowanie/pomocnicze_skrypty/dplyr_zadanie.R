library(dplyr)
starwars %>% 
    filter(height == min(height, na.rm = TRUE)) %>% 
    select(name, height)

starwars %>% 
    mutate(BMI = mass / height^2) %>% 
    filter(BMI == max(BMI, na.rm = TRUE))
    
starwars %>% 
    select_("name")

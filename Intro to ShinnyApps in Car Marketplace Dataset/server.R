function(input, output){
    
    output$gear <- renderPlotly({
        VT <- cars %>% 
            filter(vehicleType != "andere") %>% 
            filter(gearbox == input$gearbox) %>% 
            dplyr::select(vehicleType, price) %>% 
            group_by(vehicleType) %>% 
            summarise(price = round(mean(price),2)) %>% 
            ungroup() %>% 
            mutate(text = paste(vehicleType, ":", price, "$"))
        
        options(scipen = 999)
        T_P <- ggplot(VT, aes(x = vehicleType, y = price, text = text))+
            geom_col(aes(fill = vehicleType))+
            theme(legend.position = "none")+
            coord_flip()
        
        ggplotly(T_P, tooltip = "text")
    })
    
    output$fuel <- renderPlotly({
        B_K_P_C <- cars %>% 
            filter(brand != "sonstige_autos") %>% 
            filter(fuelType == input$fuelType) %>% 
            dplyr::select(brand, kilometer, price) %>% 
            group_by(brand) %>% 
            summarise(kilometer = mean(kilometer),
                      price = round(mean(price),2)) %>% 
            ungroup() %>%
            filter(price > 5000) %>% 
            gather(key, value, -brand)%>% 
            mutate(text = paste(key, ":", value))
        
        K_P_C <- ggplot(B_K_P_C, aes(x = brand, y = value, text = text))+
            geom_col(aes(fill = key), position = "stack")+
            theme(axis.text.y = element_text(size = 8))+
            coord_flip()
        
        ggplotly(K_P_C, tooltip = "text")
    })
}
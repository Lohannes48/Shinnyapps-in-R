function(input, output){
    
    output$gear <- renderPlotly({
        VT <- cars %>% 
            filter(vehicleType != "andere") %>% 
            filter(gearbox == input$gearbox) %>% 
            dplyr::select(vehicleType, price) %>% 
            mutate(vehicleType = reorder(vehicleType, price)) %>% 
            group_by(vehicleType) %>% 
            summarise(price = round(mean(price),2)) %>% 
            ungroup() %>% 
            mutate(text = paste(vehicleType, ":", price, "$"))
        
        options(scipen = 999)
        T_P <- ggplot(VT, aes(x = vehicleType, y = price, text = text))+
            geom_col(aes(fill = vehicleType))+
            theme(legend.position = "bottom")+
            labs(x = NULL, y = NULL, title = "Price in Different Type Vehicle")+
            coord_flip()+
            theme_minimal()
            
        
        ggplotly(T_P, tooltip = "text")
    })
    
    output$fuel <- renderPlotly({
        B_K_P_C <- cars %>% 
            filter(brand != "sonstige_autos") %>% 
            filter(fuelType == input$fuelType) %>% 
            dplyr::select(brand, kilometer, price) %>% 
            mutate(brand = reorder(brand, price)) %>% 
            group_by(brand) %>% 
            summarise(kilometer = mean(kilometer),
                      price = round(mean(price),2)) %>% 
            ungroup() %>%
            filter(price > 5000) %>% 
            gather(key, value, -brand)%>% 
            mutate(text = paste(key, ":", value))
        
        K_P_C <- ggplot(B_K_P_C, aes(x = brand, y = value, text = text))+
            geom_col(aes(fill = key), position = "stack")+
            theme(legend.position = "bottom", axis.text.y = element_text(size = 8))+
            labs(x = NULL, y = NULL, 
                 title = "Price Correlation for KM and Fuel Type")+
            coord_flip()+
            theme_minimal()
        
        ggplotly(K_P_C, tooltip = "text")
    })
    
    output$brand1 <- renderPlotly({
        growth <- cars %>% 
            dplyr::select(yearOfRegistration, price, brand) %>% 
            filter(brand == input$brand) %>% 
            filter(between(yearOfRegistration, 2010,2018)) %>% 
            group_by(yearOfRegistration) %>% 
            summarise(mean_price = round(mean(price),2)) %>% 
            ungroup() %>% 
            mutate(text = paste(yearOfRegistration, ";", mean_price))
        
        growth_p <- ggplot(growth, aes(x = yearOfRegistration, 
                                       y = mean_price, group=1,
                                       text = text))+
            geom_point(color = "indianred")+geom_line()+
            labs(x = NULL, y = NULL,
                 title = "Cars Price Growth by Registration Year")+
            theme_minimal()
        
        ggplotly(growth_p, tooltip = "text")
    })
    
    output$valuebox1 <- renderValueBox({
        VT <- cars %>% 
            filter(vehicleType != "andere") %>% 
            filter(gearbox == input$gearbox) %>% 
            dplyr::select(vehicleType, price) %>% 
            mutate(vehicleType = reorder(vehicleType, price)) %>% 
            group_by(vehicleType) %>% 
            summarise(price = round(mean(price),2)) %>% 
            ungroup() %>% 
            arrange(desc(price)) 
        
        valueBox(value = VT$vehicleType[1],subtitle = 'Best Type', 
                 icon = icon("car"))
    })
    
    output$valuebox2 <- renderValueBox({
        valueBox(value = input$gearbox,subtitle = 'Using Gearbox', 
                 icon = icon("cogs"))
    })
    
    output$valuebox3 <- renderValueBox({
        VT <- cars %>% 
            filter(vehicleType != "andere") %>% 
            filter(gearbox == input$gearbox) %>% 
            dplyr::select(vehicleType, price) %>% 
            mutate(vehicleType = reorder(vehicleType, price)) %>% 
            group_by(vehicleType) %>% 
            summarise(price = round(mean(price),2)) %>% 
            ungroup() %>% 
            arrange(desc(price)) 
        
        valueBox(value = VT$price[1],subtitle = 'Best Price', 
                 icon = icon("car"))
    })
    
    output$infobox1 <- renderInfoBox({
        B_K_P_C <- cars %>% 
            filter(brand != "sonstige_autos") %>% 
            filter(fuelType == input$fuelType) %>% 
            dplyr::select(brand, kilometer, price) %>% 
            mutate(brand = reorder(brand, price)) %>% 
            group_by(brand) %>% 
            summarise(kilometer = round(mean(kilometer),2),
                      price = round(mean(price),2)) %>% 
            ungroup() %>%
            filter(price > 5000) %>% 
            gather(key, value, -brand)
        
        infoBox(value = B_K_P_C$value[1], title  = "Higher Kilometer",
                icon = icon("car-side"))
    })
    
    output$infobox2 <- renderInfoBox({
        infoBox(value = input$fuelType,title = 'Using Fuel', 
                 icon = icon("charging-station"))
    })
    
    output$infobox3 <- renderInfoBox({
        B_K_P_C <- cars %>% 
            filter(brand != "sonstige_autos") %>% 
            filter(fuelType == input$fuelType) %>% 
            dplyr::select(brand, kilometer, price) %>% 
            mutate(brand = reorder(brand, price)) %>% 
            group_by(brand) %>% 
            summarise(kilometer = round(mean(kilometer),2),
                      price = round(mean(price),2)) %>% 
            ungroup() %>%
            filter(price > 5000) %>% 
            gather(key, value, -brand)
        
        infoBox(value = B_K_P_C$value[6], title  = "Higher Price",
                icon = icon("euro-sign"))
    })
    
    
    output$leaflet1 <- renderLeaflet({
        
        
        
       map <-  leaflet(data = filter(dat, category == input$`Price-Maps`)) %>% 
            addTiles() %>% 
            addCircles(lng = ~Long,
                       lat = ~Lat,
                       weight = 5,
                       radius = ~sqrt(Price)*30,
                       popup = ~Cities,
                       fillColor = "transparent",
                       highlightOptions = highlightOptions(weight = 10,
                                                           color = "brown",
                                                           fillColor = "green"),
                       label = ~Cities)
       
       map
    })
}
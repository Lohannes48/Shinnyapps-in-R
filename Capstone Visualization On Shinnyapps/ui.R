header <- dashboardHeader()

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(
         text = "Gearbox Type in Car",
         tabName = "gearbox-type"
        ),
        menuItem(
            text = "Fuel Type",
            tabName = "Fuel-Type"
        ),
        menuItem(
            text = "Price By Regis Year",
            tabName = "Regis-Year"
        ),
        menuItem(
            text = "Price Mapping",
            tabName = "Price-Map"
        )
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "gearbox-type",
            fluidRow(
                valueBoxOutput("valuebox1",width = 4),
                valueBoxOutput("valuebox2",width = 4),
                valueBoxOutput("valuebox3",width = 4)
            ),
            fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "gearbox",
                        label = "Select Gear",
                        choices = selectGear
                    )
                )
            ),
            fluidRow(
                column(
                    width = 12,
                    plotlyOutput("gear")
                )
            )
        ),
        tabItem(
            tabName = "Fuel-Type",
            fluidRow(
                infoBoxOutput(outputId = "infobox1", width = 4),
                # infoBox("FUEL TYPE",8,icon = icon("charging-station")),
                infoBoxOutput(outputId = "infobox2", width = 4),
                # infoBox("PORSCHE","Best Offer",icon = icon("euro-sign"))
                infoBoxOutput(outputId = "infobox3", width = 4)
            ),
            fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "fuelType",
                        label = "Select Fuel",
                        choices = selectFuel
                    )
                )
            ),
            fluidRow(
                column(
                    width = 10,
                    plotlyOutput("fuel")
                )
            )
        ),
        tabItem(
            tabName = "Regis-Year",
            fluidRow(
                infoBox("BRAND IN JERMAN",40,icon = icon("copyright")),
                infoBox("TIMELINE","2010-2018",icon = icon("clock")),
                infoBox("HIGHER PRICE","Porsche",icon = icon("search-dollar"))
            ),
            fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "brand",
                        label = "Select Brand",
                        choices = selectBrand
                    )
                )
            ),
            fluidRow(
                column(
                    width = 10,
                    plotlyOutput("brand1")
                )
            )
        ),
        tabItem(
            tabName = "Price-Map",
            fluidRow(
                column(
                    width = 4,
                    radioButtons(
                        inputId = "Price-Maps",
                        label= "Select Price",
                        choices = c("Expensive","Cheap")
                    )
                )
            ),
            
            fluidPage(
                leafletOutput("leaflet1")
            )
        )
    )
)

dashboardPage(
    header = header,
    sidebar = sidebar,
    body = body
)
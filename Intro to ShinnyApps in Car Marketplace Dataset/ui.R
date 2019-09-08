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
        )
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "gearbox-type",
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
                    width = 10,
                    plotlyOutput("gear")
                )
            )
        ),
        tabItem(
            tabName = "Fuel-Type",
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
        )
    )
)

dashboardPage(
    header = header,
    sidebar = sidebar,
    body = body
)
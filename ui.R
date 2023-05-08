library(shiny)



fluidPage(

    # Application title
    titlePanel("Data Visualization, PUBH 6899"),

    # Sidebar with controls over metabolites and label sizes
    sidebarLayout(
        sidebarPanel(
            uiOutput('metabolites'),
            sliderInput(inputId = 'xlab', label = 'Modify X-lab size',
                        min = 6, max = 20, step = 1, value = 10),
            sliderInput(inputId = 'ylab', label = 'Modify Y-lab size',
                        min = 6, max = 20, step = 1, value = 10),
            sliderInput(inputId = 'ytitle', label = 'Modify Y-title size',
                        min = 6, max = 20, step = 1, value = 12)
        ),

        # Show boxplot(s)
        mainPanel(
            plotOutput('boxPlot')
        )
    )
)

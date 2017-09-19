install.packages(shinythemes)

library(shiny)
library(ggplot2)
library(dplyr)
library(shinythemes)
library(DT)
library(leaflet)

labnameR <- read.csv("labnameR.csv", stringsAsFactors = FALSE)

ui <- fluidPage(theme=shinytheme("cerulean"),
                h1("Oceans Research Groups around the world", 
                   img(src="FOL.jpg", width="260",height="100") ),
                em("Intenational Networking"),
                br(), br(),
                p("Welcome to our inner",
                  a(href="https://futureoceanslab.org/", "Future Oceans Lab"),"department"),
                br(), br(), br(), br(), 
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("ScoreInput", "Score", 1, 3, c(2,3)),
                    checkboxGroupInput("CountryInput","Country",
                                       choices = c("Canada","EEUU","Australia","Spain","South Africa"),
                                       selected = "EEUU"),
                    checkboxGroupInput("TopicInput","Topic",
                                       choices = c("CC", "Soc", "Ec","Econ","Ec-Soc", "Ec-CC", "Soc-CC","Ec-Soc-CC"),
                                       selected = "Ec-Soc-CC")
                  ),
                  
                  
                  mainPanel(
                    
                    DT::dataTableOutput("results", width="300",height="300"),
                    
                    br(), br(),
                    plotOutput("coolplot", width="300",height="300")
                  )
                )
)

server <- function(input, output) {
  output$coolplot <- renderUI({
    checkboxGroupInput("TopicInput", "Topic",
                       sort(unique(labnameR$Topic)),
                       selected = "Ec-Soc-CC")
  })  
  
  filtered <- reactive({
    if (is.null(input$TopicInput)) {
      return(NULL)
    }
    
    labnameR %>%
      filter(Score >= input$ScoreInput[1],
             Score <= input$ScoreInput[2],
             Topic %in% input$TopicInput,
             Country %in% input$CountryInput
             
      )
  })
  
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Web)) +
      geom_histogram()
  })
  
  output$results = DT::renderDataTable({
    filtered()
  })
  
  
  escape=FALSE
}

shinyApp(ui = ui, server = server)





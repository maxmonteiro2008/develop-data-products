
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Car Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("disp",
                        "Displacement (cu.in.)",
                        min = 71,
                        max = 472,
                        value = 71, step = 0.1),
            
            radioButtons("trans", h3("Transmisssion Type"),
                         choices = list("Manual"= 0, "Automatic"=1)),
            
            selectInput("cyl", "Number of Cylinders:",
                        c("4" = 4,
                          "6" = 6,
                          "8" = 8)),
            sliderInput("wt",
                        "Weight (x 1000lbs)",
                        min = 1,
                        max = 5,
                        value =1, step = 0.1),
            
            submitButton(text = "Apply Changes", icon = NULL, width = NULL)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          h1("Car fuel consume estimation"),
          
          h3("Estimated(miles/gallon) :"),
           
          h2(textOutput("result")),  
                  
          h2(" Estimation plot:"),
          
           plotOutput("estimation")
        )
    )
))

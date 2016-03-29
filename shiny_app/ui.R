library(shiny)

# Load the ggplot2 package which provides
# the 'mpg' dataset.

# Define the overall UI
shinyUI(

        fluidPage(
                # Application title
                titlePanel("Data Professional Course Recommendation"),
     
                
               
                
                sidebarLayout(
                        # Sidebar with a slider and selection inputs
                        sidebarPanel(
                                textInput(inputId = 'resume',
                                          label = 'Copy and paste the text of your resume here:',
                                          value="" ),
                                
                                br(),
                                sliderInput("number",
                                            "Course Recommended:",
                                            min = 1,  max = 20, value = 5),
                                submitButton("Update"),
                                br(),
                                br(),
                                br(),
                                br(),
                                h5('Introduction:'),
                                p("This is the application dedicated for the Team 12's capstone project of MSBA program at Arizona State University."),
                                p("To better help analytics professional developing their career, we built this reccomendation system to help them filling skill gaps"),
                                p("The code of the project and app can be found here: ",
                                  a("Yifan's Github", 
                                    href = "https://github.com/snowneji/MSBA_Capstone"))
                                
                                
                        ),
                        
                        mainPanel(
                                br(),
                                textOutput(outputId = 'title'),
                                br(),
                                br(),
                                tableOutput("final_rec"),
                                br()
 
                                
                        )
                )
        )
        
 
)
library(shiny)
library(DT)
library(shinydashboard)


## ui.R ##



sidebar <- dashboardSidebar(
        width = 300,
        sidebarMenu(
                        
                menuItem("Recommendation Model", tabName = "app", icon = icon("play")),
                menuItem("Documentation", icon = icon("book"), tabName = "doc",
                          badgeColor = "green"),
                menuItem("Complete Course List", tabName = "course", icon = icon("table")),
                menuItem("Feedback and Summary", tabName = "feedback",badgeLabel = "new", icon = icon("commenting")),
                textInput("resume", "Paste Your Resume Here:",width = '300px',value = "I'm a programmer and data miner"),
                br(),
                sliderInput("coursenumber", "Choose Number of Courses to Display:", min=1, max=15, value=5,width = '300px'),
                br(),
                br()
#                 submitButton(text="Update",icon = icon('play'),width = '295px')     
        )
)

body <- dashboardBody(
        tabItems(
                tabItem(tabName = 'app',
                        fluidRow(
                                valueBoxOutput("person_title"),
                                valueBoxOutput("pctmatch"),
                                valueBoxOutput("course")
                        ),
                        fluidRow(
                                box( title = "Top Courses for You:", solidHeader = FALSE,width =7,
                                     collapsible = TRUE,
                                     tableOutput("courselist"),height = 550),
                                box( title = "Top Skills We Recommend for You:", solidHeader = FALSE,width =5,
                                     collapsible = TRUE,
                                     plotOutput("gap"),height = 550)
                        )
                ),

                tabItem(tabName = 'doc',
                        fluidRow(
                              h2('......Coming Soon......')

                        )
                ),
                tabItem(tabName = 'course',
                        fluidRow(
                                tableOutput(outputId = 'complete_course')

                        )
                        
                ),
                
                tabItem(tabName = 'feedback',
                        fluidRow(
                                box( title = "Feedback", solidHeader = FALSE,
                                     collapsible = TRUE,
                                     textInput(inputId = 'rater_name',label = 'AnY CoMmEnTs?'),
                                     br(),
                                     sliderInput(inputId = 'rating',min = 1,max = 5,step = 1,value = 1,label = 'PlEaSe RaTe Me'),
                                     actionButton("submit2", "Submit"),
                                     height = 290,width=12)
                        ),
                        fluidRow(
                                box( title = "Rating Summary", solidHeader = FALSE,
                                     collapsible = TRUE,
                                     plotOutput("responses"),
                                     height = 600,width=6),
                                box( title = "PeOpLe's CoMmEnTs", solidHeader = FALSE,
                                     collapsible = TRUE,
                                     plotOutput("names"),
                                     height = 600,width=6)
                                
                        )
                                

                        
                        
                )
                     
        )           
)

# Put them together into a dashboardPage
dashboardPage(
        skin = 'yellow',
        dashboardHeader(title = "Author: Yifan Wang"),
        sidebar,
        body
)



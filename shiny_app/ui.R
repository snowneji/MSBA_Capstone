library(shiny)

## ui.R ##
library(shinydashboard)
sidebar <- dashboardSidebar(
        sidebarMenu(
                menuItem("Recommendation Model", tabName = "app", icon = icon("play")),
                menuItem("Documentation", icon = icon("book"), tabName = "doc",
                         badgeLabel = "new", badgeColor = "green")
                
        )
)

body <- dashboardBody(
  
        
        tabItem(tabName = 'table',
                fluidRow(
                        valueBoxOutput("person_title"),
                        valueBoxOutput("pctmatch"),
                        valueBoxOutput("course")
                ),
                
                fluidRow(
                        box(
                                title = "Inputs", status = "warning",
                                width = 5,height = 450,
                                collapsible = TRUE,
                                textInput("resume", "Paste Your Resume Here:",width = '100%',value = "I'm a programmer and data miner"),
                                br(),
                                sliderInput("number", "Choose Number of Courses to Display:", 1, 6, 1),
                                br(),
                                submitButton(text="Submit",icon = icon('play'))
                                
                        ),
                        box( title = "Course List", solidHeader = FALSE,width =7,
                             collapsible = TRUE,
                             tableOutput("coursetable"),height = 450)
                        
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



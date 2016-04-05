library(shiny)
library(shinydashboard)

# Define a server for the Shiny app
shinyServer(function(input, output) {
        

        
        

        title = reactive({
                source('main script.R')
                maintitle(input$resume)
                
        })
        
        courses = reactive({
                data2 = row.names(title())[1]
                maincourse(data2,input$resume)
        })
        
        
        
        
        
        
        output$person_title = renderValueBox({
                valueBox(
                        value = row.names(title())[1],
                        subtitle = "You're a  future",
                        icon = icon("child"),
                        color = "aqua"
                )       
        })
        
        output$pctmatch = renderValueBox({
                data = title()
                data2 = data[1]*100
                data2 = paste(data2,'%',sep = '')
                valueBox(
                        value = data2,
                        subtitle = "Your percent match",
                        icon = icon("check"),
                        color = if (data[1]*100 > 50) "olive" else "lime"
                )       
        })
        
        output$course = renderValueBox({
                
                data3 = courses()
                valueBox(
                        value = nrow(data3),
                        subtitle = "Courses you need to learn",
                        icon = icon("question"),
                        color = "maroon"
                )       
        })
        
        output$coursetable = renderTable({
                
                data3 = courses()
                data3[1:input$number,]
                
        })
                  

        
        


        


        
        

        
        
})
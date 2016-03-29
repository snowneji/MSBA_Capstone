library(shiny)

# Define a server for the Shiny app
shinyServer(function(input, output,session) {
        source('main script.R')
        

        output$title = renderText({
                
                data = maintitle(input$resume)
                data = trimws(data)
                msg = paste("Dude if you finish following courses, you're gonna be a super ",data,'!!!',sep = '')
                msg
             
               
                

                
        })
        

        output$final_rec = renderTable({
                data = maintitle(input$resume)
                data2 = maincourse(data,input$resume,input$number)
                data2
     
        })
        
        

        
        
})
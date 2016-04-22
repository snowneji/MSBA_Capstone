library(shiny)
library(shinydashboard)
library(ggplot2)
library(googlesheets)
library(wordcloud)



# 
options("googlesheets.shiny.client_id" = cl_id)
options("googlesheets.shiny.client_secret" = cl_sec)


# 
# gs_webapp_auth_url(client_id = cl_id,approval_prompt = 'auto')
# Define a server for the Shiny app
shinyServer(function(input, output) {

        formData = reactive({
                data1 = input$rating
                data1 = as.numeric(data1)
                data2 = input$rater_name
                data2 = as.character(data2)
                data = c(data2,data1)
                
        })
        
        title = reactive({
                source('main script.R')
                maintitle(input$resume)
                
        })
        
        gap = reactive({
                
                maincourse(title(),input$resume)
        })
        
        course=reactive({
                
                finalcourse(gap())
        })
        
        feedback=reactive({
                
                st = gs_title('Rec_sys_feedback')
                dat=gs_read_csv(st)
                dat
                
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
                
                data3 = course()
                valueBox(
                        value = nrow(data3),
                        subtitle = "Number of courses you can choose from",
                        icon = icon("book"),
                        color = "maroon"
                )       
        })
        
        output$courselist = renderTable({
                
                data3 = course()
                data3 = data3[,1:3]
                names(data3) = c('Course Name','Rating','Source')
                data3[1:input$coursenumber,]
                
        })

        
        
        output$complete_course = renderTable({
                
                data3 = course()
                data3 = data3[,1:3]
                names(data3) = c('Course Name','Rating','Source')
                data3
                
        })
        
        
        output$gap = renderPlot({
                
                data3 = gap()
                data3 = names(data3)
                freq = rep(1,length(data3))
                
                wordcloud(data3,freq,colors = brewer.pal(8,"Dark2"),random.color = T,random.order = T,scale = c(2, 0.1))
    
        })
        
        
        observeEvent(input$submit2 ,{
                st = gs_title('Rec_sys_feedback')
                gs_add_row(st,input = formData())
        })
        
        output$responses <- renderPlot({
                input$submit2
                st = gs_title('Rec_sys_feedback')
                dat=gs_read_csv(st)$Rating
                
                barplot(table(dat),col = brewer.pal(3,"Accent"),xlab = 'Rating',ylab = 'Frequency',border=F)
                

        })
        
        output$names <- renderPlot({
                input$submit2
                st = gs_title('Rec_sys_feedback')
                dat=gs_read_csv(st)
                
                
                wordcloud(dat$Name,freq = rep(x = 1,times = length(dat$Name)),colors = brewer.pal(3,"Dark2"),random.color = T,random.order = T,max.words = 100,scale = c(2, 0.1))
                
    
        })
                  

        
        


        


        
        

        
        
})
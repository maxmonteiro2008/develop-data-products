#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
data(mtcars)
    
  dsp<- reactive({as.numeric(input$disp)})
    cyli<-reactive ({as.numeric(input$cyl)})
    we<-reactive({as.numeric(input$wt)})
    trans<-reactive({as.numeric(input$trans)})
   
    
  
  
   
  output$estimation <- renderPlot({
   
      data(mtcars)
      dsp<- reactive({as.numeric(input$disp)})
      cyli<-reactive ({as.numeric(input$cyl)})
      we<-reactive({as.numeric(input$wt)})
      trans<-reactive({as.numeric(input$trans)})
      
      dat<- data.frame(disp=as.numeric(input$disp),cyl=as.numeric(input$cyl),wt=as.numeric(input$wt),am=as.numeric(input$trans))
    
      
    fit1<-lm(mpg~factor(am)+cyl+wt+disp,data=mtcars)
    
  
    pred<- predict(fit1,newdata=dat)
    
    
    g<-ggplot(mtcars, aes(x=wt, y=mpg, color=cyl, size=disp)) +
      geom_point()
    
    g<- g + annotate("point",x = as.numeric(input$wt), y =as.numeric(pred[1]), colour = "red",size=5)
    
    g<- g+ annotate("text",vjust=-0.5,hjust=0,x = as.numeric(input$wt), y =as.numeric(pred[1]), colour = "red", label="Estimated")
   
   
    g<- g + geom_smooth(method=lm,  linetype="dashed",
                        color="black", se=F)
    
    g
    
    
    
    

})
  
  output$result<-renderText({
    
    
    dat<- data.frame(disp=as.numeric(input$disp),cyl=as.numeric(input$cyl),wt=as.numeric(input$wt),am=as.numeric(input$trans))
    
    
    fit1<-lm(mpg~factor(am)+cyl+wt+disp,data=mtcars)
    
    
    pred<- predict(fit1,newdata=dat)
    
    as.character(pred[1])
    
    
  })
  
})


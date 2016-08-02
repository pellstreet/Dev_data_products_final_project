library(shiny)
library(HistData)
library(ggplot2)

data("GaltonFamilies")

#predictive function

childh <- function(fh,mh,sx) {
    
    mpheight<-(fh+mh*1.08)/2

    new.child <- data.frame(midparentHeight=mpheight,gender=sx)

    data(GaltonFamilies)

    fit3 <- lm(childHeight ~ midparentHeight + gender,data=GaltonFamilies)

    result<-predict(fit3, newdata=new.child,interval='prediction')
    
    as.numeric(round(result[1],1))
}

shinyServer(
  function(input, output) {
    
    #Reactive Function
    
    x<-reactive({childh(input$fh,input$mh,input$sx)})
    
    #pass result to output
    
    output$prediction <- renderPrint({x()})

    #create chart with heights for all family members  
  
    output$popHist<- renderPlot({ 
    
      #generate data frame for histogram input
    
      datf<-c(input$mh,x(),input$fh)
      datf<-as.data.frame(datf)
      datf$labels<-c("Mother (observed)","Child (predicted)","Father (observed)")
    
      #create histogram
  
      popHist<- ggplot(datf,aes(labels, datf, width=0.2))+ 
        geom_bar(stat="identity", fill="green", colour="light Green")+
        #geom_errorbar(limits, position=dodge, width=0.25)+
        geom_text(aes(label=datf), position=position_dodge(width=0.9), vjust=2,colour="red")+
        labs(x="")+
        labs(y="Height (inches)")+
        labs(title="Summary heights for family members")+
        theme_bw(base_size=15)+
        theme(axis.text=element_text(size=15), 
            axis.title=element_text(size=20), plot.title=element_text(size=20),
            panel.background=element_rect(fill="sky blue"),
            panel.grid.major = element_line(colour = "grey40"),
            panel.grid.minor = element_line(colour = "grey40"),
            axis.line = element_line(colour="red",size = 15))+ #3,face="bold"
        scale_y_continuous(breaks=seq(0,85,10))
      popHist
  })
})
  
  
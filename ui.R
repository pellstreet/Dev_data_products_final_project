library(shiny)

# Define UI for dataset viewer application

shinyUI(navbarPage("",
    
  tabPanel("Predictor",               
    pageWithSidebar(
    
      # Application title
    
      headerPanel("Child's Adult Height Predictor"),
      
      # Sidebar with input for the number of bins
    
      sidebarPanel(
      
        sliderInput('mh', 'Input mother\'s height in inches', 64, min = 45, max = 80, step = 0.5),
        sliderInput('fh', 'Input father\'s height in inches', 68, min = 45, max = 80, step = 0.5),
        selectInput('sx', 'Input the child gender',c("female",'male')),
        h5('--------------------------------------------------------------------------------------------
                                                                                                       '),
        h5('This Application predicts the adult\'s height of a child based on the height of the parents
           and the gender of the child. The predictor function is based on the Galton dataset,  which is a 
           dataset that was used by Galton in 1885 to study the correlation between the parent\'s height and their children.
                                                                                                      '),
        h5('--------------------------------------------------------------------------------------------')

      ),
    
    # Show result and a plot of the heights
    
    mainPanel(
      h3('Predicted adult height of child (inches):'),
      verbatimTextOutput("prediction"),
      plotOutput("popHist")
      )
    )
  ),
  tabPanel("More Info",
    mainPanel(
         h1('Developing Data Products - Final Project'),
         h5('7/28/2016'),
         h5('This app was created as part of the final project for the Coursera Developing Data Products class from Johns Hopkins University. 
            As part of this assignement a web app was created to predict an outcome using a number of predictors from a known dataset.
            The dataset used for this prediction is the GaltonFamilies dataset.
            Further documentation related to this app can be found here: https://github.com/pellstreet/Dev_data_products_final_project') 
      )
    )
  )
)

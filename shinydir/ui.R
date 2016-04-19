#library(shiny)

shinyUI(fluidPage(
  titlePanel("Next word prediction using Natural Langage Processing Model"),
  
 
  HTML("<span style=\"color:black; font-style:normal\"> Please, enter some text into the Input text box below. As soon as you will key 
        some words into the input text box, the predicted next word will show up in the right panel. The right panel can display up to 
        five (5) predicted next words ranged in decreasing order of their probability of occurence. </span>"),
       br(), br(),
  
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "txt_input", label = "Input text box",value = "Please, enter some text here"),

      br()         
      
    ),
    
    mainPanel(
      h3("The best Prediction"),        
      strong(textOutput("txt_prediction")), # The best predicted text.
      
      tags$head(tags$style("#txt_prediction {color: green;
                           font-size: 28px;
                           }"
        )),
      tags$head(tags$style("#txt_secondbest {color: blue;
                           font-size: 20px;
                           }"
        )),  # This adds the style to the <HEAD> tag for the page.
      tags$head(tags$style("#txt_thirdbest {color: orange;
                           font-size: 16px;
                           }"
        )),  # This adds the style to the <HEAD> tag for the page.
      tags$head(tags$style("#txt_fourthbest {color: brown;
                           font-size: 14px;
                           }"
        )),  # This adds the style to the <HEAD> tag for the page.
      tags$head(tags$style("#txt_fifthbest {color: red;
                           font-size: 12px;
                           }"
        )),  # This adds the style to the <HEAD> tag for the page.
      
      h4("Second best prediction"),
      #helpText("<Alternative predictions go here>"),
      strong(textOutput("txt_secondbest")), # The second best predicted word.
      h5("Third best prediction"),
      #helpText("<Alternative predictions go here>"),
      strong(textOutput("txt_thirdbest")), # The third best predicted word.
      h5("The fourth"),
      #helpText("<Alternative predictions go here>"),
      strong(textOutput("txt_fourthbest")), #The fourth best predicted word.
      h5("the fifth"),
      #helpText("<Alternative predictions go here>"),
      strong(textOutput("txt_fifthbest")), # The fifth best predicted word.
      
      
      
      br(), br(),
      p("Want more information about this application ?", a("Just click here", href = "http://rpubs.com/amosang/capstone_final_report", target = "_blank"), "."),
      br()
      )
  )
))



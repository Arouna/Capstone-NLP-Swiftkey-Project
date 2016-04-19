shinyServer(function(input, output) {
  
  mymodel <- readRDS( file = "C:/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/shinydir/mymodel.RDS")
  

  
  # Use reactive expression, to enable caching, if input parameters (eg: the user string, or the number of alternative predictions to return) have not changed.
  do_Predict <- reactive({  
    #PLACEHOLDER# paste("Reactive function activated:", input$txt_input)
    predictnexword(mymodel, input$txt_input, rank = 5)
  })
  
  output$txt_prediction <- renderText({
    head(do_Predict(), 1)  # Return just the first value
  })
  
  output$txt_secondbest <- renderText({
    do_Predict()[2]  # Return the second value
  })
  
  output$txt_thirdbest <- renderText({
    do_Predict()[3]  # Return  the third value
  })
  
  output$txt_fourthbest <- renderText({
    do_Predict()[4]  # Return the fourth value
  })
  
  output$txt_fifthbest <- renderText({
    do_Predict()[5]  # Return the fifth value
  })
  
  
#   output$txt_alternatives <- renderText({
#     paste(do_Predict()[-1], collapse = ", ")  # Return all except the first value
#   })
  
})


Next word prediction using Natural Langage Processing Model
========================================================
Arouna Mopa

April 16, 2016

Data Science capstone project - Coursera/JHU 

Project background
========================================================

This project used the NLP model to build an algorithm to suggest the next word, given a text enter by the user as input.
The data source used in this project containstThree types of data including twitter, news and blogs. After cleaning and sub-setting 
data to build the training model,an N-gram model was created  and a predictive algorithm (Katz Back-off) was applied to predict next word. 

The final data product model was publish as a Shiny application. This application can be found online usng the links bellow:

[Shiny App URL] (shny links)

[Project Software] (github link)

How does the Model Predict the Next Word ?
========================================================
In an N-gram model, the length of the history is N-1. For example In a <U+25FE>2-gram model the length of the history is 1. In a 3-gram model, the length of the
history is 2.

The prediction of the next word is based on the computation of the probability of a phrase which is approximated by the ratio of the number
of times the phrase occurred divided by the number of times the history occurred:  

<U+25FE>p(Good morning everybody) = #(Good morning everybody)/ #(Good Morning). 

 How does the application look like?
========================================================

* The left panel on the home page has an input box where the user enter a text.  

* As the content of the imput box changes, the suggested next words are displayed in the right panel. 

* This application can suggest up to five  next word range in decreasing order of the probality of occurrence.
 
***

![alt text]("/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ui.PNG")
 
 How does the application look like?
========================================================
  
  ![alt text](/Users/amopa/Desktop/Coursera/DataSciences/Capstone NLP Swiftkey Project/data/ui.PNG)

Resources
========================================================
* http://www.cs.pomona.edu/~dkauchak/classes/s11/cs159-s11/lectures/159-5-LM.pdf
* https://west.uni-koblenz.de/sites/default/files/BachelorArbeit_MartinKoerner.pdf
* http://www.kenbenoit.net/courses/essex2014qta/exercise6.pdf
* https://cran.r-project.org/web/packages/quanteda/vignettes/quickstart.html#document-feature-matrix-analysis-tools
* http://www.kenbenoit.net/courses/nyu2014qta/exercise1.html
* https://github.com/kbenoit/quanteda



 

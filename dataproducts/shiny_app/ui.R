library(shiny)

shinyUI(fluidPage(
  titlePanel("Fair football betting odds"),
  p('This little app calculates fair football betting odds, based on the
     average number of goals you expect for the home and the
     away team, respectively. It also uses googleVis to show
     graphically how the
     probabilities of the final scores depend on
     the expected average goals.'),
  p('The
     calculations are done based on the assumption that goals are
     Poisson distributed and independent of each other. 
     If you want to know more about this method, watch my '
    ,a("slidify presentation"
       ,href='http://justastemp.github.io/datascience/dataproducts/slidify/football_betting/index.html'),'.'),
  sidebarLayout(
  sidebarPanel(
    h4('Your expectation for...'),
    sliderInput('hg', 'Average home goals',value = 0.88, min = 0, max = 5, step = 0.01,),
    sliderInput('ag', 'Average away goals',value = 0.88, min = 0, max = 5, step = 0.01,),
  h4('Your input'),
  verbatimTextOutput("inputhg"),
  verbatimTextOutput("inputag"),
  h4('Resulting fair odds'),
  verbatimTextOutput("home"),
  verbatimTextOutput("draw"),
  verbatimTextOutput("away")
),
  mainPanel(
        h4('Probabilities of final scores'),
        htmlOutput(("bubbles"))
    )
))
)

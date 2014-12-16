library(shiny)

shinyUI(fluidPage(
  titlePanel("Fair football betting odds"),
  h6('This little app calculates fair football betting odds, based on the
     average number of goals you expect for the home and the
     away team, respectively. It also uses googleVis to show
     graphically how the
     probabilities of the final scores depend on
     the expected average goals.'),
  sidebarLayout(
  # headerPanel("Fair football betting odds"),
  #  headerPanel(""),
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

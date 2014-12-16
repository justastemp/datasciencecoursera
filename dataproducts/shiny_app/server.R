library(shiny)
library(googleVis)

# this function calculates the odds

calcprobs <- function(hg,ag) {
  lambda_home <- hg
  lambda_away <- ag
  eh <- exp(-lambda_home)
  ea <- exp(-lambda_away)
  k <- c(0:16)
  fac_k <- factorial(k)
  p_home <- eh * lambda_home^k / fac_k
  p_away <- ea * lambda_away^k / fac_k
  cols <- c("home_goals","away_goals","probability")
  probs <- data.frame(home_goals=integer(), 
                      away_goals=integer(),
                      probability=numeric())
  for (i in 1:length(k)) {
    p_ah <- p_home[i] * p_away
    p_mat <- data.frame(i-1,c(0:(length(k)-1)),p_ah)
    colnames(p_mat) <- cols
    probs <- rbind(probs,p_mat)
  }
  probs["type"] = ""
  probs$type[probs$home_goals == probs$away_goals] <- "draw"
  probs$type[probs$home_goals >  probs$away_goals] <- "home"
  probs$type[probs$home_goals < probs$away_goals] <- "away"
  sums <- aggregate(probs$probability,list(type = probs$type), sum)
  sums$odds <- 1/sums$x
}

# we do the same for the plot for correct score probabilities

plotcs <- function(hg,ag) {
  lambda_home <- hg
  lambda_away <- ag
  eh <- exp(-lambda_home)
  ea <- exp(-lambda_away)
  k <- c(0:8)
  fac_k <- factorial(k)
  p_home <- eh * lambda_home^k / fac_k
  p_away <- ea * lambda_away^k / fac_k
  cols <- c("home_goals","away_goals","probability")
  probs <- data.frame(home_goals=integer(), 
                      away_goals=integer(),
                      probability=numeric())
  for (i in 1:length(k)) {
    p_ah <- p_home[i] * p_away
    p_mat <- data.frame(i-1,c(0:(length(k)-1)),p_ah)
    colnames(p_mat) <- cols
    probs <- rbind(probs,p_mat)
  }
  probs["type"] = ""
  probs$type[probs$home_goals == probs$away_goals] <- "Draw"
  probs$type[probs$home_goals >  probs$away_goals] <- "Home win"
  probs$type[probs$home_goals < probs$away_goals] <- "Away win"
  sqrt_prob <- sqrt(probs$probability)
  result <- paste(probs$home_goals,probs$away_goals, sep=":")
  probs <- cbind(probs,result)
}

shinyServer(
  function(input, output) {
    output$inputhg <- renderText({paste("Home goals:", input$hg)})
    output$inputag <- renderText({paste("Away goals:", input$ag)})
    output$home <- renderText({paste("Home win:", round(calcprobs(input$hg,input$ag)[3], 2))})
    output$draw <- renderText({paste("Draw:", round(calcprobs(input$hg,input$ag)[2], 2))})
    output$away <- renderText({paste("Away win:", round(calcprobs(input$hg,input$ag)[1], 2))})
    output$bubbles <- renderGvis({
      gvisBubbleChart(plotcs(input$hg,input$ag),idvar="result",
                      xvar="away_goals", yvar="home_goals", 
                      colorvar="type",sizevar="probability",
                      options=list(sizeAxis = '{minSize: 0,  maxSize: 20}',
                                  hAxis='{minValue:0, maxValue:4}',
                                  hAxes="[{title:'Away goals',textPosition: 'out'}]", 
                                  vAxes="[{title:'Home goals',textPosition: 'out'}]",
                                  hAxis.gridlines.count=7,
                                  width=550, height=500))
      })
})



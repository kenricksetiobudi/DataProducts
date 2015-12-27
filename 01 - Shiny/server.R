library(shiny)

data(mtcars)
regression <- lm(mpg~hp+cyl+wt, data=mtcars)

mpg <- function(hp, cyl, wt) {
        regression$coefficients[1] + regression$coefficients[2] * hp + 
                regression$coefficients[3] * cyl + regression$coefficients[4] * wt
}

shinyServer(
        function(input, output) {
                adjusted_weight <- reactive({input$wt/1000})
                predicted_mpg <- reactive({mpg(input$hp, as.numeric(input$cyl), adjusted_weight())})
                output$inputValues <- renderPrint({paste(input$cyl, "cylinders, ",
                                                         input$hp, "horsepower, ",
                                                         input$wt, "lbs")})
                output$prediction <- renderPrint({paste(round(predicted_mpg(), 2), "miles per gallon")})
                output$plots <- renderPlot({
                        par(mfrow = c(1, 3))
                        # Horsepower
                        with(mtcars, plot(hp, mpg,
                                          xlab='Horsepower',
                                          ylab='MPG',
                                          main='MPG vs horsepower'))
                        points(input$hp, predicted_mpg(), col='red', cex=3, lwd = 2)                 
                        # Number of Cylinders
                        with(mtcars, plot(cyl, mpg,
                                          xlab='Number of cylinders',
                                          ylab='MPG',
                                          main='MPG vs cylinders'))
                        points(as.numeric(input$cyl), predicted_mpg(), col='red', cex=3, lwd = 2)  
                        # Weight
                        with(mtcars, plot(wt, mpg,
                                          xlab='Weight (lb/1000)',
                                          ylab='MPG',
                                          main='MPG vs weight'))
                        points(adjusted_weight(), predicted_mpg(), col='red', cex=3, lwd = 2)  
                })
        }
)
library(shiny)
shinyUI(pageWithSidebar(
        headerPanel('Miles Per Gallon Predictor'),
        sidebarPanel(
                h3('Context'),
                p('This application is based on the Motor Trend study which analyses the relationship between a set of variables and miles per gallon.'),
                p('Horsepower, number of cylinder and car weight is used as the predictors of MPG in this application.'),
                h3('Guide'),
                p('To use the application, enter the horsepower, number of cylinders and weight of your car below.'),
                p('The predicted MPG will be generated at the main panel on your right.'),
                h3('Parameters'),
                numericInput('hp', 'Gross horsepower:', 100, min = 50, max = 500, step = 10), # example of numeric input
                radioButtons('cyl', 'Number of cylinders:', c('4' = 4, '6' = 6, '8' = 8), selected = '4'), # example of radio button input
                numericInput('wt', 'Weight (lbs):', 3000, min = 1000, max = 5000, step = 100)
        ),
        mainPanel(
                h3('Predicted MPG'),
                h5('You have provided the below inputs:'),
                verbatimTextOutput("inputValues"),
                h5('According to the prediction using the "mtcars" dataset, here is your car MPG (circled in red) relative to the cars in the dataset.'),
                verbatimTextOutput("prediction"),
                plotOutput('plots'),
                p(),
                p(),
                p('Data Source: 1974 Motor Trend US magazine data extract.'),
                p()
        )
))

# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI (fluidPage(
    tags$div(
        class="navbar navbar-masthead",
        div(
            class="navbar-inner",
            a(href="#", class="brand","Stock master"),
            tags$form(
                class="navbar-form pull-left",
                
                tags$input(id="symbol_displayed",type="text",placeholder="IBM, GOOG, ...", class="span5", value="IBM"),
                tags$input(id="symbol",type="text", style="display:none",placeholder="IBM, GOOG, ...", class="span5", value="IBM"),
                tags$a(
                    href="#",
                    class="btn btn-primary",
                    onclick="_doClick();",
                    tags$i(
                        class="icon-search icon-white"
                    )
                )
            )
        )
    ),
    
    fluidRow(
        column(8,
               fluidRow(
                   column(4,
                          sliderInput(inputId="dayRange", label=strong('Number of days: '), min=20, max=1000, value=250, step=10)),
                   column(4,selectInput("type", "Select chart type:", choices=c("Auto"="auto","Candle Sticks"="candlesticks", "Match Sticks"="matchsticks", "Bars"="bars", "Line"="line"))),
                   column(4,selectInput("theme", "Select Theme:", choices=c("Black"="black","White"="white")))
                   
                   
               ),
               
               fluidRow(
                   column(4,checkboxInput("bband","Add Bollinger Bands to Chart"))
               ),
               
               
               fluidRow(
                   mainPanel(
                       tags$head(tags$script(src="custom.js")),
                       tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
                       tags$link(rel = "stylesheet", type = "text/css", href = "todc.css"),
                       plotOutput("stockPlot"),
                       width=12
                   )
               )
        ),
        column(4,
               fluidRow(
                   column(12,
                          tabsetPanel(
                              tabPanel("News",  uiOutput('company_headline')), 
                              tabPanel("Stock Examples",
                                       tags$p("Here are some stock examples to get you started"),
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("IBM")',"IBM")," - IBM")),
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("GOOG")',"GOOG")," - Google")),
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("YHOO")',"AAPL")," - Yahoo")),
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("AAPL")',"AAPL")," - Apple")),
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("FB")',"FB")," - Facebook"))
                                       
                              )
                          )
                   )
               )
        )
        
    )
    
))

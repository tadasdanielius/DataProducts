
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
                       tags$br(),
                       tags$div(class="alert",
                                tags$strong("Note"), "Data is downloaded from remote servers (Yahoo). So, it might take some time to load or if it takes too looooooog please refresh your browser"
                       ),
                       tags$br(),
                       h3('Getting started'),
                       tags$div(
                           "Stock master application is Charting tool to create standard financial charts given number of days interval. To get started you can go to Stock examples and click one of the stocks listed or you can enter stock symbol into input field and press enter, some examples are VNET, AGTK, AOL, BIDU or wider list can be found on various financial websites like ", a(href="http://www.marketwatch.com/tools/industry/stocklist.asp?bcind_ind=9535&bcind_period=3mo",
"Market Watch", target="_blank"                                                                                                                                                                                                                                                                                                                        ), "(External link)"
                           ),
p("Together with stock information related headline will also be fetched and rendered on the right side bar"),
                       p("Since application is using Yahoo API for retrieving financial information it is beyond my control to fully assure the performance. If it takes too long to load please refresh the browser."),
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
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("YHOO")',"YHOO")," - Yahoo")),
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("AAPL")',"AAPL")," - Apple")),
                                       tags$ul(class="unstyled",tags$li(tags$a(href="#", onclick='_doLinkClick("FB")',"FB")," - Facebook"))
                                       
                              )
                          )
                   )
               )
        )
        
    )
    
))


# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(quantmod)
library(XML)

shinyServer(function(input, output, session) {
    
    env <- new.env();
    env$symbol_cache <- NULL;
    env$news <- NULL;
    
    loadData <- reactive({
        symbol <- toupper(input$symbol);
        symbol_cache <- env$symbols;
        if (is.null(symbol_cache[symbol])) {
            symbol_cache[symbol_cache] <- getSymbols(symbol, from='2008-01-01', auto.assign=F);
        }
    });
    
    loadHeadlines <- reactive({
        symbol <- toupper(input$symbol);
        headlines <- env$headlines;
        if (is.null(headlines[symbol])) {
            headlines[symbol] <- xmlTreeParse(paste("http://finance.yahoo.com/rss/headline?s=",symbol,sep=""));
        }
    });
    
    loadIndustryNews <- reactive({
        symbol <- toupper(input$symbol);
        industryNews <- env$industryNews;
        if (is.null(industryNews[symbol])) {
            industryNews[symbol] <- xmlTreeParse(paste("http://finance.yahoo.com/rss/industry?s=",symbol,sep=""));
        }
    });
    
    render_news <- function(doc) {
        items <- xpathApply(xmlRoot(doc), "//item");
        output <- '<ul class="media-list">';
        for (i in 1:length(items)) {
            item <- xmlSApply(items[[i]], xmlValue)
            if (class(item)=="list") {
                url <- item$link;
                title <- item$title;
                desc <- item$description;
                pubDate <- item$pubDate;
            } else {
                url <- item['link'];
                title <- item['title'];
                desc <- item['description'];
                pubDate <- item['pubDate'];
            }
            output <- paste(
                output,
                '<li class="media"><div class="media-body"><h5><a href="',url,'" target="_blank">',
                title,"</a></h5>",desc,
                '<p class="published">Published: ',pubDate,"</p></div></li>",sep="");
            
        }
        
        output<-paste(output,"</ul>");
        HTML(output);
        
    }
    
    
    output$company_headline <- renderUI({
        doc <- loadHeadlines();
        render_news (doc);
    });
    
    output$industry_news <- renderUI({
        doc <- loadIndustryNews();
        render_news (doc);
    });
    
    
    dayRange <- reactive({
        data = loadData()
        max(1,nrow(data) - input$dayRange) : nrow(data)
    });
    
    chart_data <- function() {
        loadData()[dayRange(),]
    }
    
    bband <-reactive({
        if (input$bband==T)
            addBBands();
    });
    
    output$stockPlot <- renderPlot({
        d <- chart_data();
        chartSeries(d,type=input$type, theme=chartTheme(input$theme), name=input$symbol)
    
        if (input$bband==T)
            addBBands();
        
        
    })
})

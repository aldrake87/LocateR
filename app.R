library(leaflet)
library(shiny)

ui <- fluidPage(leafletOutput("map", height = 500),
                uiOutput("loc"),
                fluidRow(
                  column(width = 6,
                         uiOutput("lat")),
                  column(width = 6,
                         uiOutput("long"))
                )
                )

server <- function(input, output, session){
  output$loc <- renderUI({
    tags$script('$(document).ready(function () {
              navigator.geolocation.getCurrentPosition(onSuccess, onError);
                
                function onError (err) {
                Shiny.onInputChange("geolocation", false);
                }
                
                function onSuccess (position) {
                setTimeout(function () {
                var coords = position.coords;
                
                Shiny.onInputChange("geolocation", true);
                Shiny.onInputChange("lat", coords.latitude);
                Shiny.onInputChange("long", coords.longitude);
                Shiny.onInputChange("accuracy", coords.accuracy);
                
                }, 1100)
                }
  });')
  })
  
  output$lat <- renderUI({
    textInput(inputId = "myLat", label = "Latitude", value = input$lat)
  })
  
  output$long <- renderUI({
    textInput(inputId = "myLong", label = "Longitude", value = input$long)
  })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.DarkMatter",
                      options = providerTileOptions(noWrap = TRUE)) %>%
      fitBounds(lng1 = -0.2, lng2 = 0.0, lat1 = 51.4, lat2 = 51.6)
  })
  
  observe({
    req(input$myLat)
    
    print(input$myLat)
    print(input$myLong)
    
    proxy <- leafletProxy("map")
    
    proxy %>%
      clearGroup("ImHere") %>%
      addCircleMarkers(lng = as.numeric(input$myLong), 
                       lat = as.numeric(input$myLat), 
                       radius = 10,
                       group = "ImHere", weight = 5, opacity = .5,
                       color = "red", fillOpacity = .2,
                       popup = paste0("You are here!"))
  })
}

shinyApp(ui, server)
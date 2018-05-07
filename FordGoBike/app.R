

library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(rlang)
library(ggmap)

tripdata_2017 <- read_csv("data/tripdata_2017.csv")
real_time_data_app <- read_csv("data/real_time_data.csv")
stationinfo_sf <- read_csv("data/stationinfo_sf.csv")

tripdata_2017 <- tripdata_2017 %>%
  separate(start_time, c("Start_Year","Start_Month","Start_Day","Start_Hour","Start_Minute","Start_Second")) %>%
  separate(end_time, c("End_Year","End_Month","End_Day","End_Hour","End_Minute","End_Second"))

sf <- c(-122.4194, 37.77493)
sf_roadmap <- get_map(sf,maptype="toner-lite",source = "stamen", zoom = 12)


options(shiny.sanitize.errors = FALSE)

# Define UI ----
ui <- navbarPage("Ford GoBike",
                 
    #HISTORICAL DATA TAB             
    tabPanel("Historical Data",
         sidebarPanel(
           selectInput("startmonth",
                       label = "Choose a month to display",
                       choices = c(
                         "June" = "06",
                         "July" = "07",
                         "August" = "08",
                         "September" = "09",
                         "October" = "10",
                         "November" = "11",
                         "December"= "12"),
                       selected = "06"),
           selectInput("var",
                       label = "Choose variable to display",
                       choices = c(
                         "Start Station ID" = "start_station_id",
                         "End Station ID" = "end_station_id",
                         "Trip Duration" = "duration_sec",
                         "Bike ID" = "bike_id")
                       )
           
           ),
         mainPanel(
           tabsetPanel(
             tabPanel("Plot",plotOutput("barplot")),
             tabPanel("Map",plotOutput("map_hist"))))),
         
    
    #REAL TIME DATA TAB
    tabPanel("Real-Time Data",
         sidebarPanel(
           selectInput("station",
                       label = "Station of Interest:",
                       choices = unique(real_time_data_app$station_id),
                       selected = "15"
                       ),
           
           selectInput("var2",
                       label = "Choose variable to display",
                       choices = list("num_bikes_available","num_docks_available","percent_filled"),
                       selected = "percent_filled")
           
           ),
         mainPanel(
           tabsetPanel(
             tabPanel("Plot", plotOutput("line")), 
             tabPanel("Map", plotOutput("map_real"))))))
          
          

# Define server logic ----
server <- function(input, output) {
  
  output$barplot <- renderPlot({

    ggplot(
      filter(tripdata_2017, 
             Start_Month == input$startmonth)) +
      
      geom_histogram(mapping=aes_string(x=as.name(input$var))) +
      ylab("Number of Trips") +
      xlab(input$var) })

  
  output$line   <- renderPlot({
    subset1 <- subset(real_time_data_app,station_id == input$station)
    variable <- subset1[,input$var2]
    across <- subset1[,"time"]
    data1 <- cbind(variable, across)
    colnames(data1) <- c("yvar", "time")
    data1 <- as_tibble(data1)
    
    ggplot(data1) + 
      geom_smooth(mapping = aes(x = time, y = yvar)) +
      ylab(input$var2) +
      xlab("Time")
    
  })
  
  output$map_real <- renderPlot({
    coord <- subset(stationinfo_sf, station_id == input$station)
    ggmap(sf_roadmap) + 
      geom_point(data=coord, mapping=aes(x=lon,y=lat), color = "red")
    
    
  })
  
  output$map_hist <- renderPlot({
    subset3 <- filter(tripdata_2017, Start_Month == input$startmonth)
    lon <- subset3[,"start_station_longitude"]
    lat <- subset3[,"start_station_latitude"]
    variable <- subset3[,input$var]
    data3 <- cbind(lon, lat)
    data3 <- cbind(variable, data3)
    colnames(data3) <- c("colorvar", "lon","lat")
    data3 <- as_tibble(data3)
    
    
    ggmap(sf_roadmap) + 
      geom_point(data=data3, mapping=aes(x=lon,y=lat,color=colorvar))
    
    
  })
  
}









# Run the app ----
shinyApp(ui = ui, server = server)
install.packages("leaflet")
library("leaflet")
m <- leaflet(data=quakes[1:20,]) %>%
  addTiles() %>%
    addMarkers(lng=-8.683416, lat=42.1677063, popup="Future Oceans Lab")
m  

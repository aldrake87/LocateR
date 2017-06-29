# LocateR
Display the user location within a `Shiny`/`Leaflet` application

This mini-app uses the RShiny `tag` function to include additional JavaScript in order to get the location of the app user. Note that the user must run the app in their browser and share their location when the browser pop-up appears.

The location will then be displayed on the map, along with the coordinates in the Lat/Long input boxes - the user can then change the marker location by modifying the `textInputs`.

The app location defaults to London but you could add an additional fitBounds to the Proxy to pan to the user location when applied.

Working version of the app here [https://aldrake87.shinyapps.io/locater/](https://aldrake87.shinyapps.io/locater/)

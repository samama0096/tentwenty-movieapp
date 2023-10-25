# tentwenty-movieapp

 ## Folder Structure:
 ### lib/
       data/
           models/
           prefs/
           services/
       interface/
           utils/
                constants/
                themes/
           views/
           controllers/


### Instructions for folders:
    * Models folder contains data models i.e. movie-model
    * Prefs contains cache-prefs to save and get data from shared-prefs
    * Services contains movie-service containing all functions for watch-upcoming-movies and search-movies api
    * Utils contains theme for app and constants for app like widgets, paddings, spacings etc.
    * Views contains pages of the app with frontend only along with GetX controllers injection.
    * Controllers contains GetX controllers for the entire app.


### Controllers:
    * Watch Controller handles the movie service to load upcoming movies and the save into cache using Cache Pref's methods.
    * used for controlling loading in watch view, checking if app is using Cache instead of live data.
    * Search controller only used for searching a movie query inside views/search_view.dart
    * Internet controller used to add listener for internet connection. Used in watch_view.dart (at bottom) with Refresh Indicator also.
    * Splash controller used for loading splash and checking for internet. If internet not available, it loads cache data into upcomingMovies list of watch_controller.dart

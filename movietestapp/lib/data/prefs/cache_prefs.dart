import 'package:movietestapp/interface/utils/constants/prefs_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie_model.dart';

class CachePrefs {
  Future<bool> saveMoviesToCache(List<MovieModel> movies) async {
    final sharedInstance = await SharedPreferences.getInstance();
    try {
      await sharedInstance.setStringList(PrefsConstants.movieCacheName,
          MovieModel.movieListToStringList(movies));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<MovieModel>> getMoviesFromCache() async {
    List<MovieModel> cachedMovies = [];
    final sharedInstance = await SharedPreferences.getInstance();
    try {
      var res = sharedInstance.getStringList(
            PrefsConstants.movieCacheName,
          ) ??
          [];
      if (res.isNotEmpty) {
        cachedMovies = MovieModel.stringListToMovieList(res);
      }
      return cachedMovies;
    } catch (e) {
      print(e);
      return cachedMovies;
    }
  }
}

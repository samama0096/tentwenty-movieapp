import 'package:get/get.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/data/services/movie_service.dart';

class GetSearchController extends GetxController {
  Rx<bool> isSearching = Rx(false);
  Rx<String> enteredQuery = ''.obs;
  List<MovieModel> searchResults = [];
  final MovieService _movieService = MovieService();

  Future searchForMovie(String query) async {
    isSearching.value = true;
    if (query.isNotEmpty) {
      enteredQuery.value = query;
      List<MovieModel> searches = await _movieService.searchAMovie(query);

      if (searches.isNotEmpty) {
        searchResults = searches;
      }
    }

    isSearching.value = false;
  }
}

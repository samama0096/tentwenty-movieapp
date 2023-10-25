import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/data/prefs/cache_prefs.dart';
import 'package:movietestapp/data/services/movie_service.dart';

import 'search_controller.dart';

class WatchViewController extends GetxController {
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isCachedUsed = Rx(false);
  Rx<bool> showSearch = Rx(false);
  List<MovieModel> upcomingMovies = [];
  final MovieService _movieService = MovieService();
  Rx<bool> genresLoading = Rx(false);
  TextEditingController queryController = TextEditingController();
  final searchController = Get.put(GetSearchController());
  CachePrefs cachePrefs = CachePrefs();

  @override
  void onReady() async {
    super.onReady();

    queryController.addListener(() async {
      if (queryController.text.isNotEmpty) {
        await searchController.searchForMovie(queryController.text.trim());
      }
    });
  }

  toggleSearchButton() {
    showSearch.value = !showSearch.value;
  }

  Future getUpcomingMovies() async {
    upcomingMovies.clear();
    isLoading.value = true;
    var res = await _movieService.fetchUpcomingMovies();
    isLoading.value = false;

    if (res.isEmpty) {
      return;
    }
    upcomingMovies = res;
    isCachedUsed.value = false;
    await cachePrefs.saveMoviesToCache(upcomingMovies);
  }

  Future getGenresOfMovie(String id) async {
    var res = await getGenres(id);
    updateGenres(id, res);
  }

  Future getGenres(String id) async {
    genresLoading.value = true;
    var res = await _movieService.getGenres(id);
    if (res.isEmpty) {
      genresLoading.value = false;
      return;
    }

    genresLoading.value = false;
    return res;
  }

  void updateGenres(String id, var res) {
    upcomingMovies
        .where((element) => id == element.id.toString())
        .first
        .genresnames = res;
  }
}

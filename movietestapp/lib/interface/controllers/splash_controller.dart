import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/interface/controllers/watch_controller.dart';
import 'package:movietestapp/interface/utils/constants/prefs_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/home_view.dart';

class SplashController extends GetxController {
  Rx<bool?> isCacheAvailable = Rx(null);
  Rx<bool> isInternetAvailable = false.obs;
  final watchViewController = Get.put(WatchViewController());

  @override
  void onReady() async {
    super.onReady();
    isInternetAvailable.value = await InternetConnection().hasInternetAccess;
    handleOnReady();

    Timer(const Duration(seconds: 1), () {
      Get.to(() => const HomeView());
    });
  }

  Future handleOnReady() async {
    if (isInternetAvailable.value) {
      watchViewController.getUpcomingMovies();
    } else if (!isInternetAvailable.value) {
      await checkCache();
      if (isCacheAvailable.value != null && isCacheAvailable.value == true) {
        await loadCache();
        watchViewController.isCachedUsed.value = true;
      }
    }
  }

  Future checkCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = sharedPreferences.containsKey(PrefsConstants.movieCacheName);
    isCacheAvailable.value = res;
  }

  Future loadCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    watchViewController.upcomingMovies = MovieModel.stringListToMovieList(
        sharedPreferences.getStringList(PrefsConstants.movieCacheName) ?? []);
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/interface/utils/constants/api_constants.dart';

class MovieService {
  Map<String, String> headers = {
    "accept": "application/json",
    "Authorization": "Bearer ${ApiConstants.bearer}"
  };

  //fetch upcoming api's
  Future<List<MovieModel>> fetchUpcomingMovies() async {
    List<MovieModel> upcomingMovies = [];

    http.Response res =
        await http.get(ApiConstants.upcomingEndpoint, headers: headers);
    var moviesJson = jsonDecode(res.body)['results'];
    for (var movie in moviesJson) {
      upcomingMovies.add(MovieModel.fromJson(movie));
    }

    return upcomingMovies;
  }

  Future<List<MovieModel>> searchAMovie(String query) async {
    List<MovieModel> results = [];

    http.Response res = await http
        .get(Uri.parse(ApiConstants.searchEndPoint(query)), headers: headers);
    var moviesJson = jsonDecode(res.body)['results'];
    for (var movie in moviesJson) {
      results.add(MovieModel.fromJson(movie));
    }

    return results;
  }

  Future<List<String>> getGenres(String id) async {
    List<String> genres = [];
    try {
      http.Response response = await http
          .get(Uri.parse(ApiConstants.genresEndPoint(id)), headers: headers);

      List jsonData = jsonDecode(response.body)['genres'];
      for (var genre in jsonData) {
        genres.add(genre['name']);
      }
    } catch (e) {
      // print(e);
    }
    return genres;
  }

  Future<String> fetchMovieTrailer(String id) async {
    try {
      http.Response response = await http
          .get(Uri.parse(ApiConstants.videosEndPoint(id)), headers: headers);

      return jsonDecode(response.body)['results'].first['key'];
    } catch (e) {
      return '';
    }
  }
}

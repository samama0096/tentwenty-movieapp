import 'dart:convert';

class MovieModel {
  final int id;
  final String title;
  final String releaseDate;
  List<int> genres;
  List<String> genresnames = [];
  final String poster;
  final String bg;
  final String lang;
  final String overview;

  MovieModel(
      {required this.id,
      required this.title,
      required this.releaseDate,
      required this.genres,
      required this.poster,
      required this.bg,
      required this.lang,
      required this.overview});

  static MovieModel fromJson(Map json) => MovieModel(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      genres: List<int>.from(json['genre_ids']),
      poster: json['poster_path'] ?? '',
      bg: json['backdrop_path'] ?? '',
      overview: json['overview'],
      lang: json['original_language']);

  static Map<String, dynamic> toJson(MovieModel movie) => {
        'id': movie.id,
        'title': movie.title,
        'release_date': movie.releaseDate,
        'genre_ids': movie.genres,
        'poster_path': movie.poster,
        'backdrop_path': movie.bg,
        'overview': movie.overview,
        'original_language': movie.lang,
      };

  static List<String> movieListToStringList(List<MovieModel> movies) {
    return [...movies.map((movie) => jsonEncode(MovieModel.toJson(movie)))];
  }

  static List<MovieModel> stringListToMovieList(List<String> moviesFromCache) {
    return [
      ...moviesFromCache.map((movie) => MovieModel.fromJson(jsonDecode(movie)))
    ];
  }
}

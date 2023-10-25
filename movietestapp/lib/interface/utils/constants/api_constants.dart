class ApiConstants {
  static String bearer =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZmU5ODA0ZjE2MWUxODZjZGQxMTJiMjI1YmY1ZmQ1ZSIsInN1YiI6IjYxMGJiYzZhZTYxZTZkMDA3NTUwYjQzNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S8F1SNrLapcFGlfdTbMAn_XNCzEcNIc9-h9TDjNWAyo';
  static String apikey = '';

  static Uri upcomingEndpoint = Uri.parse(
    'https://api.themoviedb.org/3/movie/upcoming',
  );
  static String imageEndPoint = 'https://image.tmdb.org/t/p/w500';

  static String genresEndPoint(String id) =>
      'https://api.themoviedb.org/3/movie/$id?language=en-US';
  static String videosEndPoint(String id) =>
      'https://api.themoviedb.org/3/movie/$id/videos?language=en-US';
  static String youTubeEndPoint(String id) =>
      'https://www.youtube.com/watch?v=$id';
  static String searchEndPoint(String query) =>
      'https://api.themoviedb.org/3/search/movie?query=$query&include_adult=false&language=en-US&page=1';
}

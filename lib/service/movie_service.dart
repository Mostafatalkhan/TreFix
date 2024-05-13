import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:treflix/constants.dart';
import 'package:treflix/models/move.dart';

class Api {
  String UpComing =
      'https://api.themoviedb.org/3/movie/upcoming?language=en-US&api_key=${kApiKey}';

  String topRelatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?language=en-US&api_key=${kApiKey}';
  String trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?language=en-US&api_key=${kApiKey}';
  Future<List<Movie>> GetTrendingMovies(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    List<dynamic> data = jsonDecode(response.body)['results'];
    // print(data);
    List<Movie> movieList = [];

    for (int i = 0; i < data.length; i++) {
      movieList.add(
        Movie.fromJson(data[i]),
      );
    }
    // print(movieList);
    return movieList;
  }
}

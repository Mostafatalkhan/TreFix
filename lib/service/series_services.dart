import 'package:dio/dio.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/series.dart';

class SeriesApi {
  String popular = 'https://api.themoviedb.org/3/tv/popular?api_key=${kApiKey}';
  String top_related =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=${kApiKey}';
  String onAir =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=${kApiKey}';
  String AiringToday =
      'https://api.themoviedb.org/3/tv/airing_today?api_key=${kApiKey}';
  Future<List<Series>> getSeries(String url) async {
    final dio = Dio();
    Response response = await dio.get(url);
    List<dynamic> data = response.data['results'];
    if (url == onAir) {
      print('on air status code=${response.statusCode}');
    }
    // print(data.length);
    List<Series> seriesList = [];
    for (int i = 0; i < data.length; i++) {
      seriesList.add(
        Series.fromJson(data[i]),
      );
    }
//    print(seriesList);

    return (seriesList);
  }
}

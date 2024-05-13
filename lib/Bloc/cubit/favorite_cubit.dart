import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:treflix/models/move.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  Icon icon = Icon(Icons.favorite);
  final dio = Dio();
  final String AddDeletemovieType = 'movie';
  final String seriesType = 'tv';
  final String GetmovieType = 'movies';

  void AddandDeleteFavorite(
      {required int id, required String type, required bool state}) async {
    emit(AddFavoriteLoading());
    Response response = await dio.post(
        'https://api.themoviedb.org/3/account/20530924/favorite?api_key=df32c9d4e4029bbd0b739fe0fcc2a3e9',
        data: {"media_type": type, "media_id": id, "favorite": state},
        options: Options(headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZjMyYzlkNGU0MDI5YmJkMGI3MzlmZTBmY2MyYTNlOSIsInN1YiI6IjY1MWRmNmJlYzUwYWQyMDBlYWMwOTk5ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IRzDKxLZSDC3EvXn6hKWkE8_1EfIxYQFwCU2SkzzvYg'
        }));

    var responseBody = response.data;
    print(responseBody['status_message']);

    if (responseBody['success'] == true) {
      emit(AddFavoriteSuccess());
    } else if (responseBody['success'] == false) {
      emit(AddFavoriteFailure());
    }
  }

  Future<List<Movie>> getFavorite({required String type}) async {
    emit(GetFavoriteLoading());
    Response response = await dio.get(
        'https://api.themoviedb.org/3/account/20530924/favorite/${type}?api_key=df32c9d4e4029bbd0b739fe0fcc2a3e9',
        options: Options(headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZjMyYzlkNGU0MDI5YmJkMGI3MzlmZTBmY2MyYTNlOSIsInN1YiI6IjY1MWRmNmJlYzUwYWQyMDBlYWMwOTk5ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IRzDKxLZSDC3EvXn6hKWkE8_1EfIxYQFwCU2SkzzvYg'
        }));

    List<dynamic> responseBody = response.data['results'];
    // print(responseBody);

    List<Movie> dataList = [];

    for (int i = 0; i < responseBody.length; i++) {
      dataList.add(Movie.fromJson(responseBody[i]));
    }
    print(dataList.length);
    if (response.statusCode == 200) {
      emit(GetFavoriteSuccess(movieList: dataList));
    } else {
      emit(GetFavoriteFailure());
    }
    print(response.statusCode);
    return dataList;
  }
}

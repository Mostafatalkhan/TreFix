part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class AddFavoriteSuccess extends FavoriteState {}

final class AddFavoriteFailure extends FavoriteState {}

final class AddFavoriteLoading extends FavoriteState {}

final class GetFavoriteLoading extends FavoriteState {}

// ignore: must_be_immutable
final class GetFavoriteSuccess extends FavoriteState {
  List<Movie> movieList;
  GetFavoriteSuccess({required this.movieList});
}

final class GetFavoriteFailure extends FavoriteState {}

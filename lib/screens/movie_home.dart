import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/favorite_cubit.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/screens/favorite_screens/favorite_home.dart';
import 'package:treflix/widgets/movies_widget/toprelated_movies.dart';
import 'package:treflix/widgets/movies_widget/trending_movies_slider.dart';
import 'package:treflix/widgets/movies_widget/upcoming_movies.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({
    super.key,
  });
  List<Movie>? data;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return BlocConsumer<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await BlocProvider.of<FavoriteCubit>(context)
                      .getFavorite(type: FavoriteCubit().GetmovieType);
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return FavoriteHome(
                        type: FavoriteCubit().AddDeletemovieType,
                        data: data,
                      );
                    },
                  ));
                },
                icon: const Icon(Icons.favorite, color: Colors.red),
              )
            ],
            title: const Text(
              'Treflix',
              style: TextStyle(
                  color: Colors.red, fontFamily: 'Bebas', fontSize: 36),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            // actions: [DarkModeSwitch()],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Trending Movies',
                    style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TrendingMoviesSlider(),
                const SizedBox(
                  height: 24,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Top Rated Movies',
                    style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TopRatedMovies(),
                const SizedBox(
                  height: 24,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'UpComing Movies',
                    style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const UpComingMovies()
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is GetFavoriteSuccess) {
          data = state.movieList;
          // print('done');
        } else if (state is GetFavoriteLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/favorite_cubit.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/screens/favorite_screens/favorite_home.dart';
import 'package:treflix/widgets/series_widget/Popular.dart';
import 'package:treflix/widgets/series_widget/airing_today.dart';
import 'package:treflix/widgets/series_widget/on_air_slider.dart';
import 'package:treflix/widgets/series_widget/top_related.dart';

// ignore: must_be_immutable
class Series_home extends StatelessWidget {
  Series_home({super.key});
  List<Movie>? data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await BlocProvider.of<FavoriteCubit>(context)
                      .getFavorite(type: FavoriteCubit().seriesType);
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return FavoriteHome(
                        type: FavoriteCubit().seriesType,
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
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'On Air Series',
                    style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                onAirSlider(),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Top Rated Series',
                    style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TopRelatedSeries(size: size),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Popular Series',
                    style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                PopularSeries(size: size),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Airing Today Series',
                    style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                AiringTodaySeries(size: size),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is GetFavoriteSuccess) {
          data = state.movieList;
          print('done');
        } else if (state is GetFavoriteLoading) {
          Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

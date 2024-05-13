import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/service/movie_service.dart';
import 'package:treflix/widgets/movies_widget/trending_movies.dart';

// ignore: must_be_immutable
class TrendingMoviesSlider extends StatelessWidget {
  TrendingMoviesSlider({
    super.key,
  });
  // ignore: non_constant_identifier_names
  List<Movie> TrendMovie = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Api().GetTrendingMovies(Api().trendingUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          TrendMovie = snapshot.data!;

          return CarouselSlider.builder(
            options: CarouselOptions(
              enlargeFactor: 0.3,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              autoPlayCurve: Curves.ease,
              viewportFraction: 0.55,
              // height: 300,
              height: size.height * 0.374,

              enlargeCenterPage: true,
              autoPlay: true,
            ),
            itemBuilder: (context, index, pageView) => TrendingMovies(
              TrendMovie: TrendMovie[index],
            ),
            itemCount: TrendMovie.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

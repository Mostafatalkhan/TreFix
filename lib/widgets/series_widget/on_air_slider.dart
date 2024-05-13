import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:treflix/models/series.dart';
import 'package:treflix/service/series_services.dart';
import 'package:treflix/widgets/series_widget/on_air.dart';

// ignore: must_be_immutable, camel_case_types
class onAirSlider extends StatelessWidget {
  onAirSlider({
    super.key,
  });
  List<Series> onAirList = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: SeriesApi().getSeries(SeriesApi().onAir),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          onAirList = snapshot.data!;
          return CarouselSlider.builder(
              itemBuilder: (context, index, realIndex) {
                return onAirSeries(
                  onAirList: onAirList[index],
                );
              },
              itemCount: onAirList.length,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  autoPlayCurve: Curves.ease,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  // height: 300,
                  height: size.height * 0.374,
                  viewportFraction: 0.55));
        } else if (snapshot.hasError) {
          return Text('error${snapshot.error}');
          // } else if (snapshot.data == null) {
          //   return Text('no data');
        } else if (ConnectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else
          // ignore: curly_braces_in_flow_control_structures
          return const Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}

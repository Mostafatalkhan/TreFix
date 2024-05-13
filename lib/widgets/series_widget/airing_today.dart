import 'package:flutter/material.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/series.dart';
import 'package:treflix/screens/series_details.dart';
import 'package:treflix/service/series_services.dart';

// ignore: must_be_immutable
class AiringTodaySeries extends StatelessWidget {
  AiringTodaySeries({
    super.key,
    required this.size,
  });

  final Size size;
  List<Series>? AiringToday = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SeriesApi().getSeries(SeriesApi().AiringToday),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AiringToday = snapshot.data;

          return SizedBox(
            // height: 200,
            height: size.height * 0.249,
            child: ListView.builder(
              itemCount: AiringToday!.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SeriesDetails(
                                  details: AiringToday![index]);
                            },
                          ));
                        },
                        child: Container(
                          height: size.height * 0.25,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                '${kImagePath}${AiringToday![index].poster_path}',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

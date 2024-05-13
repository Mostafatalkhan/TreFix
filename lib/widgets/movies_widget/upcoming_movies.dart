import 'package:flutter/material.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/screens/itemdetails.dart';
import 'package:treflix/service/movie_service.dart';

class UpComingMovies extends StatelessWidget {
  const UpComingMovies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: Api().GetTrendingMovies(Api().UpComing),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Movie> upComingMovies = snapshot.data!;

            return SizedBox(
              // height: 200,
              height: size.height * 0.249,

              child: ListView.builder(
                itemCount: upComingMovies.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                        details: upComingMovies[index])));
                          },
                          child: Container(
                              height: 200,
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  '${kImagePath}${upComingMovies[index].backdropPath}',
                                  fit: BoxFit.cover,
                                ),
                              )),
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
        });
  }
}

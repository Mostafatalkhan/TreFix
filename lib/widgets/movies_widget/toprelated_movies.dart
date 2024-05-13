import 'package:flutter/material.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/screens/itemdetails.dart';
import 'package:treflix/service/movie_service.dart';

// ignore: must_be_immutable
class TopRatedMovies extends StatelessWidget {
  TopRatedMovies({
    super.key,
  });
  List<Movie> relatedMovies = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Api().GetTrendingMovies(Api().topRelatedUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          relatedMovies = snapshot.data!;
          return SizedBox(
            // height: 200,
            height: size.height * 0.249,

            child: ListView.builder(
              itemCount: relatedMovies.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ItemDetails(
                                    details: relatedMovies[index]))));
                      },
                      child: SizedBox(
                          height: size.height * 0.25,

                          // height: 200,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              '$kImagePath${relatedMovies[index].backdropPath}',
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

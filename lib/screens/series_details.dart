import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/favorite_cubit.dart';
import 'package:treflix/Bloc/cubit/video_cubit.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/series.dart';
import 'package:treflix/screens/tube.dart';

// ignore: must_be_immutable
class SeriesDetails extends StatelessWidget {
  SeriesDetails({required this.details, super.key});

  Series details;
  Icon icon = const Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return BlocConsumer<VideoCubit, VideoState>(
          builder: (context, state) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 2, top: 2.0, left: 2),
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: Image.network(
                              '$kImagePath${details.backdrop_path}',
                              fit: BoxFit.fill,
                              height: 440,
                              width: double.infinity,
                            )),
                        Positioned(
                          left: 15,
                          top: 40,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 42, 41, 41),
                                  borderRadius: BorderRadius.circular(6)),
                              width: 37,
                              height: 40,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              )),
                        ),
                        Positioned(
                          top: 400,
                          left: 40,
                          child: Row(
                            children: [
                              Text(
                                details.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<FavoriteCubit>(context)
                                .AddandDeleteFavorite(
                                    state: true,
                                    id: details.id,
                                    type: FavoriteCubit().seriesType);
                          },
                          icon: icon,
                          // color: Colors.red,
                        ),
                        GestureDetector(
                          onTap: () async {
                            String url =
                                await BlocProvider.of<VideoCubit>(context)
                                    .GetVideoLink(
                                        id: details.id,
                                        videoFor: VideoCubit().seiresString);
                            // ignore: use_build_context_synchronously
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Tube(
                                  url: url,
                                );
                              },
                            ));
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.play_arrow,
                              ),
                              Text(
                                'Play Trailer',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Overview',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        details.overview,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'OpenSans'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              'Release date: ${details.first_air_date}',
                              style: const TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                const Text(
                                  'Rating: ',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans', fontSize: 17),
                                ),
                                const Icon(
                                  size: 20,
                                  Icons.star_rate,
                                  color: Colors.amber,
                                ),
                                Text('${(convert(
                                  details.vote_average,
                                ))}/10')
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is GetVideoFailed) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('No Trailer Yet'),
                    backgroundColor: Colors.red,
                  );
                },
              );
            }
          },
        );
      },
      listener: (context, state) {
        if (state is AddFavoriteSuccess) {
          icon = const Icon(
            Icons.favorite,
            color: Colors.red,
          );
        } else if (state is AddFavoriteFailure) {
          debugPrint('error');
        }
      },
    );
  }
}

String convert(dynamic vote) {
  String voteString = vote.toString();
  if (voteString.length > 3) {
    voteString = voteString.substring(0, 3); // Take only the first 3 characters
  }
  return voteString;
}

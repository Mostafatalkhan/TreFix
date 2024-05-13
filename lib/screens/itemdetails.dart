// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treflix/Bloc/cubit/favorite_cubit.dart';
import 'package:treflix/Bloc/cubit/video_cubit.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/screens/tube.dart';

// ignore: must_be_immutable
class ItemDetails extends StatefulWidget {
  ItemDetails({
    required this.details,
    super.key,
  });
  Movie details;
  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  Icon icon = const Icon(
    Icons.favorite_border,
  );
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
                          const EdgeInsets.only(right: 2, left: 2, bottom: 0),
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: Image.network(
                              '$kImagePath${widget.details.backdropPath}',
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
                          child: Row(
                            children: [
                              Text(
                                widget.details.title,
                                style: const TextStyle(
                                    fontSize: 22, fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                          top: 400,
                          left: 40,
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<FavoriteCubit>(context)
                                .AddandDeleteFavorite(
                                    state: true,
                                    id: widget.details.id,
                                    type: FavoriteCubit().AddDeletemovieType);
                          },

                          icon: icon,
                          // color: Colors.red,
                        ),
                        GestureDetector(
                          onTap: () async {
                            String url =
                                await BlocProvider.of<VideoCubit>(context)
                                    .GetVideoLink(
                                        id: widget.details.id,
                                        videoFor: VideoCubit().movieString);
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
                        Padding(
                          padding: EdgeInsets.only(left: 0.0),
                          child: Text(
                            'Overview',
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.details.overview,
                        maxLines: 7,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          overflow: TextOverflow.ellipsis,
                        ),
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
                              'Release date: ${widget.details.releaseDate}',
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
                                Text(
                                    '${convert(widget.details.voteAverage)}/10')
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
          listener: (context, state) {},
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

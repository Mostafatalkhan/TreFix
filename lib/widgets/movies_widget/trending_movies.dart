// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/screens/itemdetails.dart';

// ignore: must_be_immutable
class TrendingMovies extends StatelessWidget {
  TrendingMovies({
    this.TrendMovie,
    super.key,
  });
  Movie? TrendMovie;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ItemDetails(details: TrendMovie!);
            },
          )),
          child: SizedBox(
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '$kImagePath${TrendMovie!.posterPath}',
                  fit: BoxFit.cover,
                ),
              )),
        ),
      ],
    );
  }
}

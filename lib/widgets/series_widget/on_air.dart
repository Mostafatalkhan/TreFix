import 'package:flutter/material.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/series.dart';
import 'package:treflix/screens/series_details.dart';

// ignore: must_be_immutable
class onAirSeries extends StatelessWidget {
  onAirSeries({
    required this.onAirList,
    super.key,
  });
  Series? onAirList;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SeriesDetails(details: onAirList!);
              },
            ));
          },
          child: SizedBox(
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                '$kImagePath${onAirList!.poster_path}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}

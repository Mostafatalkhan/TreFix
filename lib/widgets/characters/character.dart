import 'package:flutter/material.dart';
import 'package:treflix/constants.dart';
import 'package:treflix/models/person.dart';
import 'package:treflix/widgets/characters/slider.dart';

class character extends StatelessWidget {
  const character({
    super.key,
    required this.person,
    required this.size,
  });

  final Person person;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return CharacterSlider(
              details: person.movieWorks,
            );
          },
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Card(
              shadowColor: Colors.white,
              elevation: 10,
              margin: const EdgeInsets.all(1),
              child: Image.network(
                '$kImagePath${person.profile_path}',
                fit: BoxFit.cover,
                height: size.height * 0.37,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 6),
            child: Text(
              person.name,
              style: const TextStyle(fontFamily: 'bebas', fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

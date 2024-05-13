import 'package:flutter/material.dart';
import 'package:treflix/models/person.dart';
import 'package:treflix/service/person_service.dart';
import 'package:treflix/widgets/characters/character.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Treflix',
            style:
                TextStyle(color: Colors.red, fontFamily: 'Bebas', fontSize: 36),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: PersonApi().getPerson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Person> person = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'ACTORS',
                        style: TextStyle(fontFamily: 'ABeeZee', fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: person.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.51,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return character(person: person[index], size: size);
                          }
                          // }
                          ),
                    )
                  ]),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text('Error ${snapshot.error.toString()}');
          }
        },
      ),
    );
  }
}
